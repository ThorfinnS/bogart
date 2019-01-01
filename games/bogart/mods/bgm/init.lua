--[[
  bgm
  A background music mod for Minetest
  Copyright (C) 2018 Timothy Peck

  This library is free software; you can redistribute it and/or
  modify it under the terms of the GNU Lesser General Public
  License as published by the Free Software Foundation; either
  version 2.1 of the License, or (at your option) any later version.

  This library is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  Lesser General Public License for more details.

  You should have received a copy of the GNU Lesser General Public
  License along with this library; if not, write to the Free Software
  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301
  USA
--]]

-- nb. I have not tested this on a multiplayer server yet, but I see no reason
-- for it not to work ;)


-- These values get/set the basic mod preferences

-- Every this many seconds there is the following probability that music will start.
local music_try_interval = tonumber(minetest.settings:get("bgm.tryinterval")) or 60
local music_probability = tonumber(minetest.settings:get("bgm.probability")) or 0.2

-- After deciding to play music there is this probability that a time-specific
-- song will be chosen (ie. set to 1 to always play night songs at night etc.)
local music_timed_probability = tonumber(minetest.settings:get("bgm.time_probability")) or 0.5

local music_gain = tonumber(minetest.settings:get("bgm.gain")) or 0.6

-- Make sure the same track isn't played twice in a row. (Ignored when there
-- is only one track in a group)
local music_repeats = minetest.settings:get_bool("bgm.repeats") or false

--[[
These tables list the songs that will be played.
The music must exist as .ogg files in the bgm/sounds directory and the
length of the track (in seconds) must be added. If songs get cut off too soon
then add 1 or 2 seconds - they don't loop so adding extra time will just add
silence.
The gain for each track may be adjusted if it seems too loud/quiet, else the
default music_gain defined above will be used.
--]]

local night_music =	{	{name='our_digital_compass', length=173, gain=music_gain},
				{name='tiptoe_treadline', length=125, gain=music_gain}
			}

local day_music =	{	{name='morning_colorwheel', length=184, gain=music_gain},
				{name='cold_summer', length=229, gain=music_gain},
				{name='low_coal_camper', length=193, gain=music_gain},
				{name='tumblehome', length=193, gain=music_gain},
				{name='passing_station_7', length=180, gain=music_gain}
			}

local twilight_music =	{	{name='cold_summer', length=229, gain=music_gain},
				{name='low_coal_camper', length=193, gain=music_gain}
			}

-- These values are used by mod functions and should not be changed
local music_playing = false
local music_trying = false
local music_handle = {}
local music_lasttrack = ""

-- Mod functions begin here:

-- called by minetest.after when the music time has elapsed for each player
local music_stop = function(player_name)
	if music_handle[player_name] ~= nil then
		minetest.sound_stop(music_handle[player_name])
		music_handle[player_name] = nil
		minetest.debug("Music stopped for ", player_name)
		-- minetest.chat_send_all("music stopped for player " .. player_name)
	end
	local next = next
	if next(music_handle) == nil then
		music_playing = false
		-- minetest.chat_send_all("music stopped for all players")
		minetest.debug("Music stopped for all players")
	end
end

-- Associates a music player handler and starts playback for each player,
-- then after the duration of the track stop the playback
local music_start = function(music_track)
	for _,player in ipairs(minetest.get_connected_players()) do
		local player_name = player:get_player_name()
		if music_handle[player_name] == nil then
			local handler = minetest.sound_play(music_track.name, {to_player=player_name, gain=music_track.gain})
			music_playing = true
			minetest.debug("Started music playing for ", player_name)
			if handler ~= nil then
				music_handle[player_name] = handler
				minetest.after(music_track.length, music_stop, player_name)
			end
		end
	end
end


-- If a player leaves the game then their entry in the music_handle table
-- (if it exists) should be removed
local music_player_left = function(player)
	local next = next
	if next(music_handle) ~= nil then
		local player_name = player:get_player_name()
		if music_handle[player_name] ~= nil then
			music_handle[player_name] = nil
			minetest.debug("Cleaning up music for leaving player ", player_name)
		end
	end
end

-- Randomly choose a song from the given group, honoring the repeats option
local music_choose = function(music_group)
	local music_track = {}
	if #music_group > 1 and not music_repeats then
		repeat
			music_track = music_group[math.random(1,#music_group)]
		until(music_track.name ~= music_lasttrack)
	else
		music_track = music_group[math.random(1,#music_group)]
	end
	music_lasttrack = music_track.name
	return music_track
end

-- After the preset music_try_interval, decide based on music_probability if a
-- song should play, if so find out what time of day it is then choose an
-- appropriate song to play and start playing it (for all players on a server)
local music_try = function()
	local random_try = math.random()
	if random_try < music_probability then
		minetest.debug("Music playback try accepted ", random_try, "<", music_probability)
		local time_of_day = minetest.get_timeofday()
		local music_track = {}
		-- if the game-time is between 21:00 and 06:00 then consider it night
		-- if the game-time is between 19:00 and 21:00 then it's twilight
		-- otherwise it's daytime
		-- (days last from 0.0 to 1.0 so 1 "hour" = 0.0416666666667)
		if time_of_day >= 0.875 or time_of_day <= 0.245 then
			minetest.debug("Time of day is night")
			-- choose a night song (based on music_timed_probability)
			if math.random() <= music_timed_probability then
				music_track = music_choose(night_music)
				minetest.debug("Chosen night music track ", music_track.name)
			else
				music_track = music_choose(day_music)
				minetest.debug("Chosen day music track ", music_track.name)
			end
		elseif time_of_day >= 0.792 and time_of_day < 0.875 then
			minetest.debug("Time of day is twilight")
			-- choose a twilight song (based on music_timed_probability)
			if math.random() <= music_timed_probability then
				music_track = music_choose(twilight_music)
				minetest.debug("Chosen twilight music track ", music_track.name)
			else
				music_track = music_choose(day_music)
				minetest.debug("Chosen day music track ", music_track.name)
			end
		else
			minetest.debug("Time of day is daytime")
			-- choose a daytime song
			music_track = music_choose(day_music)
			minetest.debug("Chosen day track ", music_track.name)
		end
		-- minetest.chat_send_all("Playing song: " .. music_track.name)
		music_start(music_track)
	else
		minetest.debug("Music playback try rejected", random_try, ">", music_probability)
	end
	music_trying = false
end

-- makes sure that players leaving the game are handled cleanly (in theory)
minetest.register_on_leaveplayer(music_player_left)

-- function callback to check if the music is still playing or if
-- it should be restarted
local music_timer = 0
minetest.register_globalstep(function(dtime)
	-- there's no point checking more than once every few seconds
	music_timer = music_timer + dtime
	if music_timer < 5 then
		return
	end
	music_timer = 0

	if music_playing == false then
		if music_trying == false then
			-- minetest.chat_send_all("beginning music try countdown timer")
			minetest.after(music_try_interval, music_try)
			music_trying = true
		end
	else
		return
	end
end)


