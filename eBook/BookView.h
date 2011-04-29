//
//  BookView.h
//  eBook
//
//  Created by Dan Lynch on 4/28/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SwipeView.h"

@interface BookView : UIView <SwipeViewDelegate> {
 
    NSMutableArray * pages;
    BOOL transitioning; 
    UIView * containerView; 

    UIView * view1; 
    UIView * view2; 

    UIView * swipeView;
}

-(void)performTransition: (NSString*) subtype;

@property (nonatomic, retain) NSMutableArray * pages;
@property (nonatomic, retain) UIView * containerView;
@property (nonatomic, retain) UIView * view1; 
@property (nonatomic, retain) UIView * view2;
@property (nonatomic, retain) UIView * swipeView;

@end
