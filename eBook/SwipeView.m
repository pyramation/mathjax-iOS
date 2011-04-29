//
//  SwipeView.m
//  eBook
//
//  Created by Dan Lynch on 4/28/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import "SwipeView.h"


@implementation SwipeView

- (id)initWithFrame:(CGRect)frame delegate:(id<SwipeViewDelegate>) d
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        delegate = d;
        
    }
    return self;
}

//- (void)drawRect:(CGRect)rect
//{
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextClearRect(context, rect);
//}


- (void)dealloc
{
    [super dealloc];
}

#pragma mark - Swipes and Touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    // startTouchPosition is an instance variable
	hswipe = FALSE;
	vswipe = FALSE;
    startTouchPosition = [touch locationInView:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    currentTouchPosition = [touch locationInView:self];
	
	// horizontal swipe detection
    // To be a swipe, direction of touch must be horizontal and long enough.
    if (fabsf(startTouchPosition.x - currentTouchPosition.x) >= HORIZ_SWIPE_DRAG_MIN &&
        fabsf(startTouchPosition.y - currentTouchPosition.y) <= VERT_SWIPE_DRAG_MAX) {
        // It appears to be a swipe.
        if (startTouchPosition.x < currentTouchPosition.x) {
			hswipe = TRUE;
            [delegate swipeRight];
			//[self myProcessRightSwipe:touches withEvent:event];
        }
		else if (startTouchPosition.x > currentTouchPosition.x){
			hswipe = TRUE;
            [delegate swipeLeft];
            //[self myProcessLeftSwipe:touches withEvent:event];
		}
    }
	
	// vertical swipe detection	
//	if (fabsf(startTouchPosition.y - currentTouchPosition.y) >= VERT_SWIPE_DRAG_MIN &&
//        fabsf(startTouchPosition.x - currentTouchPosition.x) <= HORIZ_SWIPE_DRAG_MAX) {
//		if (startTouchPosition.y < currentTouchPosition.y) {
//			vswipe = TRUE;
//			NSLog(@"swipe down ");
//			//[self myProcessRightSwipe:touches withEvent:event];
//		}
//		else if (startTouchPosition.y > currentTouchPosition.y){
//			vswipe = TRUE;
//			NSLog(@"swipe up");
//			//[self myProcessLeftSwipe:touches withEvent:event];
//		}
//	}
}

@end
