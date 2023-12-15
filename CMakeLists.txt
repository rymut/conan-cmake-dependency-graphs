cmake_minimum_required(VERSION 3.9)
set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>DLL")
set(CMAKE_CXX_STANDARD 14)
set(CONAN_HOST_PROFILE "auto-cmake")
set(CONAN_SUBFOLDER "conan")
set(CONAN_HOST_PROFILE "default")
SET(CONAN_ARGS "--build;missing;--lockfile-out;conan.lock")

project(FormatOutput LANGUAGES CXX C)


list(APPEND CMAKE_MODULE_PATH ${CMAKE_BINARY_DIR})
list(APPEND CMAKE_PREFIX_PATH ${CMAKE_BINARY_DIR})

add_definitions("-std=c++11")

if(NOT EXISTS "${CMAKE_BINARY_DIR}/conan_provider.cmake")
  message(STATUS "Downloading conan_provider.cmake")
  file(DOWNLOAD "https://raw.githubusercontent.com/rymut/cmake-conan/master/develop2/conan_provider.cmake"
                "${CMAKE_BINARY_DIR}/conan_provider.cmake"
                TLS_VERIFY ON)
endif()

include(${CMAKE_BINARY_DIR}/conan_provider.cmake)

find_package(spdlog REQUIRED)
find_package(OpenCV REQUIRED)
find_package(hedley REQUIRED)

add_executable(main main.cpp)
target_link_libraries(main PRIVATE spdlog::spdlog opencv_highgui)
target_link_libraries(main PUBLIC hedley::hedley)