/*****************************************************************************
 * Project:  LibCMaker_HarfBuzz
 * Purpose:  A CMake build script for HarfBuzz library
 * Author:   NikitaFeodonit, nfeodonit@yandex.com
 *****************************************************************************
 *   Copyright (c) 2017-2019 NikitaFeodonit
 *
 *    This file is part of the LibCMaker_HarfBuzz project.
 *
 *    This program is free software: you can redistribute it and/or modify
 *    it under the terms of the GNU General Public License as published
 *    by the Free Software Foundation, either version 3 of the License,
 *    or (at your option) any later version.
 *
 *    This program is distributed in the hope that it will be useful,
 *    but WITHOUT ANY WARRANTY; without even the implied warranty of
 *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 *    See the GNU General Public License for more details.
 *
 *    You should have received a copy of the GNU General Public License
 *    along with this program. If not, see <http://www.gnu.org/licenses/>.
 ****************************************************************************/

// The code is based on the code from
// <harfbuzz>/test/api/test-c.c

/* This file tests that all headers can be included from .c files */

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <hb.h>

#ifdef HAVE_GLIB
#include <hb-glib.h>
#endif

#ifdef HAVE_ICU
#include <hb-icu.h>
#endif

#ifdef HAVE_FREETYPE
#include <hb-ft.h>
#endif

#ifdef HAVE_OT
#include <hb-ot.h>
#endif

#ifdef HAVE_UNISCRIBE
#include <hb-uniscribe.h>
#endif

#ifdef HAVE_CORETEXT
#include <hb-coretext.h>
#endif

#include "gtest/gtest.h"

TEST(Examle, test)
{
  EXPECT_EQ(!*hb_shape_list_shapers(), 0);
}
