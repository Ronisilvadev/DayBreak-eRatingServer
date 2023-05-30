# CMake generated Testfile for 
# Source directory: /opt/cmake-2.8.3
# Build directory: /opt/cmake-2.8.3
# 
# This file includes the relevent testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
INCLUDE("/opt/cmake-2.8.3/Tests/EnforceConfig.cmake")
ADD_TEST(SystemInformationNew "/opt/cmake-2.8.3/bin/cmake" "--system-information" "-G" "Unix Makefiles")
SUBDIRS(Source/kwsys)
SUBDIRS(Utilities/cmzlib)
SUBDIRS(Utilities/cmcurl)
SUBDIRS(Utilities/cmcompress)
SUBDIRS(Utilities/cmbzip2)
SUBDIRS(Utilities/cmlibarchive)
SUBDIRS(Utilities/cmexpat)
SUBDIRS(Source)
SUBDIRS(Utilities)
SUBDIRS(Tests)
