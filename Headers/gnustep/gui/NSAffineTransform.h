/*
   NSAffineTransform.h

   Copyright (C) 1996 Free Software Foundation, Inc.

   Author: Ovidiu Predescu <ovidiu@net-community.com>
   Date: August 1997
   Rewrite for macOS-X compatibility: Richard Frith-Macdonald, 1999
   
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
   License along with this library; if not, write to the Free
   Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
*/

#ifndef _GNUstep_H_NSAffineTransform
#define _GNUstep_H_NSAffineTransform

#include <Foundation/NSObject.h>
#include <Foundation/NSGeometry.h>

@class NSBezierPath;

typedef	struct {
  float	m11;
  float	m12;
  float	m21;
  float	m22;
  float	tx;
  float	ty;
} NSAffineTransformStruct;

@interface NSAffineTransform : NSObject <NSCopying>
{
@public
  NSAffineTransformStruct	matrix;
  float rotationAngle;
}

+ (NSAffineTransform*) transform;
- (void) appendTransform: (NSAffineTransform*)aTransform;
- (void) concat;
- (id) initWithTransform: (NSAffineTransform*)aTransform;
- (void) invert;
- (void) prependTransform: (NSAffineTransform*)aTransform;
- (void) rotateByDegrees: (float)angle;
- (void) rotateByRadians: (float)angle;
- (void) scaleBy: (float)scale;
- (void) scaleXBy: (float)scaleX yBy: (float)scaleY;
- (void) set;
- (void) setTransformStruct: (NSAffineTransformStruct)val;
- (NSBezierPath*) transformBezierPath: (NSBezierPath*)aPath;
- (NSPoint) transformPoint: (NSPoint)aPoint;
- (NSSize) transformSize: (NSSize)aSize;
- (NSAffineTransformStruct) transformStruct;
- (void) translateXBy: (float)tranX yBy: (float)tranY;

#ifndef	NO_GNUSTEP
+ (NSAffineTransform*) matrixFrom: (const float[6])matrix;
- (void) translateToPoint: (NSPoint)point;
- (void) rotateByAngle: (float)angle;
- (void) scaleBy: (float)sx : (float)sy;
- (void) scaleTo: (float)sx : (float)sy;
- (void) makeIdentityMatrix;
- (float) rotationAngle;
- (void) setFrameOrigin: (NSPoint)point;
- (void) setFrameRotation: (float)angle;
- (void) inverse;

- (BOOL) isRotated;

- (void) boundingRectFor: (NSRect)rect result: (NSRect*)result;

/* Returns anotherMatrix * self */
- (void) concatenateWith: (NSAffineTransform*)anotherMatrix;

- (NSPoint) pointInMatrixSpace: (NSPoint)point;
- (NSSize) sizeInMatrixSpace: (NSSize)size;
- (NSRect) rectInMatrixSpace: (NSRect)rect;

- (void) setMatrix: (const float[6])replace;
- (void) getMatrix: (float[6])replace;

/* Private definitions */
#define A matrix.m11
#define B matrix.m12
#define C matrix.m21
#define D matrix.m22
#define TX matrix.tx
#define TY matrix.ty

#endif
@end

#endif /* _GNUstep_H_NSAffineTransform */
