cmake . -DRUN_IN_PLACE=1 -DENABLE_GETTEXT=1 -DENABLE_FREETYPE=1 -DENABLE_LEVELDB=1
make -j$(nproc)
echo -e "\n\n\e[1;33mYou can run Minetest again by typing \"minetest\" in a terminal or selecting it in an applications menu.\nYou can install mods in ~/.minetest/mods, too.\e[0m"