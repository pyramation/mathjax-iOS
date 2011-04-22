//
//  ConvolveDeltas.h
//  eBook
//
//  Created by Dan Lynch on 4/7/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import <UIKit/UIKit.h>


@class Axis;
@interface ConvolveDeltasView : UIView {
    
	NSMutableArray *points;
    CGPoint imagePoint;
    Axis * axis;
    
}


- (float) pDist : (CGPoint) a point2: (CGPoint) b;

- (void) clearAll;
- (void) drawRect : (CGRect) rect;


// touches
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;



@end

