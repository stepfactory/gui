/*
   GSTypesetter.m

   Copyright (C) 2002 Free Software Foundation, Inc.

   Author: Alexander Malmberg <alexander@malmberg.org>
   Date: 2002

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
   59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
*/

#include "AppKit/GSTypesetter.h"

#include "AppKit/GSLayoutManager.h"
#include "AppKit/GSHorizontalTypesetter.h"

#include <Foundation/NSDictionary.h>
#include <AppKit/NSAttributedString.h>


@implementation GSTypesetter

+ (NSSize) printingAdjustmentsInLayoutManager: (GSLayoutManager *)layoutManager
		 forNominallySpacedGlyphRange: (NSRange)glyphRange
				 packedGlyphs: (const unsigned char *)glyphs
					count: (unsigned)packedGlyphCount
{
  return NSMakeSize(0,0);
}

+(GSTypesetter *) sharedSystemTypesetter
{
  return [GSHorizontalTypesetter sharedInstance];
}


-(NSFont *) fontForCharactersWithAttributes: (NSDictionary *)attributes
{
  NSFont *f = [attributes valueForKey: NSFontAttributeName];
  if (!f)
    f = [NSFont userFontOfSize: 0];
  return f;
}


-(int) layoutGlyphsInLayoutManager: (GSLayoutManager *)layoutManager
		   inTextContainer: (NSTextContainer *)textContainer
	      startingAtGlyphIndex: (unsigned int)glyphIndex
	  previousLineFragmentRect: (NSRect)previousLineFragRect
		    nextGlyphIndex: (unsigned int *)nextGlyphIndex
	     numberOfLineFragments: (unsigned int)howMany
{
  [self subclassResponsibility: _cmd];
  return 0;
}


-(BOOL) relayoutGlyphsInLayoutManager: (GSLayoutManager *)layoutManager
			   glyphRange: (NSRange)glyphRange
		     lineFragmentRect: (NSRect *)lineFragRect
			textContainer: (NSTextContainer **)textContainer
	     previousLineFragmentRect: (NSRect)previousLineFragRect
{
	return NO;
}

@end
