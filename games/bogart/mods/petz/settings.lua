local modpath, S = ...

local settings = Settings(modpath .. "/petz.conf")

petz.settings.type_model = settings:get("type_model", "mesh")
petz.settings.tamagochi_mode = settings:get_bool("tamagochi_mode", true)
petz.settings.tamagochi_check_time = tonumber(settings:get("tamagochi_check_time"))
petz.settings.tamagochi_hunger_damage = tonumber(settings:get("tamagochi_hunger_damage"))
petz.settings.type_api = settings:get("type_api", "mobs_redo")
petz.settings.kitty_spawn = settings:get_bool("kitty_spawn", true)
petz.settings.kitty_follow = settings:get("kitty_follow", "")
petz.settings.kitty_food = settings:get("kitty_food", "")
petz.settings.kitty_favorite_food = settings:get("kitty_favorite_food", "")
petz.settings.puppy_spawn = settings:get_bool("puppy_spawn", true)
petz.settings.puppy_follow = settings:get("puppy_follow", "")
petz.settings.puppy_food = settings:get("puppy_food", "")
petz.settings.puppy_favorite_food = settings:get("puppy_favorite_food", "")

if petz.settings.type_model == "mesh" then
    petz.settings.visual = "mesh"
    petz.settings.visual_size = {x=15.0, y=15.0}
    petz.settings.rotate = 0
else -- is 'cubic'
    petz.settings.visual = "wielditem"
    petz.settings.visual_size = {x=1.0, y=1.0}
    petz.settings.rotate = 180
end