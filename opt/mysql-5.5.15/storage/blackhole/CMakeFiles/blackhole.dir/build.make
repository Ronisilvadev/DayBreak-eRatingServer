# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 2.8

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canoncical targets will work.
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
CMAKE_COMMAND = /usr/local/cmake/bin/cmake

# The command to remove a file.
RM = /usr/local/cmake/bin/cmake -E remove -f

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /opt/mysql-5.5.15

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /opt/mysql-5.5.15

# Include any dependencies generated for this target.
include storage/blackhole/CMakeFiles/blackhole.dir/depend.make

# Include the progress variables for this target.
include storage/blackhole/CMakeFiles/blackhole.dir/progress.make

# Include the compile flags for this target's objects.
include storage/blackhole/CMakeFiles/blackhole.dir/flags.make

storage/blackhole/CMakeFiles/blackhole.dir/ha_blackhole.cc.o: storage/blackhole/CMakeFiles/blackhole.dir/flags.make
storage/blackhole/CMakeFiles/blackhole.dir/ha_blackhole.cc.o: storage/blackhole/ha_blackhole.cc
	$(CMAKE_COMMAND) -E cmake_progress_report /opt/mysql-5.5.15/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object storage/blackhole/CMakeFiles/blackhole.dir/ha_blackhole.cc.o"
	cd /opt/mysql-5.5.15/storage/blackhole && /usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/blackhole.dir/ha_blackhole.cc.o -c /opt/mysql-5.5.15/storage/blackhole/ha_blackhole.cc

storage/blackhole/CMakeFiles/blackhole.dir/ha_blackhole.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/blackhole.dir/ha_blackhole.cc.i"
	cd /opt/mysql-5.5.15/storage/blackhole && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /opt/mysql-5.5.15/storage/blackhole/ha_blackhole.cc > CMakeFiles/blackhole.dir/ha_blackhole.cc.i

storage/blackhole/CMakeFiles/blackhole.dir/ha_blackhole.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/blackhole.dir/ha_blackhole.cc.s"
	cd /opt/mysql-5.5.15/storage/blackhole && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /opt/mysql-5.5.15/storage/blackhole/ha_blackhole.cc -o CMakeFiles/blackhole.dir/ha_blackhole.cc.s

storage/blackhole/CMakeFiles/blackhole.dir/ha_blackhole.cc.o.requires:
.PHONY : storage/blackhole/CMakeFiles/blackhole.dir/ha_blackhole.cc.o.requires

storage/blackhole/CMakeFiles/blackhole.dir/ha_blackhole.cc.o.provides: storage/blackhole/CMakeFiles/blackhole.dir/ha_blackhole.cc.o.requires
	$(MAKE) -f storage/blackhole/CMakeFiles/blackhole.dir/build.make storage/blackhole/CMakeFiles/blackhole.dir/ha_blackhole.cc.o.provides.build
.PHONY : storage/blackhole/CMakeFiles/blackhole.dir/ha_blackhole.cc.o.provides

storage/blackhole/CMakeFiles/blackhole.dir/ha_blackhole.cc.o.provides.build: storage/blackhole/CMakeFiles/blackhole.dir/ha_blackhole.cc.o
.PHONY : storage/blackhole/CMakeFiles/blackhole.dir/ha_blackhole.cc.o.provides.build

# Object files for target blackhole
blackhole_OBJECTS = \
"CMakeFiles/blackhole.dir/ha_blackhole.cc.o"

# External object files for target blackhole
blackhole_EXTERNAL_OBJECTS =

storage/blackhole/ha_blackhole.so: storage/blackhole/CMakeFiles/blackhole.dir/ha_blackhole.cc.o
storage/blackhole/ha_blackhole.so: libservices/libmysqlservices.a
storage/blackhole/ha_blackhole.so: storage/blackhole/CMakeFiles/blackhole.dir/build.make
storage/blackhole/ha_blackhole.so: storage/blackhole/CMakeFiles/blackhole.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking CXX shared module ha_blackhole.so"
	cd /opt/mysql-5.5.15/storage/blackhole && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/blackhole.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
storage/blackhole/CMakeFiles/blackhole.dir/build: storage/blackhole/ha_blackhole.so
.PHONY : storage/blackhole/CMakeFiles/blackhole.dir/build

storage/blackhole/CMakeFiles/blackhole.dir/requires: storage/blackhole/CMakeFiles/blackhole.dir/ha_blackhole.cc.o.requires
.PHONY : storage/blackhole/CMakeFiles/blackhole.dir/requires

storage/blackhole/CMakeFiles/blackhole.dir/clean:
	cd /opt/mysql-5.5.15/storage/blackhole && $(CMAKE_COMMAND) -P CMakeFiles/blackhole.dir/cmake_clean.cmake
.PHONY : storage/blackhole/CMakeFiles/blackhole.dir/clean

storage/blackhole/CMakeFiles/blackhole.dir/depend:
	cd /opt/mysql-5.5.15 && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /opt/mysql-5.5.15 /opt/mysql-5.5.15/storage/blackhole /opt/mysql-5.5.15 /opt/mysql-5.5.15/storage/blackhole /opt/mysql-5.5.15/storage/blackhole/CMakeFiles/blackhole.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : storage/blackhole/CMakeFiles/blackhole.dir/depend

