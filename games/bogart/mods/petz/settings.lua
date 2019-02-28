local modpath, S = ...

local settings = Settings(modpath .. "/petz.conf")

petz.settings.type_model = settings:get("type_model", "mesh")
petz.settings.type_api = settings:get("type_api", "mobs_redo")
petz.settings.kitty_spawn = settings:get_bool("kitty_spawn", true)
petz.settings.kitty_follow = settings:get("kitty_follow", "")
petz.settings.kitty_food = settings:get("kitty_food", "")
petz.settings.puppy_spawn = settings:get_bool("puppy_spawn", true)
petz.settings.puppy_follow = settings:get("puppy_follow", "")
petz.settings.puppy_food = settings:get("puppy_food", "")