macro(enable_tidy)
  find_program(clang_tidy_cmd NAMES "clang-tidy")
  if(NOT clang_tidy_cmd)
    message(WARNING "Could not find clang-tidy!")
  else()
    if(NOT EXISTS "${CMAKE_SOURCE_DIR}/.clang-tidy")
      message(FATAL_ERROR "Missing config file ${CMAKE_SOURCE_DIR}/.clang-tidy!")
    endif()
    set(CMAKE_CXX_CLANG_TIDY "${clang_tidy_cmd}")
  endif()
endmacro()

macro(enable_cppcheck)
  find_program(CMAKE_CXX_CPPCHECK NAMES cppcheck)
  if (CMAKE_CXX_CPPCHECK)
    list(
        APPEND CMAKE_CXX_CPPCHECK
            "--enable=all"
            "--inconclusive"
            "--force"
            "--inline-suppr"
            "--suppressions-list=${CMAKE_SOURCE_DIR}/CppCheckSuppressions.txt"
    )
  endif()
endmacro()

macro(enable_iwyu)
  find_program(iwyu_path NAMES include-what-you-use iwyu REQUIRED)
  if(NOT iwyu_cmd)
    message(WARNING "Could not find include-what-you-use!")
  else()
    set(CMAKE_CXX_INCLUDE_WHAT_YOU_USE "${iwyu_cmd}")
  endif()
endmacro()

