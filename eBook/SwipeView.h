//
//  SwipeView.h
//  eBook
//
//  Created by Dan Lynch on 4/28/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import <UIKit/UIKit.h>

#define HORIZ_SWIPE_DRAG_MIN  100	// for horizontal swipe
#define VERT_SWIPE_DRAG_MAX    10	// for horizontal swipe
#define VERT_SWIPE_DRAG_MIN  150	// for vertical swipe
#define HORIZ_SWIPE_DRAG_MAX    10	// for vertical swipe

@protocol SwipeViewDelegate; 
@interface SwipeView : UIView {

    CGPoint startTouchPosition;
	CGPoint currentTouchPosition;
	BOOL hswipe;
	BOOL vswipe;
    
    id<SwipeViewDelegate>delegate;
    
}

- (id)initWithFrame:(CGRect)frame delegate:(id<SwipeViewDelegate>) d;

@end

@protocol SwipeViewDelegate <NSObject>

@required
- (void) swipeLeft;
- (void) swipeRight;

@end