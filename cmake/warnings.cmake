# https://best.openssf.org/Compiler-Hardening-Guides/Compiler-Options-Hardening-Guide-for-C-and-C++.html

macro(set_warnings)
   if(${ARGC} GREATER_EQUAL 1)
     if(${ARGV0} STREQUAL "WERROR")
            set(as_errors TRUE)
        else()
            message(FATAL_ERROR "Unknown argument '${ARGV0}' passed to set_warnings()")
        endif()
    endif()

    set(MY_FLAGS "${MY_FLAGS} -Wall -Wextra -Wformat=2 -Wpedantic")
    set(MY_FLAGS "${MY_FLAGS} -Wshadow -Wunused -Wnon-virtual-dtor -Woverloaded-virtual")
    set(MY_FLAGS "${MY_FLAGS} -Wold-style-cast -Wcast-qual -Wcast-align")
    set(MY_FLAGS "${MY_FLAGS} -Wsign-conversion -Wnull-dereference")

    if (USE_HARDENING_FLAGS)
        set(MY_FLAGS "${MY_FLAGS} -Wconversion -Wimplicit-fallthrough")
        set(MY_FLAGS "${MY_FLAGS} -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3")
        set(MY_FLAGS "${MY_FLAGS} -D_GLIBCXX_ASSERTIONS")
        set(MY_FLAGS "${MY_FLAGS} -fstrict-flex-arrays=3")
        set(MY_FLAGS "${MY_FLAGS} -fstack-clash-protection -fstack-protector-strong")
        set(MY_FLAGS "${MY_FLAGS} -Wl,-z,nodlopen -Wl,-z,noexecstack")
        set(MY_FLAGS "${MY_FLAGS} -Wl,-z,relro -Wl,-z,now")

        if (MY_COMPILER_ID STREQUAL "Clang")

        elseif (MY_COMPILER_ID STREQUAL "GNU")
            set(MY_FLAGS "${MY_FLAGS} -Wtrampolines")
        endif()

        if (CMAKE_BUILD_TYPE STREQUAL "Release")
            set(MY_FLAGS "${MY_FLAGS} -fno-delete-null-pointer-checks")
            set(MY_FLAGS "${MY_FLAGS} -fno-strict-overflow")
            set(MY_FLAGS "${MY_FLAGS} -fno-strict-aliasing")
            set(MY_FLAGS "${MY_FLAGS} -ftrivial-auto-var-init=zero")
        endif()
    endif()

    if (as_errors)
      set(MY_FLAGS "${MY_FLAGS} -Werror")
    endif()

    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${MY_FLAGS}")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${MY_FLAGS}")
endmacro()
