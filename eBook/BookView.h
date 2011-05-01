//
//  BookView.h
//  eBook
//
//  Created by Dan Lynch on 4/28/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TouchSwipeView.h"

@interface BookView : UIView <TouchSwipeViewDelegate> {
 
    NSMutableArray * pages;
    
    BOOL transitioning; 
    UIView * containerView; 

    UIView * swipeView;

    int index;
}

-(void)performTransition: (NSString*) subtype type: (NSString*) type;
- (id)initWithFrame:(CGRect)frame withPages: (NSMutableArray*) pgs;

- (void) refreshPages;

@property (nonatomic, retain) NSMutableArray * pages;
@property (nonatomic, retain) UIView * containerView;
@property (nonatomic, retain) UIView * swipeView;

@end
