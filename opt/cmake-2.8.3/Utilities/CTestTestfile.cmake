# CMake generated Testfile for 
# Source directory: /opt/cmake-2.8.3/Utilities
# Build directory: /opt/cmake-2.8.3/Utilities
# 
# This file includes the relevent testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
ADD_TEST(CMake.HTML "/opt/cmake-2.8.3/bin/cmake" "-E" "chdir" "/opt/cmake-2.8.3/Utilities/xml" "/usr/bin/xmllint" "--valid" "--noout" "--nonet" "--path" "." "/opt/cmake-2.8.3/Docs/cmake.html" "/opt/cmake-2.8.3/Docs/cmake-policies.html" "/opt/cmake-2.8.3/Docs/cmake-properties.html" "/opt/cmake-2.8.3/Docs/cmake-variables.html" "/opt/cmake-2.8.3/Docs/cmake-modules.html" "/opt/cmake-2.8.3/Docs/cmake-commands.html" "/opt/cmake-2.8.3/Docs/cmake-compatcommands.html" "/opt/cmake-2.8.3/Docs/ctest.html" "/opt/cmake-2.8.3/Docs/cpack.html")
SUBDIRS(Doxygen)
SUBDIRS(KWStyle)
