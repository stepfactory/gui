/** <title>GSCUPSPageLayout</title>

   <abstract></abstract>

   Copyright (C) 2004 Free Software Foundation, Inc.
   Author: Chad Hardin <cehardin@mac.com>
   Date: October 2004
   
   This file is part of the GNUstep GUI Library.

   This library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Library General Public
   License as published by the Free Software Foundation; either
   version 2 of the License, or (at your option) any later version.
   
   This library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Library General Public License for more details.

   You should have received a copy of the GNU Library General Public
   License along with this library; see the file COPYING.LIB.
   If not, write to the Free Software Foundation,
   51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.

*/ 
#include <Foundation/NSDebug.h>
#include "GSCUPSPageLayout.h"


@implementation GSCUPSPageLayout
//
// Class methods
//
+ (void)initialize
{
  NSDebugMLLog(@"GSPrinting", @"");
  if (self == [GSCUPSPageLayout class])
    {
      // Initial version
      [self setVersion:1];
    }
}


+ (id) allocWithZone: (NSZone*)zone
{
  NSDebugMLLog(@"GSPrinting", @"");
  return NSAllocateObject(self, 0, zone);
}


@end