//
//  SwipeView.h
//  eBook
//
//  Created by Dan Lynch on 4/28/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import <UIKit/UIKit.h>

#define HORIZ_SWIPE_DRAG_MIN  50	// for horizontal swipe
#define VERT_SWIPE_DRAG_MAX    10	// for horizontal swipe

#define VERT_SWIPE_DRAG_MIN  150	// for vertical swipe
#define HORIZ_SWIPE_DRAG_MAX    10	// for vertical swipe

@protocol TouchSwipeViewDelegate; 
@interface TouchSwipeView : UIView {

    CGPoint startTouchPosition;
	CGPoint currentTouchPosition;
    
    id<TouchSwipeViewDelegate>delegate;
    
}

- (id)initWithFrame:(CGRect)frame delegate:(id<TouchSwipeViewDelegate>) d;

@end

@protocol TouchSwipeViewDelegate <NSObject>

@required
- (void) swipeLeft;
- (void) swipeRight;
- (void) swipeUp;
- (void) swipeDown;

- (void) doubleTap;
- (void) singleTap;

@end