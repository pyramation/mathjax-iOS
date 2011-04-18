//
//  UnitCircleView.h
//  eBook
//
//  Created by Dan Lynch on 4/7/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Axis;
@interface UnitCircleView : UIView {

    CGPoint lastTouch;
    Axis * axis;
    
    UILabel * angleLabel;    
}


- (void) drawRect : (CGRect) rect;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;

@property (nonatomic, retain) Axis * axis;
@property (nonatomic, retain) UILabel * angleLabel;

@end

