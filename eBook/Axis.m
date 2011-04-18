//
//  Axis.m
//  eBook
//
//  Created by Dan Lynch on 4/12/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import "Axis.h"

@implementation Axis

- (void) draw: (CGContextRef) context {
    
    // draw grid lines
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 0.225);
    CGContextSetLineWidth(context, 1);
    
    for (int i=0; i<[UIScreen mainScreen].bounds.size.width; i+=30) {
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, i, [UIScreen mainScreen].bounds.size.height);
        CGContextAddLineToPoint(context, i, [UIScreen mainScreen].bounds.size.height);
        CGContextAddLineToPoint(context, i, 0);    
        CGContextStrokePath(context);
        
    }
    for (int i=0; i<[UIScreen mainScreen].bounds.size.height; i+=30) {
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, [UIScreen mainScreen].bounds.size.width, i);
        CGContextAddLineToPoint(context, [UIScreen mainScreen].bounds.size.width, i);
        CGContextAddLineToPoint(context, 0, i);    
        CGContextStrokePath(context);
    }

    
}

@end
