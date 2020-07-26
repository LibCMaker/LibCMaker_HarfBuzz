# ****************************************************************************
#  Project:  LibCMaker_HarfBuzz
#  Purpose:  A CMake build script for HarfBuzz Library
#  Author:   NikitaFeodonit, nfeodonit@yandex.com
# ****************************************************************************
#    Copyright (c) 2017-2019 NikitaFeodonit
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

#-----------------------------------------------------------------------
# The file is an example of the convenient script for the library build.
#-----------------------------------------------------------------------

#-----------------------------------------------------------------------
# Lib's name, version, paths
#-----------------------------------------------------------------------

set(HB_lib_NAME "HarfBuzz")
set(HB_lib_VERSION "1.8.6" CACHE STRING "HB_lib_VERSION")
set(HB_lib_DIR "${CMAKE_CURRENT_LIST_DIR}" CACHE PATH "HB_lib_DIR")

# To use our Find<LibName>.cmake.
list(APPEND CMAKE_MODULE_PATH "${HB_lib_DIR}/cmake/modules")


#-----------------------------------------------------------------------
# LibCMaker_<LibName> specific vars and options
#-----------------------------------------------------------------------

option(COPY_HARFBUZZ_CMAKE_BUILD_SCRIPTS "COPY_HARFBUZZ_CMAKE_BUILD_SCRIPTS" ON)


#-----------------------------------------------------------------------
# Library specific vars and options
#-----------------------------------------------------------------------

option(HB_HAVE_FREETYPE "Enable freetype interop helpers" OFF)
option(HB_HAVE_GRAPHITE2 "Enable Graphite2 complementary shaper" OFF)
option(HB_BUILTIN_UCDN "Use HarfBuzz provided UCDN" ON)
option(HB_HAVE_GLIB "Enable glib unicode functions" OFF)
option(HB_HAVE_ICU "Enable icu unicode functions" OFF)
if(APPLE)
  option(HB_HAVE_CORETEXT "Enable CoreText shaper backend on macOS" OFF)
endif ()
if(WIN32)
  option(HB_HAVE_UNISCRIBE "Enable Uniscribe shaper backend on Windows" OFF)
  option(HB_HAVE_DIRECTWRITE "Enable DirectWrite shaper backend on Windows" OFF)
endif ()
option(HB_BUILD_UTILS
  "Build harfbuzz utils, needs cairo, freetype, and glib properly be installed"
  OFF
)
option(HB_HAVE_GOBJECT "Enable GObject Bindings" OFF)
option(HB_HAVE_INTROSPECTION
  "Enable building introspection (.gir/.typelib) files"
  OFF
)
option(HB_CHECK
  "Do a configuration suitable for testing (shared library and enable all options)"
  OFF
)


if(NOT cmr_BUILD_FROM_FREETYPE AND HB_HAVE_FREETYPE)
  # Needed for lib_cmaker_harfbuzz() to build HarfBuzz with FreeType.
  set(LIBCMAKER_FREETYPE_SRC_DIR
    "${CMAKE_CURRENT_LIST_DIR}/libs/LibCMaker_FreeType"  # TODO:
    CACHE PATH "LIBCMAKER_FREETYPE_SRC_DIR"
  )
  # To use our FindFreetype.cmake.
  list(APPEND CMAKE_MODULE_PATH "${LIBCMAKER_FREETYPE_SRC_DIR}/cmake/modules")
endif()


#-----------------------------------------------------------------------
# Build, install and find the library
#-----------------------------------------------------------------------

if(cmr_BUILD_FROM_FREETYPE)
  cmr_find_package(
    LibCMaker_DIR   ${find_LibCMaker_DIR}
    NAME            ${HB_lib_NAME}
    VERSION         ${HB_lib_VERSION}
    LIB_DIR         ${HB_lib_DIR}
    REQUIRED
  )
else()
  cmr_find_package(
    LibCMaker_DIR   ${LibCMaker_DIR}
    NAME            ${HB_lib_NAME}
    VERSION         ${HB_lib_VERSION}
    LIB_DIR         ${HB_lib_DIR}
    REQUIRED
  )
endif()
