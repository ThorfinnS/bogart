# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.7

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /opt/minetest

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /opt/minetest

# Include any dependencies generated for this target.
include src/cguittfont/CMakeFiles/cguittfont.dir/depend.make

# Include the progress variables for this target.
include src/cguittfont/CMakeFiles/cguittfont.dir/progress.make

# Include the compile flags for this target's objects.
include src/cguittfont/CMakeFiles/cguittfont.dir/flags.make

src/cguittfont/CMakeFiles/cguittfont.dir/xCGUITTFont.cpp.o: src/cguittfont/CMakeFiles/cguittfont.dir/flags.make
src/cguittfont/CMakeFiles/cguittfont.dir/xCGUITTFont.cpp.o: src/cguittfont/xCGUITTFont.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/opt/minetest/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object src/cguittfont/CMakeFiles/cguittfont.dir/xCGUITTFont.cpp.o"
	cd /opt/minetest/src/cguittfont && /usr/bin/c++   $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/cguittfont.dir/xCGUITTFont.cpp.o -c /opt/minetest/src/cguittfont/xCGUITTFont.cpp

src/cguittfont/CMakeFiles/cguittfont.dir/xCGUITTFont.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/cguittfont.dir/xCGUITTFont.cpp.i"
	cd /opt/minetest/src/cguittfont && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /opt/minetest/src/cguittfont/xCGUITTFont.cpp > CMakeFiles/cguittfont.dir/xCGUITTFont.cpp.i

src/cguittfont/CMakeFiles/cguittfont.dir/xCGUITTFont.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/cguittfont.dir/xCGUITTFont.cpp.s"
	cd /opt/minetest/src/cguittfont && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /opt/minetest/src/cguittfont/xCGUITTFont.cpp -o CMakeFiles/cguittfont.dir/xCGUITTFont.cpp.s

src/cguittfont/CMakeFiles/cguittfont.dir/xCGUITTFont.cpp.o.requires:

.PHONY : src/cguittfont/CMakeFiles/cguittfont.dir/xCGUITTFont.cpp.o.requires

src/cguittfont/CMakeFiles/cguittfont.dir/xCGUITTFont.cpp.o.provides: src/cguittfont/CMakeFiles/cguittfont.dir/xCGUITTFont.cpp.o.requires
	$(MAKE) -f src/cguittfont/CMakeFiles/cguittfont.dir/build.make src/cguittfont/CMakeFiles/cguittfont.dir/xCGUITTFont.cpp.o.provides.build
.PHONY : src/cguittfont/CMakeFiles/cguittfont.dir/xCGUITTFont.cpp.o.provides

src/cguittfont/CMakeFiles/cguittfont.dir/xCGUITTFont.cpp.o.provides.build: src/cguittfont/CMakeFiles/cguittfont.dir/xCGUITTFont.cpp.o


# Object files for target cguittfont
cguittfont_OBJECTS = \
"CMakeFiles/cguittfont.dir/xCGUITTFont.cpp.o"

# External object files for target cguittfont
cguittfont_EXTERNAL_OBJECTS =

src/cguittfont/libcguittfont.a: src/cguittfont/CMakeFiles/cguittfont.dir/xCGUITTFont.cpp.o
src/cguittfont/libcguittfont.a: src/cguittfont/CMakeFiles/cguittfont.dir/build.make
src/cguittfont/libcguittfont.a: src/cguittfont/CMakeFiles/cguittfont.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/opt/minetest/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX static library libcguittfont.a"
	cd /opt/minetest/src/cguittfont && $(CMAKE_COMMAND) -P CMakeFiles/cguittfont.dir/cmake_clean_target.cmake
	cd /opt/minetest/src/cguittfont && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/cguittfont.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
src/cguittfont/CMakeFiles/cguittfont.dir/build: src/cguittfont/libcguittfont.a

.PHONY : src/cguittfont/CMakeFiles/cguittfont.dir/build

src/cguittfont/CMakeFiles/cguittfont.dir/requires: src/cguittfont/CMakeFiles/cguittfont.dir/xCGUITTFont.cpp.o.requires

.PHONY : src/cguittfont/CMakeFiles/cguittfont.dir/requires

src/cguittfont/CMakeFiles/cguittfont.dir/clean:
	cd /opt/minetest/src/cguittfont && $(CMAKE_COMMAND) -P CMakeFiles/cguittfont.dir/cmake_clean.cmake
.PHONY : src/cguittfont/CMakeFiles/cguittfont.dir/clean

src/cguittfont/CMakeFiles/cguittfont.dir/depend:
	cd /opt/minetest && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /opt/minetest /opt/minetest/src/cguittfont /opt/minetest /opt/minetest/src/cguittfont /opt/minetest/src/cguittfont/CMakeFiles/cguittfont.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : src/cguittfont/CMakeFiles/cguittfont.dir/depend

