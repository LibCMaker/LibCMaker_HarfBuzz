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

# Part of "LibCMaker/cmake/cmr_get_download_params.cmake".

  include(cmr_get_version_parts)
  cmr_get_version_parts(${version} major minor patch tweak)

  if(version VERSION_EQUAL "1.4.8")
    set(arch_file_sha
      "ccec4930ff0bb2d0c40aee203075447954b64a8c2695202413cc5e428c907131")
  endif()
  if(version VERSION_EQUAL "1.6.3")
    set(arch_file_sha
      "e31eb367beb61a9399d2c78b51c225ab2b1cbd46f364f2d80d97bb422b44101a")
  endif()
  if(version VERSION_EQUAL "1.8.6")
    set(arch_file_sha
      "296826f0d6debf2098752e5145c2c40814e187339591d6d7081bd5827eaf5c66")
  endif()
  if(version VERSION_EQUAL "2.9.1")
    set(arch_file_sha
      "0edcc980f526a338452180e701d6aba6323aef457b6686976a7d17ccbddc51cf")
  endif()
  if(version VERSION_EQUAL "3.0.0")
    set(arch_file_sha
      "036b0ee118451539783ec7864148bb4106be42a2eb964df4e83e6703ec46f3d9")
  endif()

  set(base_url "https://github.com/harfbuzz/harfbuzz/releases/download")
  set(src_dir_name    "harfbuzz-${version}")
  set(arch_file_name  "${src_dir_name}.tar.xz")
  set(unpack_to_dir   "${unpacked_dir}/${src_dir_name}")

  set(${out_ARCH_SRC_URL}   "${base_url}/${major}.${minor}.${patch}/${arch_file_name}" PARENT_SCOPE)
  set(${out_ARCH_DST_FILE}  "${download_dir}/${arch_file_name}" PARENT_SCOPE)
  set(${out_ARCH_FILE_SHA}  "${arch_file_sha}" PARENT_SCOPE)
  set(${out_SHA_ALG}        "SHA256" PARENT_SCOPE)
  set(${out_UNPACK_TO_DIR}  "${unpack_to_dir}" PARENT_SCOPE)
  set(${out_UNPACKED_SOURCES_DIR}
    "${unpack_to_dir}/${src_dir_name}" PARENT_SCOPE
  )
  set(${out_VERSION_BUILD_DIR} "${build_dir}/${src_dir_name}" PARENT_SCOPE)
