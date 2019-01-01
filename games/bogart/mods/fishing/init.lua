local modname = "fishing"

local modpath = minetest.get_modpath(modname)

-- Load support for intllib.
local S, NS = dofile(modpath .. "/intllib.lua")

assert(loadfile(modpath .. "/fishing.lua"))(modpath, S)
