/* 
   NSNib.h

   Holds an image to use as a cursor

   Copyright (C) 2004 Free Software Foundation, Inc.

   Author: Gregory John Casamento <greg_casamento@yahoo.com>
   Date: 2004
   
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

#ifndef _GNUstep_H_NSNib
#define _GNUstep_H_NSNib

#include <Foundation/NSObject.h>
#include <Foundation/NSZone.h>

@class NSData;
@class NSDictionary;
@class NSString;
@class NSBundle;
@class NSURL;
@class NSArray;

@interface NSNib : NSObject <NSCoding>
{
  NSData *_nibData;
}

// reading the data...
- (id)initWithContentsOfURL: (NSURL *)nibFileURL;
- (id)initWithNibNamed: (NSString *)nibNamed bundle: (NSBundle *)bundle;

// instantiating the nib.
- (BOOL)instantiateNibWithExternalNameTable: (NSDictionary *)externalNameTable;
- (BOOL)instantiateNibWithOwner: (id)owner topLevelObjects: (NSArray **)topLevelObjects;

#ifndef NO_GNUSTEP
- (BOOL)instantiateNibWithExternalNameTable: (NSDictionary *)externalNameTable withZone: (NSZone *)zone;
#endif

@end

#endif /* _GNUstep_H_NSNib */
