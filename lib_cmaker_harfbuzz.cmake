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

if(NOT LIBCMAKER_SRC_DIR)
  message(FATAL_ERROR
    "Please set LIBCMAKER_SRC_DIR with path to LibCMaker modules root")
endif()
# TODO: prevent multiply includes for CMAKE_MODULE_PATH
list(APPEND CMAKE_MODULE_PATH "${LIBCMAKER_SRC_DIR}/cmake/modules")

# To find library CMaker source dir.
set(lcm_LibCMaker_LIB_SRC_DIR ${CMAKE_CURRENT_LIST_DIR})
# TODO: prevent multiply includes for CMAKE_MODULE_PATH
list(APPEND CMAKE_MODULE_PATH "${lcm_LibCMaker_LIB_SRC_DIR}/cmake/modules")

include(CMakeParseArguments) # cmake_parse_arguments

include(cmr_lib_cmaker)
include(cmr_print_debug_message)
include(cmr_print_var_value)

function(lib_cmaker_harfbuzz)
  cmake_minimum_required(VERSION 3.2)

  set(options
    # optional args
  )
  
  set(oneValueArgs
    # required args
    BUILD_DIR
    # optional args
    VERSION DOWNLOAD_DIR UNPACKED_SRC_DIR
  )

  set(multiValueArgs
    # optional args
  )

  cmake_parse_arguments(arg
      "${options}" "${oneValueArgs}" "${multiValueArgs}" "${ARGN}")
  # -> lib_VERSION
  # -> lib_BUILD_DIR
  # -> lib_* ...

  cmr_print_var_value(LIBCMAKER_SRC_DIR)

  cmr_print_var_value(arg_BUILD_DIR)

  cmr_print_var_value(arg_VERSION)
  cmr_print_var_value(arg_DOWNLOAD_DIR)
  cmr_print_var_value(arg_UNPACKED_SRC_DIR)

  # Required args
  if(NOT arg_VERSION)
    cmr_print_fatal_error("Argument VERSION is not defined.")
  endif()
  if(NOT arg_BUILD_DIR)
    cmr_print_fatal_error("Argument BUILD_DIR is not defined.")
  endif()
  if(arg_UNPARSED_ARGUMENTS)
    cmr_print_fatal_error(
      "There are unparsed arguments: ${arg_UNPARSED_ARGUMENTS}")
  endif()


  #-----------------------------------------------------------------------
  # Library specific build arguments.
  #-----------------------------------------------------------------------

  set(lcm_CMAKE_ARGS)

  if(DEFINED HB_HAVE_FREETYPE)
    list(APPEND lcm_CMAKE_ARGS
      -DHB_HAVE_FREETYPE=${HB_HAVE_FREETYPE}
    )
  endif()
  if(DEFINED HB_HAVE_GRAPHITE2)
    list(APPEND lcm_CMAKE_ARGS
      -DHB_HAVE_GRAPHITE2=${HB_HAVE_GRAPHITE2}
    )
  endif()
  if(DEFINED HB_BUILTIN_UCDN)
    list(APPEND lcm_CMAKE_ARGS
      -DHB_BUILTIN_UCDN=${HB_BUILTIN_UCDN}
    )
  endif()
  if(DEFINED HB_HAVE_GLIB)
    list(APPEND lcm_CMAKE_ARGS
      -DHB_HAVE_GLIB=${HB_HAVE_GLIB}
    )
  endif()
  if(DEFINED HB_HAVE_ICU)
    list(APPEND lcm_CMAKE_ARGS
      -DHB_HAVE_ICU=${HB_HAVE_ICU}
    )
  endif()
  if(DEFINED HB_HAVE_CORETEXT)
    list(APPEND lcm_CMAKE_ARGS
      -DHB_HAVE_CORETEXT=${HB_HAVE_CORETEXT}
    )
  endif()
  if(DEFINED HB_HAVE_UNISCRIBE)
    list(APPEND lcm_CMAKE_ARGS
      -DHB_HAVE_UNISCRIBE=${HB_HAVE_UNISCRIBE}
    )
  endif()
  if(DEFINED HB_HAVE_DIRECTWRITE)
    list(APPEND lcm_CMAKE_ARGS
      -DHB_HAVE_DIRECTWRITE=${HB_HAVE_DIRECTWRITE}
    )
  endif()
  if(DEFINED HB_BUILD_UTILS)
    list(APPEND lcm_CMAKE_ARGS
      -DHB_BUILD_UTILS=${HB_BUILD_UTILS}
    )
  endif()
  if(DEFINED HB_HAVE_GOBJECT)
    list(APPEND lcm_CMAKE_ARGS
      -DHB_HAVE_GOBJECT=${HB_HAVE_GOBJECT}
    )
  endif()
  if(DEFINED HB_HAVE_INTROSPECTION)
    list(APPEND lcm_CMAKE_ARGS
      -DHB_HAVE_INTROSPECTION=${HB_HAVE_INTROSPECTION}
    )
  endif()
  
  
  #-----------------------------------------------------------------------
  # BUILDING
  #-----------------------------------------------------------------------

  cmr_lib_cmaker(
    VERSION ${arg_VERSION}
    PROJECT_DIR ${lcm_LibCMaker_LIB_SRC_DIR}
    DOWNLOAD_DIR ${arg_DOWNLOAD_DIR}
    UNPACKED_SRC_DIR ${arg_UNPACKED_SRC_DIR}
    BUILD_DIR ${arg_BUILD_DIR}
    CMAKE_ARGS ${lcm_CMAKE_ARGS}
    INSTALL
  )

endfunction()
