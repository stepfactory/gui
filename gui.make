#
#   gui.make
#
#   Makefile flags and configs to build with the gui library.
#
#   Copyright (C) 2001 Free Software Foundation, Inc.
#
#   Author:  Nicola Pero <n.pero@mi.flashnet.it>
#   Based on code originally in the gnustep make package
#
#   This file is part of the GNUstep Gui Library.
#
#   This library is free software; you can redistribute it and/or
#   modify it under the terms of the GNU General Public License
#   as published by the Free Software Foundation; either version 2
#   of the License, or (at your option) any later version.
#   
#   You should have received a copy of the GNU General Public
#   License along with this library; see the file COPYING.LIB.
#   If not, write to the Free Software Foundation,
#   59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

ifeq ($(GUI_MAKE_LOADED),)
GUI_MAKE_LOADED=yes

ifeq ($(GUI_LIB),gnu)
  GUI_LDFLAGS =
  GUI_LIBS = -lgnustep-gui -lgmodel -lgnustep-gui
  GUI_DEFINE = -DGNU_GUI_LIBRARY=1
  GNUSTEP_DEFINE = -DGNUSTEP
endif

endif # GUI_MAKE_LOADED
