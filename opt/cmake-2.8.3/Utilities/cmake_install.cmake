# Install script for directory: /opt/cmake-2.8.3/Utilities

# Set the install prefix
IF(NOT DEFINED CMAKE_INSTALL_PREFIX)
  SET(CMAKE_INSTALL_PREFIX "/usr/local/cmake")
ENDIF(NOT DEFINED CMAKE_INSTALL_PREFIX)
STRING(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
IF(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  IF(BUILD_TYPE)
    STRING(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  ELSE(BUILD_TYPE)
    SET(CMAKE_INSTALL_CONFIG_NAME "")
  ENDIF(BUILD_TYPE)
  MESSAGE(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
ENDIF(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)

# Set the component getting installed.
IF(NOT CMAKE_INSTALL_COMPONENT)
  IF(COMPONENT)
    MESSAGE(STATUS "Install component: \"${COMPONENT}\"")
    SET(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  ELSE(COMPONENT)
    SET(CMAKE_INSTALL_COMPONENT)
  ENDIF(COMPONENT)
ENDIF(NOT CMAKE_INSTALL_COMPONENT)

# Install shared libraries without execute permission?
IF(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  SET(CMAKE_INSTALL_SO_NO_EXE "0")
ENDIF(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/man/man1" TYPE FILE FILES
    "/opt/cmake-2.8.3/Docs/cmake.1"
    "/opt/cmake-2.8.3/Docs/cmakecommands.1"
    "/opt/cmake-2.8.3/Docs/cmakecompat.1"
    "/opt/cmake-2.8.3/Docs/cmakeprops.1"
    "/opt/cmake-2.8.3/Docs/cmakepolicies.1"
    "/opt/cmake-2.8.3/Docs/cmakevars.1"
    "/opt/cmake-2.8.3/Docs/cmakemodules.1"
    "/opt/cmake-2.8.3/Docs/ctest.1"
    "/opt/cmake-2.8.3/Docs/cpack.1"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/doc/cmake-2.8" TYPE FILE FILES
    "/opt/cmake-2.8.3/Docs/cmake.html"
    "/opt/cmake-2.8.3/Docs/cmake-policies.html"
    "/opt/cmake-2.8.3/Docs/cmake-properties.html"
    "/opt/cmake-2.8.3/Docs/cmake-variables.html"
    "/opt/cmake-2.8.3/Docs/cmake-modules.html"
    "/opt/cmake-2.8.3/Docs/cmake-commands.html"
    "/opt/cmake-2.8.3/Docs/cmake-compatcommands.html"
    "/opt/cmake-2.8.3/Docs/ctest.html"
    "/opt/cmake-2.8.3/Docs/cpack.html"
    "/opt/cmake-2.8.3/Docs/cmake.txt"
    "/opt/cmake-2.8.3/Docs/cmake.docbook"
    "/opt/cmake-2.8.3/Docs/cmake-policies.txt"
    "/opt/cmake-2.8.3/Docs/cmake-properties.txt"
    "/opt/cmake-2.8.3/Docs/cmake-variables.txt"
    "/opt/cmake-2.8.3/Docs/cmake-modules.txt"
    "/opt/cmake-2.8.3/Docs/cmake-commands.txt"
    "/opt/cmake-2.8.3/Docs/cmake-compatcommands.txt"
    "/opt/cmake-2.8.3/Docs/ctest.txt"
    "/opt/cmake-2.8.3/Docs/ctest.docbook"
    "/opt/cmake-2.8.3/Docs/cpack.txt"
    "/opt/cmake-2.8.3/Docs/cpack.docbook"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  INCLUDE("/opt/cmake-2.8.3/Utilities/Doxygen/cmake_install.cmake")
  INCLUDE("/opt/cmake-2.8.3/Utilities/KWStyle/cmake_install.cmake")

ENDIF(NOT CMAKE_INSTALL_LOCAL_ONLY)

