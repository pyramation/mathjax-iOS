//
//  BookView.m
//  eBook
//
//  Created by Dan Lynch on 4/28/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "BookView.h"

#import "PageLoaderView.h"
#import "PageModel.h"

#import "CDHelper.h"
#import "CDPage.h"

@implementation BookView
@synthesize pages, containerView, swipeView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.pages = [[NSMutableArray alloc] initWithArray:[[CDHelper sharedHelper] allPages]];
        
        self.containerView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        
        self.swipeView = [[TouchSwipeView alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height-205, [[UIScreen mainScreen] bounds].size.width, 205) delegate:self];

        
       for(int i=0; i<[pages count]; i++) {
            [containerView addSubview: [[PageLoaderView alloc] initWithFrame:[[UIScreen mainScreen] bounds] page:[pages objectAtIndex:i]]];
        }
        
        
        [containerView addSubview:swipeView];
        [self addSubview:containerView];
        
        index = 0;
            
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame withPages: (NSMutableArray*) pgs
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.pages = pgs;
        
        self.containerView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        
        self.swipeView = [[TouchSwipeView alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height-205, [[UIScreen mainScreen] bounds].size.width, 205) delegate:self];
        
        
        for(int i=0; i<[pages count]; i++) {
            [containerView addSubview: [[PageLoaderView alloc] initWithFrame:[[UIScreen mainScreen] bounds] page:[pages objectAtIndex:i]]];
        }
        
        
        [containerView addSubview:swipeView];
        [self addSubview:containerView];
        
        index = 0;
        
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc
{
    [containerView release];
    [pages release];
    [super dealloc];
}

#pragma mark - pages

- (void) refreshPages {

    [pages removeAllObjects];
    [pages addObjectsFromArray:[[CDHelper sharedHelper] allPages]];

    while( [[containerView subviews] count] > 0 ) {
        [[[containerView subviews] objectAtIndex:0] removeFromSuperview]; 
    }
    for(int i=0; i<[pages count]; i++) {
        PageLoaderView * pv = [[[PageLoaderView alloc] initWithFrame:[[UIScreen mainScreen] bounds] page:[pages objectAtIndex:i]] autorelease];
        
        [containerView addSubview: pv];
    }
    [containerView addSubview:swipeView];

}

#pragma mark - Transitions

-(void)performTransition: (NSString*) subtype type: (NSString*) type 
{
    
    if ([[containerView subviews] count] <= 1) return;
    
	// First create a CATransition object to describe the transition
	CATransition *transition = [CATransition animation];
	// Animate over 3/4 of a second
	transition.duration = 0.65;
	// using the ease in/out timing function
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	
	// Now to set the type of transition. Since we need to choose at random, we'll setup a couple of arrays to help us.

    transition.type = type;
    transition.subtype = subtype;
    
	
	// Finally, to avoid overlapping transitions we assign ourselves as the delegate for the animation and wait for the
	// -animationDidStop:finished: message. When it comes in, we will flag that we are no longer transitioning.
	transitioning = YES;
	transition.delegate = self;
	
	// Next add it to the containerView's layer. This will perform the transition based on how we change its contents.
	[containerView.layer addAnimation:transition forKey:nil];
    
    for(int i=0; i<[[containerView subviews] count]; i++) {
        if ([[[containerView subviews] objectAtIndex:i] isKindOfClass:[PageLoaderView class]]) {            
            UIView* v = (UIView*) [[containerView subviews] objectAtIndex:i];
            v.hidden = YES;
        }
    }
    
    
    unsigned int u;
    
    if (subtype == kCATransitionFromLeft) {
        u = --index % [pages count];
    } else {
        u = ++index % [pages count];        
    }
    
    NSLog(@"%u", u);
    
    UIView * cv = [[containerView subviews] objectAtIndex:u];
    cv.hidden = NO;
    
}

#pragma mark - Swipe Delegate

- (void) swipeLeft {
    
	if(!transitioning)
	{
		[self performTransition: kCATransitionFromRight type:kCATransitionReveal];
	}
    
}

- (void) swipeRight {

	if(!transitioning)
	{
		[self performTransition: kCATransitionFromLeft type:kCATransitionReveal];
	}
     
}

- (void) swipeDown {
    
}

- (void) swipeUp {
    
}

- (void) doubleTap {
    
    
    [self refreshPages];
    index = -1;
    
    if(!transitioning)
	{
		[self performTransition: kCATransitionFromTop type:kCATransitionMoveIn];
	}
}

- (void) singleTap {
    
}

#pragma mark - Transition Delegate

-(void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag
{
	transitioning = NO;
}


@end
