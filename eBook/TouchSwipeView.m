//
//  SwipeView.m
//  eBook
//
//  Created by Dan Lynch on 4/28/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import "TouchSwipeView.h"


@implementation TouchSwipeView

- (id)initWithFrame:(CGRect)frame delegate:(id<TouchSwipeViewDelegate>) d
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
            [delegate swipeRight];
        }
		else if (startTouchPosition.x > currentTouchPosition.x){
            [delegate swipeLeft];
		}
    }
	
	// vertical swipe detection	
//	if (fabsf(startTouchPosition.y - currentTouchPosition.y) >= VERT_SWIPE_DRAG_MIN &&
//        fabsf(startTouchPosition.x - currentTouchPosition.x) <= HORIZ_SWIPE_DRAG_MAX) {
//		if (startTouchPosition.y < currentTouchPosition.y) {
//            [delegate swipeDown];
//		}
//		else if (startTouchPosition.y > currentTouchPosition.y){
//            [delegate swipeUp];
//		}
//	}
}

- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event  {
    
        if([[touches anyObject] tapCount] == 2) {
            [delegate doubleTap];
        } else if ([[touches anyObject] tapCount] == 1) {
            [delegate singleTap];
        }
 
}

@end
