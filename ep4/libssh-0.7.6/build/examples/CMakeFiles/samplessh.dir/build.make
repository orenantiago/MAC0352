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
CMAKE_SOURCE_DIR = /tmp/libssh-0.7.6

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /tmp/libssh-0.7.6/build

# Include any dependencies generated for this target.
include examples/CMakeFiles/samplessh.dir/depend.make

# Include the progress variables for this target.
include examples/CMakeFiles/samplessh.dir/progress.make

# Include the compile flags for this target's objects.
include examples/CMakeFiles/samplessh.dir/flags.make

examples/CMakeFiles/samplessh.dir/sample.c.o: examples/CMakeFiles/samplessh.dir/flags.make
examples/CMakeFiles/samplessh.dir/sample.c.o: ../examples/sample.c
	$(CMAKE_COMMAND) -E cmake_progress_report /tmp/libssh-0.7.6/build/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building C object examples/CMakeFiles/samplessh.dir/sample.c.o"
	cd /tmp/libssh-0.7.6/build/examples && /usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -o CMakeFiles/samplessh.dir/sample.c.o   -c /tmp/libssh-0.7.6/examples/sample.c

examples/CMakeFiles/samplessh.dir/sample.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/samplessh.dir/sample.c.i"
	cd /tmp/libssh-0.7.6/build/examples && /usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -E /tmp/libssh-0.7.6/examples/sample.c > CMakeFiles/samplessh.dir/sample.c.i

examples/CMakeFiles/samplessh.dir/sample.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/samplessh.dir/sample.c.s"
	cd /tmp/libssh-0.7.6/build/examples && /usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -S /tmp/libssh-0.7.6/examples/sample.c -o CMakeFiles/samplessh.dir/sample.c.s

examples/CMakeFiles/samplessh.dir/sample.c.o.requires:
.PHONY : examples/CMakeFiles/samplessh.dir/sample.c.o.requires

examples/CMakeFiles/samplessh.dir/sample.c.o.provides: examples/CMakeFiles/samplessh.dir/sample.c.o.requires
	$(MAKE) -f examples/CMakeFiles/samplessh.dir/build.make examples/CMakeFiles/samplessh.dir/sample.c.o.provides.build
.PHONY : examples/CMakeFiles/samplessh.dir/sample.c.o.provides

examples/CMakeFiles/samplessh.dir/sample.c.o.provides.build: examples/CMakeFiles/samplessh.dir/sample.c.o

examples/CMakeFiles/samplessh.dir/authentication.c.o: examples/CMakeFiles/samplessh.dir/flags.make
examples/CMakeFiles/samplessh.dir/authentication.c.o: ../examples/authentication.c
	$(CMAKE_COMMAND) -E cmake_progress_report /tmp/libssh-0.7.6/build/CMakeFiles $(CMAKE_PROGRESS_2)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building C object examples/CMakeFiles/samplessh.dir/authentication.c.o"
	cd /tmp/libssh-0.7.6/build/examples && /usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -o CMakeFiles/samplessh.dir/authentication.c.o   -c /tmp/libssh-0.7.6/examples/authentication.c

examples/CMakeFiles/samplessh.dir/authentication.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/samplessh.dir/authentication.c.i"
	cd /tmp/libssh-0.7.6/build/examples && /usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -E /tmp/libssh-0.7.6/examples/authentication.c > CMakeFiles/samplessh.dir/authentication.c.i

examples/CMakeFiles/samplessh.dir/authentication.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/samplessh.dir/authentication.c.s"
	cd /tmp/libssh-0.7.6/build/examples && /usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -S /tmp/libssh-0.7.6/examples/authentication.c -o CMakeFiles/samplessh.dir/authentication.c.s

examples/CMakeFiles/samplessh.dir/authentication.c.o.requires:
.PHONY : examples/CMakeFiles/samplessh.dir/authentication.c.o.requires

examples/CMakeFiles/samplessh.dir/authentication.c.o.provides: examples/CMakeFiles/samplessh.dir/authentication.c.o.requires
	$(MAKE) -f examples/CMakeFiles/samplessh.dir/build.make examples/CMakeFiles/samplessh.dir/authentication.c.o.provides.build
.PHONY : examples/CMakeFiles/samplessh.dir/authentication.c.o.provides

examples/CMakeFiles/samplessh.dir/authentication.c.o.provides.build: examples/CMakeFiles/samplessh.dir/authentication.c.o

examples/CMakeFiles/samplessh.dir/knownhosts.c.o: examples/CMakeFiles/samplessh.dir/flags.make
examples/CMakeFiles/samplessh.dir/knownhosts.c.o: ../examples/knownhosts.c
	$(CMAKE_COMMAND) -E cmake_progress_report /tmp/libssh-0.7.6/build/CMakeFiles $(CMAKE_PROGRESS_3)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building C object examples/CMakeFiles/samplessh.dir/knownhosts.c.o"
	cd /tmp/libssh-0.7.6/build/examples && /usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -o CMakeFiles/samplessh.dir/knownhosts.c.o   -c /tmp/libssh-0.7.6/examples/knownhosts.c

examples/CMakeFiles/samplessh.dir/knownhosts.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/samplessh.dir/knownhosts.c.i"
	cd /tmp/libssh-0.7.6/build/examples && /usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -E /tmp/libssh-0.7.6/examples/knownhosts.c > CMakeFiles/samplessh.dir/knownhosts.c.i

examples/CMakeFiles/samplessh.dir/knownhosts.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/samplessh.dir/knownhosts.c.s"
	cd /tmp/libssh-0.7.6/build/examples && /usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -S /tmp/libssh-0.7.6/examples/knownhosts.c -o CMakeFiles/samplessh.dir/knownhosts.c.s

examples/CMakeFiles/samplessh.dir/knownhosts.c.o.requires:
.PHONY : examples/CMakeFiles/samplessh.dir/knownhosts.c.o.requires

examples/CMakeFiles/samplessh.dir/knownhosts.c.o.provides: examples/CMakeFiles/samplessh.dir/knownhosts.c.o.requires
	$(MAKE) -f examples/CMakeFiles/samplessh.dir/build.make examples/CMakeFiles/samplessh.dir/knownhosts.c.o.provides.build
.PHONY : examples/CMakeFiles/samplessh.dir/knownhosts.c.o.provides

examples/CMakeFiles/samplessh.dir/knownhosts.c.o.provides.build: examples/CMakeFiles/samplessh.dir/knownhosts.c.o

examples/CMakeFiles/samplessh.dir/connect_ssh.c.o: examples/CMakeFiles/samplessh.dir/flags.make
examples/CMakeFiles/samplessh.dir/connect_ssh.c.o: ../examples/connect_ssh.c
	$(CMAKE_COMMAND) -E cmake_progress_report /tmp/libssh-0.7.6/build/CMakeFiles $(CMAKE_PROGRESS_4)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building C object examples/CMakeFiles/samplessh.dir/connect_ssh.c.o"
	cd /tmp/libssh-0.7.6/build/examples && /usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -o CMakeFiles/samplessh.dir/connect_ssh.c.o   -c /tmp/libssh-0.7.6/examples/connect_ssh.c

examples/CMakeFiles/samplessh.dir/connect_ssh.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/samplessh.dir/connect_ssh.c.i"
	cd /tmp/libssh-0.7.6/build/examples && /usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -E /tmp/libssh-0.7.6/examples/connect_ssh.c > CMakeFiles/samplessh.dir/connect_ssh.c.i

examples/CMakeFiles/samplessh.dir/connect_ssh.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/samplessh.dir/connect_ssh.c.s"
	cd /tmp/libssh-0.7.6/build/examples && /usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -S /tmp/libssh-0.7.6/examples/connect_ssh.c -o CMakeFiles/samplessh.dir/connect_ssh.c.s

examples/CMakeFiles/samplessh.dir/connect_ssh.c.o.requires:
.PHONY : examples/CMakeFiles/samplessh.dir/connect_ssh.c.o.requires

examples/CMakeFiles/samplessh.dir/connect_ssh.c.o.provides: examples/CMakeFiles/samplessh.dir/connect_ssh.c.o.requires
	$(MAKE) -f examples/CMakeFiles/samplessh.dir/build.make examples/CMakeFiles/samplessh.dir/connect_ssh.c.o.provides.build
.PHONY : examples/CMakeFiles/samplessh.dir/connect_ssh.c.o.provides

examples/CMakeFiles/samplessh.dir/connect_ssh.c.o.provides.build: examples/CMakeFiles/samplessh.dir/connect_ssh.c.o

# Object files for target samplessh
samplessh_OBJECTS = \
"CMakeFiles/samplessh.dir/sample.c.o" \
"CMakeFiles/samplessh.dir/authentication.c.o" \
"CMakeFiles/samplessh.dir/knownhosts.c.o" \
"CMakeFiles/samplessh.dir/connect_ssh.c.o"

# External object files for target samplessh
samplessh_EXTERNAL_OBJECTS =

examples/samplessh: examples/CMakeFiles/samplessh.dir/sample.c.o
examples/samplessh: examples/CMakeFiles/samplessh.dir/authentication.c.o
examples/samplessh: examples/CMakeFiles/samplessh.dir/knownhosts.c.o
examples/samplessh: examples/CMakeFiles/samplessh.dir/connect_ssh.c.o
examples/samplessh: examples/CMakeFiles/samplessh.dir/build.make
examples/samplessh: src/libssh.so.4.4.3
examples/samplessh: /usr/lib/x86_64-linux-gnu/libcrypto.so
examples/samplessh: /usr/lib/x86_64-linux-gnu/libcrypto.so
examples/samplessh: /usr/lib/x86_64-linux-gnu/libz.so
examples/samplessh: /usr/lib/x86_64-linux-gnu/libgssapi.so
examples/samplessh: /usr/lib/x86_64-linux-gnu/libkrb5.so
examples/samplessh: /usr/lib/x86_64-linux-gnu/libhcrypto.so
examples/samplessh: /usr/lib/x86_64-linux-gnu/libcom_err.so
examples/samplessh: /usr/lib/x86_64-linux-gnu/libheimntlm.so
examples/samplessh: /usr/lib/x86_64-linux-gnu/libhx509.so
examples/samplessh: /usr/lib/x86_64-linux-gnu/libasn1.so
examples/samplessh: /usr/lib/x86_64-linux-gnu/libwind.so
examples/samplessh: examples/CMakeFiles/samplessh.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking C executable samplessh"
	cd /tmp/libssh-0.7.6/build/examples && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/samplessh.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
examples/CMakeFiles/samplessh.dir/build: examples/samplessh
.PHONY : examples/CMakeFiles/samplessh.dir/build

examples/CMakeFiles/samplessh.dir/requires: examples/CMakeFiles/samplessh.dir/sample.c.o.requires
examples/CMakeFiles/samplessh.dir/requires: examples/CMakeFiles/samplessh.dir/authentication.c.o.requires
examples/CMakeFiles/samplessh.dir/requires: examples/CMakeFiles/samplessh.dir/knownhosts.c.o.requires
examples/CMakeFiles/samplessh.dir/requires: examples/CMakeFiles/samplessh.dir/connect_ssh.c.o.requires
.PHONY : examples/CMakeFiles/samplessh.dir/requires

examples/CMakeFiles/samplessh.dir/clean:
	cd /tmp/libssh-0.7.6/build/examples && $(CMAKE_COMMAND) -P CMakeFiles/samplessh.dir/cmake_clean.cmake
.PHONY : examples/CMakeFiles/samplessh.dir/clean

examples/CMakeFiles/samplessh.dir/depend:
	cd /tmp/libssh-0.7.6/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /tmp/libssh-0.7.6 /tmp/libssh-0.7.6/examples /tmp/libssh-0.7.6/build /tmp/libssh-0.7.6/build/examples /tmp/libssh-0.7.6/build/examples/CMakeFiles/samplessh.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : examples/CMakeFiles/samplessh.dir/depend

