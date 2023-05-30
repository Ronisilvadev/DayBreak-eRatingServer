
#=============================================================================
# Copyright 2007-2009 Kitware, Inc.
#
# Distributed under the OSI-approved BSD License (the "License");
# see accompanying file Copyright.txt for details.
#
# This software is distributed WITHOUT ANY WARRANTY; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the License for more information.
#=============================================================================
# (To distribute this file outside of CMake, substitute the full
#  License text for the above reference.)

MESSAGE(STATUS "Loaded CMakeASM${ASM_DIALECT}Information - ASM${ASM_DIALECT} support is still experimental, please report issues")

IF(UNIX)
  SET(CMAKE_ASM${ASM_DIALECT}_OUTPUT_EXTENSION .o)
ELSE(UNIX)
  SET(CMAKE_ASM${ASM_DIALECT}_OUTPUT_EXTENSION .obj)
ENDIF(UNIX)

SET(CMAKE_INCLUDE_FLAG_ASM${ASM_DIALECT} "-I")       # -I
SET(CMAKE_BASE_NAME)
GET_FILENAME_COMPONENT(CMAKE_BASE_NAME "${CMAKE_ASM${ASM_DIALECT}_COMPILER}" NAME_WE)

IF("${CMAKE_BASE_NAME}" STREQUAL "as")
  SET(CMAKE_BASE_NAME gas)
ENDIF("${CMAKE_BASE_NAME}" STREQUAL "as")

# Load compiler-specific information.
SET(_INCLUDED_FILE "")
IF(CMAKE_ASM${ASM_DIALECT}_COMPILER_ID)
  INCLUDE(Compiler/${CMAKE_ASM${ASM_DIALECT}_COMPILER_ID}-ASM${ASM_DIALECT} OPTIONAL  RESULT_VARIABLE _INCLUDED_FILE)
ENDIF(CMAKE_ASM${ASM_DIALECT}_COMPILER_ID)
IF(NOT _INCLUDED_FILE)
  INCLUDE(Platform/${CMAKE_BASE_NAME} OPTIONAL)
ENDIF(NOT _INCLUDED_FILE)

IF(CMAKE_SYSTEM_PROCESSOR)
  INCLUDE(Platform/${CMAKE_SYSTEM_NAME}-${CMAKE_ASM${ASM_DIALECT}_COMPILER_ID}-ASM${ASM_DIALECT}-${CMAKE_SYSTEM_PROCESSOR} OPTIONAL  RESULT_VARIABLE _INCLUDED_FILE)
  IF(NOT _INCLUDED_FILE)
    INCLUDE(Platform/${CMAKE_SYSTEM_NAME}-${CMAKE_BASE_NAME}-${CMAKE_SYSTEM_PROCESSOR} OPTIONAL)
  ENDIF(NOT _INCLUDED_FILE)
ENDIF(CMAKE_SYSTEM_PROCESSOR)

INCLUDE(Platform/${CMAKE_SYSTEM_NAME}-${CMAKE_ASM${ASM_DIALECT}_COMPILER_ID}-ASM${ASM_DIALECT} OPTIONAL  RESULT_VARIABLE _INCLUDED_FILE)
IF(NOT _INCLUDED_FILE)
  INCLUDE(Platform/${CMAKE_SYSTEM_NAME}-${CMAKE_BASE_NAME} OPTIONAL)
ENDIF(NOT _INCLUDED_FILE)

# Set default assembler file extensions:
IF(NOT CMAKE_ASM${ASM_DIALECT}_SOURCE_FILE_EXTENSIONS)
  SET(CMAKE_ASM${ASM_DIALECT}_SOURCE_FILE_EXTENSIONS s;S;asm)
ENDIF(NOT CMAKE_ASM${ASM_DIALECT}_SOURCE_FILE_EXTENSIONS)


# Support for CMAKE_ASM${ASM_DIALECT}_FLAGS_INIT and friends:
SET(CMAKE_ASM${ASM_DIALECT}_FLAGS_INIT "$ENV{ASM${ASM_DIALECT}FLAGS} ${CMAKE_ASM${ASM_DIALECT}_FLAGS_INIT}")
# avoid just having a space as the initial value for the cache
IF(CMAKE_ASM${ASM_DIALECT}_FLAGS_INIT STREQUAL " ")
  SET(CMAKE_ASM${ASM_DIALECT}_FLAGS_INIT)
ENDIF(CMAKE_ASM${ASM_DIALECT}_FLAGS_INIT STREQUAL " ")
SET (CMAKE_ASM${ASM_DIALECT}_FLAGS "${CMAKE_ASM${ASM_DIALECT}_FLAGS_INIT}" CACHE STRING
     "Flags used by the assembler during all build types.")

IF(NOT CMAKE_NOT_USING_CONFIG_FLAGS)
# default build type is none
  IF(NOT CMAKE_NO_BUILD_TYPE)
    SET (CMAKE_BUILD_TYPE ${CMAKE_BUILD_TYPE_INIT} CACHE STRING
      "Choose the type of build, options are: None, Debug Release RelWithDebInfo MinSizeRel.")
  ENDIF(NOT CMAKE_NO_BUILD_TYPE)
  SET (CMAKE_ASM${ASM_DIALECT}_FLAGS_DEBUG "${CMAKE_ASM${ASM_DIALECT}_FLAGS_DEBUG_INIT}" CACHE STRING
    "Flags used by the assembler during debug builds.")
  SET (CMAKE_ASM${ASM_DIALECT}_FLAGS_MINSIZEREL "${CMAKE_ASM${ASM_DIALECT}_FLAGS_MINSIZEREL_INIT}" CACHE STRING
    "Flags used by the assembler during release minsize builds.")
  SET (CMAKE_ASM${ASM_DIALECT}_FLAGS_RELEASE "${CMAKE_ASM${ASM_DIALECT}_FLAGS_RELEASE_INIT}" CACHE STRING
    "Flags used by the assembler during release builds.")
  SET (CMAKE_ASM${ASM_DIALECT}_FLAGS_RELWITHDEBINFO "${CMAKE_ASM${ASM_DIALECT}_FLAGS_RELWITHDEBINFO_INIT}" CACHE STRING
    "Flags used by the assembler during Release with Debug Info builds.")
ENDIF(NOT CMAKE_NOT_USING_CONFIG_FLAGS)

MARK_AS_ADVANCED(CMAKE_ASM${ASM_DIALECT}_FLAGS
                 CMAKE_ASM${ASM_DIALECT}_FLAGS_DEBUG
                 CMAKE_ASM${ASM_DIALECT}_FLAGS_MINSIZEREL
                 CMAKE_ASM${ASM_DIALECT}_FLAGS_RELEASE
                 CMAKE_ASM${ASM_DIALECT}_FLAGS_RELWITHDEBINFO
                )


IF(NOT CMAKE_ASM${ASM_DIALECT}_COMPILE_OBJECT)
  SET(CMAKE_ASM${ASM_DIALECT}_COMPILE_OBJECT "<CMAKE_ASM${ASM_DIALECT}_COMPILER> <FLAGS> -o <OBJECT> <SOURCE>")
ENDIF(NOT CMAKE_ASM${ASM_DIALECT}_COMPILE_OBJECT)

IF(NOT CMAKE_ASM${ASM_DIALECT}_CREATE_STATIC_LIBRARY)
  SET(CMAKE_ASM${ASM_DIALECT}_CREATE_STATIC_LIBRARY
      "<CMAKE_AR> cr <TARGET> <LINK_FLAGS> <OBJECTS> "
      "<CMAKE_RANLIB> <TARGET> ")
ENDIF(NOT CMAKE_ASM${ASM_DIALECT}_CREATE_STATIC_LIBRARY)

IF(NOT CMAKE_ASM${ASM_DIALECT}_LINK_EXECUTABLE)
  SET(CMAKE_ASM${ASM_DIALECT}_LINK_EXECUTABLE
    "<CMAKE_LINKER> <FLAGS> <CMAKE_ASM${ASM_DIALECT}_LINK_FLAGS> <LINK_FLAGS> <OBJECTS>  -o <TARGET> <LINK_LIBRARIES>")
ENDIF(NOT CMAKE_ASM${ASM_DIALECT}_LINK_EXECUTABLE)

# to be done
IF(NOT CMAKE_ASM${ASM_DIALECT}_CREATE_SHARED_LIBRARY)
  SET(CMAKE_ASM${ASM_DIALECT}_CREATE_SHARED_LIBRARY)
ENDIF(NOT CMAKE_ASM${ASM_DIALECT}_CREATE_SHARED_LIBRARY)

IF(NOT CMAKE_ASM${ASM_DIALECT}_CREATE_SHARED_MODULE)
  SET(CMAKE_ASM${ASM_DIALECT}_CREATE_SHARED_MODULE)
ENDIF(NOT CMAKE_ASM${ASM_DIALECT}_CREATE_SHARED_MODULE)


SET(CMAKE_ASM${ASM_DIALECT}_INFOMATION_LOADED 1)

