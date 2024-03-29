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
include src/threads/CMakeFiles/ssh_threads_shared.dir/depend.make

# Include the progress variables for this target.
include src/threads/CMakeFiles/ssh_threads_shared.dir/progress.make

# Include the compile flags for this target's objects.
include src/threads/CMakeFiles/ssh_threads_shared.dir/flags.make

src/threads/CMakeFiles/ssh_threads_shared.dir/pthread.c.o: src/threads/CMakeFiles/ssh_threads_shared.dir/flags.make
src/threads/CMakeFiles/ssh_threads_shared.dir/pthread.c.o: ../src/threads/pthread.c
	$(CMAKE_COMMAND) -E cmake_progress_report /tmp/libssh-0.7.4/build/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building C object src/threads/CMakeFiles/ssh_threads_shared.dir/pthread.c.o"
	cd /tmp/libssh-0.7.4/build/src/threads && /usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -o CMakeFiles/ssh_threads_shared.dir/pthread.c.o   -c /tmp/libssh-0.7.4/src/threads/pthread.c

src/threads/CMakeFiles/ssh_threads_shared.dir/pthread.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/ssh_threads_shared.dir/pthread.c.i"
	cd /tmp/libssh-0.7.4/build/src/threads && /usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -E /tmp/libssh-0.7.4/src/threads/pthread.c > CMakeFiles/ssh_threads_shared.dir/pthread.c.i

src/threads/CMakeFiles/ssh_threads_shared.dir/pthread.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/ssh_threads_shared.dir/pthread.c.s"
	cd /tmp/libssh-0.7.4/build/src/threads && /usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -S /tmp/libssh-0.7.4/src/threads/pthread.c -o CMakeFiles/ssh_threads_shared.dir/pthread.c.s

src/threads/CMakeFiles/ssh_threads_shared.dir/pthread.c.o.requires:
.PHONY : src/threads/CMakeFiles/ssh_threads_shared.dir/pthread.c.o.requires

src/threads/CMakeFiles/ssh_threads_shared.dir/pthread.c.o.provides: src/threads/CMakeFiles/ssh_threads_shared.dir/pthread.c.o.requires
	$(MAKE) -f src/threads/CMakeFiles/ssh_threads_shared.dir/build.make src/threads/CMakeFiles/ssh_threads_shared.dir/pthread.c.o.provides.build
.PHONY : src/threads/CMakeFiles/ssh_threads_shared.dir/pthread.c.o.provides

src/threads/CMakeFiles/ssh_threads_shared.dir/pthread.c.o.provides.build: src/threads/CMakeFiles/ssh_threads_shared.dir/pthread.c.o

# Object files for target ssh_threads_shared
ssh_threads_shared_OBJECTS = \
"CMakeFiles/ssh_threads_shared.dir/pthread.c.o"

# External object files for target ssh_threads_shared
ssh_threads_shared_EXTERNAL_OBJECTS =

src/threads/libssh_threads.so.4.4.1: src/threads/CMakeFiles/ssh_threads_shared.dir/pthread.c.o
src/threads/libssh_threads.so.4.4.1: src/threads/CMakeFiles/ssh_threads_shared.dir/build.make
src/threads/libssh_threads.so.4.4.1: src/libssh.so.4.4.1
src/threads/libssh_threads.so.4.4.1: /usr/lib/x86_64-linux-gnu/libcrypto.so
src/threads/libssh_threads.so.4.4.1: /usr/lib/x86_64-linux-gnu/libz.so
src/threads/libssh_threads.so.4.4.1: /usr/lib/x86_64-linux-gnu/libgssapi.so
src/threads/libssh_threads.so.4.4.1: /usr/lib/x86_64-linux-gnu/libkrb5.so
src/threads/libssh_threads.so.4.4.1: /usr/lib/x86_64-linux-gnu/libhcrypto.so
src/threads/libssh_threads.so.4.4.1: /usr/lib/x86_64-linux-gnu/libcom_err.so
src/threads/libssh_threads.so.4.4.1: /usr/lib/x86_64-linux-gnu/libheimntlm.so
src/threads/libssh_threads.so.4.4.1: /usr/lib/x86_64-linux-gnu/libhx509.so
src/threads/libssh_threads.so.4.4.1: /usr/lib/x86_64-linux-gnu/libasn1.so
src/threads/libssh_threads.so.4.4.1: /usr/lib/x86_64-linux-gnu/libwind.so
src/threads/libssh_threads.so.4.4.1: src/threads/CMakeFiles/ssh_threads_shared.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking C shared library libssh_threads.so"
	cd /tmp/libssh-0.7.4/build/src/threads && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/ssh_threads_shared.dir/link.txt --verbose=$(VERBOSE)
	cd /tmp/libssh-0.7.4/build/src/threads && $(CMAKE_COMMAND) -E cmake_symlink_library libssh_threads.so.4.4.1 libssh_threads.so.4 libssh_threads.so

src/threads/libssh_threads.so.4: src/threads/libssh_threads.so.4.4.1

src/threads/libssh_threads.so: src/threads/libssh_threads.so.4.4.1

# Rule to build all files generated by this target.
src/threads/CMakeFiles/ssh_threads_shared.dir/build: src/threads/libssh_threads.so
.PHONY : src/threads/CMakeFiles/ssh_threads_shared.dir/build

src/threads/CMakeFiles/ssh_threads_shared.dir/requires: src/threads/CMakeFiles/ssh_threads_shared.dir/pthread.c.o.requires
.PHONY : src/threads/CMakeFiles/ssh_threads_shared.dir/requires

src/threads/CMakeFiles/ssh_threads_shared.dir/clean:
	cd /tmp/libssh-0.7.4/build/src/threads && $(CMAKE_COMMAND) -P CMakeFiles/ssh_threads_shared.dir/cmake_clean.cmake
.PHONY : src/threads/CMakeFiles/ssh_threads_shared.dir/clean

src/threads/CMakeFiles/ssh_threads_shared.dir/depend:
	cd /tmp/libssh-0.7.4/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /tmp/libssh-0.7.4 /tmp/libssh-0.7.4/src/threads /tmp/libssh-0.7.4/build /tmp/libssh-0.7.4/build/src/threads /tmp/libssh-0.7.4/build/src/threads/CMakeFiles/ssh_threads_shared.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : src/threads/CMakeFiles/ssh_threads_shared.dir/depend

