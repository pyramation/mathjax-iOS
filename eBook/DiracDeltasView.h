//
//  DiracDeltas.h
//  eBook
//
//  Created by Dan Lynch on 4/7/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DiracDeltasView : UIView {
    
    NSMutableArray *bezierPoints0, *bezierPoints1;
	NSMutableArray *points;
	BOOL useStroke, bezierPoints, follower;
    CGPoint imagePoint;
    UIImageView *myImage;
    CGRect myImageRect;
    
}


- (float) pDist : (CGPoint) a point2: (CGPoint) b;

- (void) clearAll;
- (void) drawRect : (CGRect) rect;
- (void) addPoint : (CGPoint) point;

// touches
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;



@end

