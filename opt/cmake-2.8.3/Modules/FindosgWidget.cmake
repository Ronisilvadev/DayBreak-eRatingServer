# This is part of the Findosg* suite used to find OpenSceneGraph components.
# Each component is separate and you must opt in to each module. You must 
# also opt into OpenGL and OpenThreads (and Producer if needed) as these 
# modules won't do it for you. This is to allow you control over your own 
# system piece by piece in case you need to opt out of certain components
# or change the Find behavior for a particular module (perhaps because the
# default FindOpenGL.cmake module doesn't work with your system as an
# example).
# If you want to use a more convenient module that includes everything,
# use the FindOpenSceneGraph.cmake instead of the Findosg*.cmake modules.
# 
# Locate osgWidget
# This module defines
#
# OSGWIDGET_FOUND - Was osgWidget found?
# OSGWIDGET_INCLUDE_DIR - Where to find the headers
# OSGWIDGET_LIBRARIES - The libraries to link for osgWidget (use this)
#
# OSGWIDGET_LIBRARY - The osgWidget library
# OSGWIDGET_LIBRARY_DEBUG - The osgWidget debug library
#
# $OSGDIR is an environment variable that would
# correspond to the ./configure --prefix=$OSGDIR
# used in building osg.
#
# FindosgWidget.cmake tweaked from Findosg* suite as created by Eric Wing.

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

# Header files are presumed to be included like
# #include <osg/PositionAttitudeTransform>
# #include <osgWidget/Widget>

include(Findosg_functions)
OSG_FIND_PATH   (OSGWIDGET osgWidget/Widget)
OSG_FIND_LIBRARY(OSGWIDGET osgWidget)

include("${CMAKE_CURRENT_LIST_DIR}/FindPackageHandleStandardArgs.cmake")
FIND_PACKAGE_HANDLE_STANDARD_ARGS(osgWidget DEFAULT_MSG
    OSGWIDGET_LIBRARY OSGWIDGET_INCLUDE_DIR)
