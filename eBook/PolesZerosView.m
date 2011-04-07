//
//  PolesZerosView.m
//  eBook
//
//  Created by Dan Lynch on 4/7/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import "PolesZerosView.h"


@implementation PolesZerosView

- (void) drawRect : (CGRect) rect {
                
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    CGContextSetRGBStrokeColor(context, 255, 255, 255, 1);
    CGContextSetRGBFillColor(context, 0,0,255,0.1);
    CGContextSetLineWidth(context, 3);
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, 0);
    for (int i=0; i<300; i++) {
		CGContextAddLineToPoint(context, i, i);
	}
	CGContextStrokePath(context);
    
    
    CGContextBeginPath(context);
    CGContextAddArc(context, 200, 200, 5, 0, 360, 1);
	CGContextStrokePath(context);
    
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"began! %@", [self description]);
}

// this function continues to add points to the points arrays
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {

    
}

// takes the points arrays and moves them into the strokes array
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    
}


- (void)dealloc {
	[super dealloc];
}


@end
