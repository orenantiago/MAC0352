# Install script for directory: /tmp/libssh-0.7.6/include/libssh

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Debug")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "headers")
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/usr/include/libssh/callbacks.h;/usr/include/libssh/libssh.h;/usr/include/libssh/ssh2.h;/usr/include/libssh/legacy.h;/usr/include/libssh/libsshpp.hpp;/usr/include/libssh/sftp.h;/usr/include/libssh/server.h")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/usr/include/libssh" TYPE FILE FILES
    "/tmp/libssh-0.7.6/include/libssh/callbacks.h"
    "/tmp/libssh-0.7.6/include/libssh/libssh.h"
    "/tmp/libssh-0.7.6/include/libssh/ssh2.h"
    "/tmp/libssh-0.7.6/include/libssh/legacy.h"
    "/tmp/libssh-0.7.6/include/libssh/libsshpp.hpp"
    "/tmp/libssh-0.7.6/include/libssh/sftp.h"
    "/tmp/libssh-0.7.6/include/libssh/server.h"
    )
endif()

