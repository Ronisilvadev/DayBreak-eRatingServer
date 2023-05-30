# CMake generated Testfile for 
# Source directory: /opt/cmake-2.8.3/Tests/CMakeTests
# Build directory: /opt/cmake-2.8.3/Tests/CMakeTests
# 
# This file includes the relevent testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
ADD_TEST(CMake.List "/opt/cmake-2.8.3/bin/cmake" "-P" "/opt/cmake-2.8.3/Tests/CMakeTests/ListTest.cmake")
ADD_TEST(CMake.VariableWatch "/opt/cmake-2.8.3/bin/cmake" "-P" "/opt/cmake-2.8.3/Tests/CMakeTests/VariableWatchTest.cmake")
ADD_TEST(CMake.Include "/opt/cmake-2.8.3/bin/cmake" "-P" "/opt/cmake-2.8.3/Tests/CMakeTests/IncludeTest.cmake")
ADD_TEST(CMake.FindBase "/opt/cmake-2.8.3/bin/cmake" "-P" "/opt/cmake-2.8.3/Tests/CMakeTests/FindBaseTest.cmake")
ADD_TEST(CMake.Toolchain "/opt/cmake-2.8.3/bin/cmake" "-P" "/opt/cmake-2.8.3/Tests/CMakeTests/ToolchainTest.cmake")
ADD_TEST(CMake.GetFilenameComponentRealpath "/opt/cmake-2.8.3/bin/cmake" "-P" "/opt/cmake-2.8.3/Tests/CMakeTests/GetFilenameComponentRealpathTest.cmake")
ADD_TEST(CMake.Version "/opt/cmake-2.8.3/bin/cmake" "-P" "/opt/cmake-2.8.3/Tests/CMakeTests/VersionTest.cmake")
ADD_TEST(CMake.Message "/opt/cmake-2.8.3/bin/cmake" "-P" "/opt/cmake-2.8.3/Tests/CMakeTests/MessageTest.cmake")
ADD_TEST(CMake.File "/opt/cmake-2.8.3/bin/cmake" "-P" "/opt/cmake-2.8.3/Tests/CMakeTests/FileTest.cmake")
ADD_TEST(CMake.ConfigureFile "/opt/cmake-2.8.3/bin/cmake" "-P" "/opt/cmake-2.8.3/Tests/CMakeTests/ConfigureFileTest.cmake")
ADD_TEST(CMake.SeparateArguments "/opt/cmake-2.8.3/bin/cmake" "-P" "/opt/cmake-2.8.3/Tests/CMakeTests/SeparateArgumentsTest.cmake")
ADD_TEST(CMake.ImplicitLinkInfo "/opt/cmake-2.8.3/bin/cmake" "-P" "/opt/cmake-2.8.3/Tests/CMakeTests/ImplicitLinkInfoTest.cmake")
ADD_TEST(CMake.ModuleNotices "/opt/cmake-2.8.3/bin/cmake" "-P" "/opt/cmake-2.8.3/Tests/CMakeTests/ModuleNoticesTest.cmake")
ADD_TEST(CMake.If "/opt/cmake-2.8.3/bin/cmake" "-P" "/opt/cmake-2.8.3/Tests/CMakeTests/IfTest.cmake")
ADD_TEST(CMake.String "/opt/cmake-2.8.3/bin/cmake" "-P" "/opt/cmake-2.8.3/Tests/CMakeTests/StringTest.cmake")
ADD_TEST(CMake.Math "/opt/cmake-2.8.3/bin/cmake" "-P" "/opt/cmake-2.8.3/Tests/CMakeTests/MathTest.cmake")
ADD_TEST(CMake.CMakeMinimumRequired "/opt/cmake-2.8.3/bin/cmake" "-P" "/opt/cmake-2.8.3/Tests/CMakeTests/CMakeMinimumRequiredTest.cmake")
ADD_TEST(CMake.CompilerIdVendor "/opt/cmake-2.8.3/bin/cmake" "-P" "/opt/cmake-2.8.3/Tests/CMakeTests/CompilerIdVendorTest.cmake")
ADD_TEST(CMake.FileDownload "/opt/cmake-2.8.3/bin/cmake" "-P" "/opt/cmake-2.8.3/Tests/CMakeTests/FileDownloadTest.cmake")
SET_TESTS_PROPERTIES(CMake.FileDownload PROPERTIES  PASS_REGULAR_EXPRESSION "file already exists with expected MD5 sum")
ADD_TEST(CMake.ELF "/opt/cmake-2.8.3/bin/cmake" "-P" "/opt/cmake-2.8.3/Tests/CMakeTests/ELFTest.cmake")
ADD_TEST(CMake.EndStuff "/opt/cmake-2.8.3/bin/cmake" "-Ddir:STRING=/opt/cmake-2.8.3/Tests/CMakeTests/EndStuffTest" "-P" "/opt/cmake-2.8.3/Tests/CMakeTests/EndStuffTest.cmake")
ADD_TEST(CMake.GetPrerequisites "/opt/cmake-2.8.3/bin/cmake" "-DCTEST_CONFIGURATION_TYPE:STRING=${CTEST_CONFIGURATION_TYPE}" "-P" "/opt/cmake-2.8.3/Tests/CMakeTests/GetPrerequisitesTest.cmake")
