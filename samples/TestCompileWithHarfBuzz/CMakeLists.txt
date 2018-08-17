# ****************************************************************************
#  Project:  LibCMaker_HarfBuzz
#  Purpose:  A CMake build script for HarfBuzz Library
#  Author:   NikitaFeodonit, nfeodonit@yandex.com
# ****************************************************************************
#    Copyright (c) 2017-2018 NikitaFeodonit
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

cmake_minimum_required(VERSION 3.3)

project(LibCMaker_HarfBuzz_Compile_Test CXX)

set(CMAKE_VERBOSE_MAKEFILE ON)
set(cmr_PRINT_DEBUG ON)


#-----------------------------------------------------------------------
# Configure to find_package()
#-----------------------------------------------------------------------

# Set CMake's search path for find_*() commands.
list(APPEND CMAKE_PREFIX_PATH "${CMAKE_INSTALL_PREFIX}")

if(ANDROID)
  list(APPEND CMAKE_FIND_ROOT_PATH "${CMAKE_INSTALL_PREFIX}")
endif()


#-----------------------------------------------------------------------
# Set path to LibCMaker root
#-----------------------------------------------------------------------

set(LibCMaker_DIR "${CMAKE_CURRENT_LIST_DIR}/cmake/LibCMaker")
# Uncomment it if need functions from LibCMaker
#list(APPEND CMAKE_MODULE_PATH "${LibCMaker_DIR}/cmake")


#-----------------------------------------------------------------------
# Set vars to LibCMaker_HarfBuzz
#-----------------------------------------------------------------------

set(HB_lib_NAME     "HarfBuzz")
set(HB_lib_VERSION  "1.8.6")
set(HB_lib_DIR      "${CMAKE_CURRENT_LIST_DIR}/cmake/LibCMaker_HarfBuzz")

# To use below for sample sources.
set(cmr_UNPACKED_DIR ${CMAKE_CURRENT_BINARY_DIR}/download/unpacked)

# To use our FindHarfBuzz.cmake.
list(APPEND CMAKE_MODULE_PATH "${HB_lib_DIR}/cmake/modules")

set(COPY_HARFBUZZ_CMAKE_BUILD_SCRIPTS ON)


#-----------------------------------------------------------------------
# Library specific vars and options
#-----------------------------------------------------------------------

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
# Do a configuration suitable for testing (shared library and enable all options
#set(HB_CHECK OFF)

if(HB_HAVE_FREETYPE)
  # Needed for lib_cmaker_harfbuzz() to build HarfBuzz with FreeType.
  set(LIBCMAKER_FREETYPE_SRC_DIR
    "${CMAKE_CURRENT_LIST_DIR}/cmake/LibCMaker_FreeType"
  )
  # To use our FindFreetype.cmake.
  list(APPEND CMAKE_MODULE_PATH "${LIBCMAKER_FREETYPE_SRC_DIR}/cmake/modules")
endif()


#-----------------------------------------------------------------------
# Build, install and find the HarfBuzz
#-----------------------------------------------------------------------

# Make build and install the library at a config CMake phase.
include(${LibCMaker_DIR}/cmake/cmr_find_package.cmake)
cmr_find_package(
  LibCMaker_DIR   ${LibCMaker_DIR}
  NAME            ${HB_lib_NAME}
  VERSION         ${HB_lib_VERSION}
  LIB_DIR         ${HB_lib_DIR}
  REQUIRED
)


#-----------------------------------------------------------------------
# Link to the library
#-----------------------------------------------------------------------

# Build test executables.

# Get an example sources from the lib sources.
set(lib_EXAMPLES_SRC_DIR
  "${cmr_UNPACKED_DIR}/harfbuzz-${HB_lib_VERSION}/harfbuzz-${HB_lib_VERSION}/test"
)

add_executable(${PROJECT_NAME}
  ${lib_EXAMPLES_SRC_DIR}/fuzzing/main.cc
  ${lib_EXAMPLES_SRC_DIR}/fuzzing/hb-shape-fuzzer.cc
)
set_property(TARGET ${PROJECT_NAME} PROPERTY CXX_STANDARD 11)

# HarfBuzz
target_include_directories(${PROJECT_NAME} PRIVATE ${HARFBUZZ_INCLUDE_DIR})
target_link_libraries(${PROJECT_NAME} ${HARFBUZZ_LIBRARY})