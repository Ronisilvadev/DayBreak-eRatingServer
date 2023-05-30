set(Copy-BadArg-RESULT 1)
set(Copy-BadArg-STDERR "unknown argument \"BADARG\"")
set(Copy-BadPerm-RESULT 1)
set(Copy-BadPerm-STDERR "COPY given invalid permission \"BADPERM\"")
set(Copy-BadRegex-RESULT 1)
set(Copy-BadRegex-STDERR "could not compile REGEX")
set(Copy-EarlyArg-RESULT 1)
set(Copy-EarlyArg-STDERR "option PERMISSIONS may not appear before")
set(Copy-LateArg-RESULT 1)
set(Copy-LateArg-STDERR "option FILE_PERMISSIONS may not appear after")
set(Copy-NoDest-RESULT 1)
set(Copy-NoDest-STDERR "given no DESTINATION")
set(Copy-NoFile-RESULT 1)
set(Copy-NoFile-STDERR "COPY cannot find.*/does_not_exist\\.txt")

include("/opt/cmake-2.8.3/Tests/CMakeTests/CheckCMakeTest.cmake")
check_cmake_test(File
  Copy-BadArg
  Copy-BadPerm
  Copy-BadRegex
  Copy-EarlyArg
  Copy-LateArg
  Copy-NoDest
  Copy-NoFile
  )

# Also execute each test listed in FileTestScript.cmake:
#
set(scriptname "/opt/cmake-2.8.3/Tests/CMakeTests/FileTestScript.cmake")
set(number_of_tests_expected 56)

include("/opt/cmake-2.8.3/Tests/CMakeTests/ExecuteScriptTests.cmake")
execute_all_script_tests(${scriptname} number_of_tests_executed)

# And verify that number_of_tests_executed is at least as many as we know
# about as of this writing...
#
message(STATUS "scriptname='${scriptname}'")
message(STATUS "number_of_tests_executed='${number_of_tests_executed}'")
message(STATUS "number_of_tests_expected='${number_of_tests_expected}'")

if(number_of_tests_executed LESS number_of_tests_expected)
  message(FATAL_ERROR "error: some test cases were skipped")
endif()
