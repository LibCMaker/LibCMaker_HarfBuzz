# ****************************************************************************
#  Project:  LibCMaker_HarfBuzz
#  Purpose:  A CMake build script for HarfBuzz Library
#  Author:   NikitaFeodonit, nfeodonit@yandex.com
# ****************************************************************************
#    Copyright (c) 2017-2020 NikitaFeodonit
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

set(LibCMaker_LIB_DIR "${CMAKE_CURRENT_LIST_DIR}/libs")
set(LibCMaker_DIR "${LibCMaker_LIB_DIR}/LibCMaker")

include(${LibCMaker_DIR}/samples/cmr_get_cmake_min_ver.cmake NO_POLICY_SCOPE)
cmr_get_cmake_min_ver()
cmake_minimum_required(VERSION ${cmr_CMAKE_MIN_VER})

project(LibCMaker_HarfBuzz_Compile_Test CXX)

include(${LibCMaker_DIR}/samples/cmr_samples_common_macros.cmake)


#-----------------------------------------------------------------------
# Common sample 1st part
#-----------------------------------------------------------------------

cmr_common_sample_1st_part()


#-----------------------------------------------------------------------
# Download, configure, build, install and find the required libraries
#-----------------------------------------------------------------------

include(${LibCMaker_LIB_DIR}/LibCMaker_HarfBuzz/cmr_build_harfbuzz.cmake)


#-----------------------------------------------------------------------
# Build the executable of the example
#-----------------------------------------------------------------------

set(example_src_DIR "${CMAKE_CURRENT_LIST_DIR}/src")

target_sources(${PROJECT_NAME}
  PRIVATE
    ${example_src_DIR}/example.cpp
)
set_property(TARGET ${PROJECT_NAME} PROPERTY CXX_STANDARD 11)


#-----------------------------------------------------------------------
# Link to the libraries
#-----------------------------------------------------------------------

# HarfBuzz
target_link_libraries(${PROJECT_NAME} PRIVATE HarfBuzz::HarfBuzz)


#-----------------------------------------------------------------------
# Common sample 2nd part
#-----------------------------------------------------------------------

cmr_common_sample_2nd_part()


#-----------------------------------------------------------------------
# Testing
#-----------------------------------------------------------------------

set(test_src_DIR "${CMAKE_CURRENT_LIST_DIR}/src")
add_subdirectory(test)
