# ****************************************************************************
#  Project:  LibCMaker_HarfBuzz
#  Purpose:  A CMake build script for HarfBuzz Library
#  Author:   NikitaFeodonit, nfeodonit@yandex.com
# ****************************************************************************
#    Copyright (c) 2017 NikitaFeodonit
#
#    This file is part of the LibCMaker_HarfBuzz project.
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published
#    by the Free Software Foundation, either version 3 of the License,
#    or (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#    See the GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program. If not, see <http://www.gnu.org/licenses/>.
# ****************************************************************************

cmake_minimum_required(VERSION 3.2 FATAL_ERROR)

project(LibCMaker_HarfBuzz_Compile_Test CXX)

list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake")


#-----------------------------------------------------------------------
# Configure for find_package.
#-----------------------------------------------------------------------

# Set CMake's search path for find_package(), find_program(), find_library(),
# find_file(), and find_path() commands.
list(APPEND CMAKE_PREFIX_PATH "${CMAKE_INSTALL_PREFIX}")

if(ANDROID)
  list(APPEND CMAKE_FIND_ROOT_PATH "${CMAKE_INSTALL_PREFIX}")
endif()


#-----------------------------------------------------------------------
# Set path to LibCMaker root
#-----------------------------------------------------------------------

set(LIBCMAKER_SRC_DIR "${PROJECT_SOURCE_DIR}/cmake/LibCMaker")
# Uncomment it if need functions from LibCMaker
#list(APPEND CMAKE_MODULE_PATH "${LIBCMAKER_SRC_DIR}/cmake/modules")


#-----------------------------------------------------------------------
# Set vars for LibCMaker_HarfBuzz.
#-----------------------------------------------------------------------

# Standard CMake vars.
#set(BUILD_SHARED_LIBS ON)

#set(SKIP_INSTALL_HEADERS ON)
#set(SKIP_INSTALL_LIBRARIES ON)
#set(SKIP_INSTALL_ALL ON)

# Set useful vars for lib_cmaker_harfbuzz().
set(cmr_PRINT_DEBUG ON)

set(lib_VERSION "1.6.3")

set(DOWNLOAD_DIR "${PROJECT_BINARY_DIR}")
set(UNPACKED_SRC_DIR "${PROJECT_BINARY_DIR}")
set(BUILD_DIR "${PROJECT_BINARY_DIR}/build_harfbuzz")

set(ENV{HARFBUZZ_DIR} "${CMAKE_INSTALL_PREFIX}")

# Library specific vars.

# Enable freetype interop helpers
#set(HB_HAVE_FREETYPE OFF)
# Enable Graphite2 complementary shaper
#set(HB_HAVE_GRAPHITE2 OFF)
# Use HarfBuzz provided UCDN
#set(HB_BUILTIN_UCDN ON)
# Enable glib unicode functions
#set(HB_HAVE_GLIB OFF)
# Enable icu unicode functions
#set(HB_HAVE_ICU OFF)
#if (APPLE)
  # Enable CoreText shaper backend on macOS
  #set(HB_HAVE_CORETEXT ON)
#endif ()
#if (WIN32)
  # Enable Uniscribe shaper backend on Windows
  #set(HB_HAVE_UNISCRIBE OFF)
  # Enable DirectWrite shaper backend on Windows
  #set(HB_HAVE_DIRECTWRITE OFF)
#endif ()
# Build harfbuzz utils, needs cairo, freetype, and glib properly be installed
#set(HB_BUILD_UTILS OFF)
# Enable GObject Bindings
#set(HB_HAVE_GOBJECT OFF)
# Enable building introspection (.gir/.typelib) files
#set(HB_HAVE_INTROSPECTION OFF)

if(HB_HAVE_FREETYPE)
  # Needed for lib_cmaker_harfbuzz() to build HarfBuzz with FreeType
  set(LIBCMAKER_FREETYPE_SRC_DIR
    "${PROJECT_SOURCE_DIR}/cmake/LibCMaker_FreeType")
  # To use our FindFreetype.cmake
  list(APPEND CMAKE_MODULE_PATH "${LIBCMAKER_FREETYPE_SRC_DIR}/cmake/")
endif()


#-----------------------------------------------------------------------
# Build and install the HarfBuzz.
#-----------------------------------------------------------------------

include(
  ${PROJECT_SOURCE_DIR}/cmake/LibCMaker_HarfBuzz/lib_cmaker_harfbuzz.cmake)

# Make compile, build and install the library at a config CMake phase,
# generate the CMake config files.

# Install specified library version.
lib_cmaker_harfbuzz(
  VERSION ${lib_VERSION}
  DOWNLOAD_DIR ${DOWNLOAD_DIR}
  UNPACKED_SRC_DIR ${UNPACKED_SRC_DIR}
  BUILD_DIR ${BUILD_DIR}
)


#-----------------------------------------------------------------------
# find_package
#-----------------------------------------------------------------------

# Use newly got library.
find_package(HarfBuzz REQUIRED)


#-----------------------------------------------------------------------
# Link to the library
#-----------------------------------------------------------------------

# Build test executables
add_executable(${PROJECT_NAME}
  ${UNPACKED_SRC_DIR}/harfbuzz-${lib_VERSION}/test/fuzzing/main.cc
  ${UNPACKED_SRC_DIR}/harfbuzz-${lib_VERSION}/test/fuzzing/hb-fuzzer.cc
)
target_include_directories(${PROJECT_NAME} PRIVATE ${HARFBUZZ_INCLUDE_DIR})
target_link_libraries(${PROJECT_NAME} ${HARFBUZZ_LIBRARY})
set_property(TARGET ${PROJECT_NAME} PROPERTY CXX_STANDARD 11)
