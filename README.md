# cmake-stuff
CMake stuff for reuse across projects.

## Setup test project
```bash
$ mkdir test-cmake-stuff; cd test-cmake-stuff; git init

# Fast way to bring up new CMake project
$ conan new -d name=test-cmake-stuff -d version=0.0.1 cmake_exe

$ git submodule add https://github.com/ooonak/cmake-stuff
$ cp cmake-stuff/templates/* .

# Add to top-level CMakeLists.txt
option(USE_HARDENING_FLAGS "Enable compiler hardening flags" ON)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake-stuff/cmake")
include(scripts)

enable_tidy()
enable_cppcheck()
enable_iwyu()

set_warnings(WERROR)

# For x86_64 executable
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fPIE -fcf-protection=full -O2")
# For aarch64 shared library
#set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fPIC -mbranch-protection=standard -O2")

message("${CMAKE_CXX_FLAGS}")
```

```bash
$ cmake -S . -B build -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=clang++
$ cmake --build build

# Or just

$ conan build .
$ ./build/Release/test-cmake-stuff
test-cmake-stuff/0.0.1: Hello World Release!
  test-cmake-stuff/0.0.1: __x86_64__ defined
  test-cmake-stuff/0.0.1: _GLIBCXX_USE_CXX11_ABI 1
  test-cmake-stuff/0.0.1: __cplusplus201703
  test-cmake-stuff/0.0.1: __GNUC__13
  test-cmake-stuff/0.0.1: __GNUC_MINOR__2
```

