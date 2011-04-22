//
//  Axis.m
//  eBook
//
//  Created by Dan Lynch on 4/12/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import "Axis.h"

@implementation Axis

- (id) init {
    if ((self = [super init])) {
        xSpacing = 30;
        ySpacing = 30;
    }
    return self;
}

- (id) initWithSpacingX:(int)x Y:(int) y {
    
    if ((self = [super init])) {
        xSpacing = x;
        ySpacing = y;
    }
    return self;    
}
- (void) drawAxis:(CGContextRef)context rect:(CGRect)rect{
    
    
    NSLog(@"the originY %f and the heightY %f", rect.origin.y, rect.size.height);
    
 //   CGFloat x = frame.size.width/2.0 + frame.origin.x;
    CGFloat y = rect.origin.y + rect.size.height/2.0; 

    NSLog(@"axis at %f", y);
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, rect.size.width, y);
    CGContextAddLineToPoint(context, rect.size.width, y);
    CGContextAddLineToPoint(context, 0, y);    
    CGContextStrokePath(context);

    for(int i=rect.origin.x; i<rect.origin.x+rect.size.width; i+=xSpacing) {
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, i, y-10);
        CGContextAddLineToPoint(context, i, y-10);
        CGContextAddLineToPoint(context, i, y+10);    
        CGContextStrokePath(context);
    }

    

}

- (void) draw: (CGContextRef) context {
    
    // draw grid lines
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 0.225);
    CGContextSetLineWidth(context, 1);
    
    for (int i=0; i<[UIScreen mainScreen].bounds.size.width; i+=xSpacing) {
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, i, [UIScreen mainScreen].bounds.size.height);
        CGContextAddLineToPoint(context, i, [UIScreen mainScreen].bounds.size.height);
        CGContextAddLineToPoint(context, i, 0);    
        CGContextStrokePath(context);
        
    }
    for (int i=0; i<[UIScreen mainScreen].bounds.size.height; i+=ySpacing) {
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, [UIScreen mainScreen].bounds.size.width, i);
        CGContextAddLineToPoint(context, [UIScreen mainScreen].bounds.size.width, i);
        CGContextAddLineToPoint(context, 0, i);    
        CGContextStrokePath(context);
    }

    
}

@end
