# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.0

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
CMAKE_SOURCE_DIR = /tmp/libssh-0.7.4

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /tmp/libssh-0.7.4/build

# Include any dependencies generated for this target.
include examples/CMakeFiles/proxy.dir/depend.make

# Include the progress variables for this target.
include examples/CMakeFiles/proxy.dir/progress.make

# Include the compile flags for this target's objects.
include examples/CMakeFiles/proxy.dir/flags.make

examples/CMakeFiles/proxy.dir/proxy.c.o: examples/CMakeFiles/proxy.dir/flags.make
examples/CMakeFiles/proxy.dir/proxy.c.o: ../examples/proxy.c
	$(CMAKE_COMMAND) -E cmake_progress_report /tmp/libssh-0.7.4/build/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building C object examples/CMakeFiles/proxy.dir/proxy.c.o"
	cd /tmp/libssh-0.7.4/build/examples && /usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -o CMakeFiles/proxy.dir/proxy.c.o   -c /tmp/libssh-0.7.4/examples/proxy.c

examples/CMakeFiles/proxy.dir/proxy.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/proxy.dir/proxy.c.i"
	cd /tmp/libssh-0.7.4/build/examples && /usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -E /tmp/libssh-0.7.4/examples/proxy.c > CMakeFiles/proxy.dir/proxy.c.i

examples/CMakeFiles/proxy.dir/proxy.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/proxy.dir/proxy.c.s"
	cd /tmp/libssh-0.7.4/build/examples && /usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -S /tmp/libssh-0.7.4/examples/proxy.c -o CMakeFiles/proxy.dir/proxy.c.s

examples/CMakeFiles/proxy.dir/proxy.c.o.requires:
.PHONY : examples/CMakeFiles/proxy.dir/proxy.c.o.requires

examples/CMakeFiles/proxy.dir/proxy.c.o.provides: examples/CMakeFiles/proxy.dir/proxy.c.o.requires
	$(MAKE) -f examples/CMakeFiles/proxy.dir/build.make examples/CMakeFiles/proxy.dir/proxy.c.o.provides.build
.PHONY : examples/CMakeFiles/proxy.dir/proxy.c.o.provides

examples/CMakeFiles/proxy.dir/proxy.c.o.provides.build: examples/CMakeFiles/proxy.dir/proxy.c.o

# Object files for target proxy
proxy_OBJECTS = \
"CMakeFiles/proxy.dir/proxy.c.o"

# External object files for target proxy
proxy_EXTERNAL_OBJECTS =

examples/proxy: examples/CMakeFiles/proxy.dir/proxy.c.o
examples/proxy: examples/CMakeFiles/proxy.dir/build.make
examples/proxy: src/libssh.so.4.4.1
examples/proxy: /usr/lib/x86_64-linux-gnu/libcrypto.so
examples/proxy: /usr/lib/x86_64-linux-gnu/libz.so
examples/proxy: /usr/lib/x86_64-linux-gnu/libgssapi.so
examples/proxy: /usr/lib/x86_64-linux-gnu/libkrb5.so
examples/proxy: /usr/lib/x86_64-linux-gnu/libhcrypto.so
examples/proxy: /usr/lib/x86_64-linux-gnu/libcom_err.so
examples/proxy: /usr/lib/x86_64-linux-gnu/libheimntlm.so
examples/proxy: /usr/lib/x86_64-linux-gnu/libhx509.so
examples/proxy: /usr/lib/x86_64-linux-gnu/libasn1.so
examples/proxy: /usr/lib/x86_64-linux-gnu/libwind.so
examples/proxy: examples/CMakeFiles/proxy.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking C executable proxy"
	cd /tmp/libssh-0.7.4/build/examples && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/proxy.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
examples/CMakeFiles/proxy.dir/build: examples/proxy
.PHONY : examples/CMakeFiles/proxy.dir/build

examples/CMakeFiles/proxy.dir/requires: examples/CMakeFiles/proxy.dir/proxy.c.o.requires
.PHONY : examples/CMakeFiles/proxy.dir/requires

examples/CMakeFiles/proxy.dir/clean:
	cd /tmp/libssh-0.7.4/build/examples && $(CMAKE_COMMAND) -P CMakeFiles/proxy.dir/cmake_clean.cmake
.PHONY : examples/CMakeFiles/proxy.dir/clean

examples/CMakeFiles/proxy.dir/depend:
	cd /tmp/libssh-0.7.4/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /tmp/libssh-0.7.4 /tmp/libssh-0.7.4/examples /tmp/libssh-0.7.4/build /tmp/libssh-0.7.4/build/examples /tmp/libssh-0.7.4/build/examples/CMakeFiles/proxy.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : examples/CMakeFiles/proxy.dir/depend
