/** <title>GSSlideView</title>

   Copyright (C) 2002, 2003 Free Software Foundation, Inc.

   Created by: Enrico Sersale <enrico@imago.ro>
   Date: Jan 2002
   Author: Fred Kiefer <fredkiefer@gmx.de>
   Date: Jan 2003
   Removed all dependencies on X and moved to gui.

   This file is part of the GNU Objective C User Interface Library.

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

#include <Foundation/NSDebug.h>
#include <AppKit/NSApplication.h>
#include <AppKit/NSCell.h>
#include <AppKit/NSEvent.h>
#include <AppKit/NSImage.h>
#include <AppKit/NSView.h>
#include <AppKit/NSWindow.h>

#include "AppKit/GSDisplayServer.h"
#include "GSSlideView.h"
#include <math.h>

// Minimal slide distance per step in pixel
#define MINDIST 18
// Time for each slide step in seconds
#define SLIDE_TIME_STEP 0.02

@interface GSSlideView (Private)
- (void) _setupImage: (NSImage*) image startPoint: (NSPoint)slideStart;
- (void) _slideFrom: (NSPoint)fromPoint to: (NSPoint)toPoint;
@end

@implementation GSSlideView (Private)

- (void) _setupImage: (NSImage*) image startPoint: (NSPoint)slideStart
{
  NSSize imageSize = [image size];

  [slideCell setImage: image];
  [_window setFrame: NSMakeRect(slideStart.x, slideStart.y,
				imageSize.width, imageSize.height) 
	   display: NO];

  // Only display the image
  [GSServerForWindow(_window) restrictWindow: [_window windowNumber]
		    toImage: image];

  [_window orderFrontRegardless];
}

- (void) _slideFrom: (NSPoint)fromPoint to: (NSPoint)toPoint
{
  float distx = toPoint.x - fromPoint.x;
  float disty = toPoint.y - fromPoint.y;
  float dist = sqrt((distx * distx) + (disty * disty));
  int steps = (int)(dist / MINDIST);
  int windowNumber = [_window windowNumber];
  GSDisplayServer *server = GSServerForWindow(_window);

  if (steps > 2)
    {
      float unitx = distx / steps;
      float unity = disty / steps;

      [NSEvent startPeriodicEventsAfterDelay: SLIDE_TIME_STEP 
	       withPeriod: SLIDE_TIME_STEP];
      while(steps--)
        {
	  NSEvent *theEvent = [NSApp nextEventMatchingMask: NSPeriodicMask
				     untilDate: [NSDate distantFuture]
				     inMode: NSEventTrackingRunLoopMode
				     dequeue: YES];

          if ([theEvent type] == NSPeriodic)
            {
	      fromPoint.x += unitx;
	      fromPoint.y += unity;
	      [server movewindow: fromPoint : windowNumber];
            }
	  else 
            {
              NSDebugLLog (@"NSDragging", 
			   @"Unexpected event type: %d during slide",
                           [theEvent type]);
            }
	}
      [NSEvent stopPeriodicEvents];
    }

  // Go exactly to the point
  [server movewindow: toPoint : windowNumber];
}

@end

@implementation GSSlideView

+ (BOOL) _slideImage: (NSImage *)image
	        from: (NSPoint)fromPoint
		  to: (NSPoint)toPoint
{
  static GSSlideView *v = nil;
  BOOL result = NO;

  if (image != nil)
    {
      if (v == nil)
	{
	  v = [[self alloc] init];
	}
      [NSApp preventWindowOrdering];
      [v _setupImage: image startPoint: fromPoint];
      [v _slideFrom: fromPoint to: toPoint];
      [[v window] orderOut: nil];

      result = YES;
    }
  return result;
}

- (id) init
{
  self = [super init];
  if (self != nil)
    {
      // This is never used, as the window gets resized before displaying
      NSRect winRect = {{0, 0}, {48, 48}};
      NSWindow *slideWindow;

      slideCell = [[NSCell alloc] initImageCell: nil];
      [slideCell setBordered: NO];

      slideWindow = [[NSWindow alloc] initWithContentRect: winRect
					   styleMask: NSBorderlessWindowMask
					     backing: NSBackingStoreNonretained
					       defer: NO];
      [slideWindow setReleasedWhenClosed: YES];
      [slideWindow setExcludedFromWindowsMenu: YES];
      [slideWindow setContentView: self];
      RELEASE (self);
    }

  return self;
}

- (void) dealloc
{
  RELEASE (slideCell);
  [super dealloc];
}

- (void) drawRect: (NSRect)rect
{
  [slideCell drawWithFrame: rect inView: self];
}

@end