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
@synthesize pages, containerView, view1, view2;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.pages = [[NSMutableArray alloc] initWithArray:[[CDHelper sharedHelper] allPages]];
        self.containerView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        if ([pages count] >= 2) {
            
            // PageLoaderView
            self.view1 = [[PageLoaderView alloc] initWithFrame:[[UIScreen mainScreen] bounds] page:[pages objectAtIndex:0]];
            self.view2 = [[PageLoaderView alloc] initWithFrame:[[UIScreen mainScreen] bounds] page:[pages objectAtIndex:1]];
            [containerView addSubview:view1];
            [containerView addSubview:view2];
        
        }
        [self addSubview:containerView];
        [containerView release];
        
        
        
        
        UIToolbar* toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height-105, [[UIScreen mainScreen] bounds].size.width, 100)];
        [toolbar sizeToFit];
        toolbar.barStyle = UIBarStyleBlackTranslucent;
        
        
        UIBarButtonItem* buttonItem1 = [[UIBarButtonItem alloc] initWithTitle:@"Next Page" style:UIBarButtonSystemItemAction target:self action:@selector(performTransition)];
        
        [toolbar setItems:[NSArray arrayWithObjects:buttonItem1, nil]];
        
        [buttonItem1 release];
        
        
        [self addSubview:toolbar];
        [toolbar release];
        

            
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
    [view1 release];
    [view2 release];
    [containerView release];
    [pages release];
    [super dealloc];
}

#pragma mark - Transitions

-(void)performTransition
{
	// First create a CATransition object to describe the transition
	CATransition *transition = [CATransition animation];
	// Animate over 3/4 of a second
	transition.duration = 0.75;
	// using the ease in/out timing function
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	
	// Now to set the type of transition. Since we need to choose at random, we'll setup a couple of arrays to help us.
	NSString *types[4] = {kCATransitionMoveIn, kCATransitionPush, kCATransitionReveal, kCATransitionFade};
	NSString *subtypes[4] = {kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom};
	int rnd = random() % 4;
	transition.type = types[rnd];
	if(rnd < 3) // if we didn't pick the fade transition, then we need to set a subtype too
	{
		transition.subtype = subtypes[random() % 4];
	}
	
	// Finally, to avoid overlapping transitions we assign ourselves as the delegate for the animation and wait for the
	// -animationDidStop:finished: message. When it comes in, we will flag that we are no longer transitioning.
	transitioning = YES;
	transition.delegate = self;
	
	// Next add it to the containerView's layer. This will perform the transition based on how we change its contents.
	[containerView.layer addAnimation:transition forKey:nil];
	
	// Here we hide view1, and show view2, which will cause Core Animation to animate view1 away and view2 in.
	view1.hidden = YES;
	view2.hidden = NO;
	
	// And so that we will continue to swap between our two images, we swap the instance variables referencing them.
	UIView *tmp = view2;
	view2 = view1;
	view1 = tmp;
}

@end
