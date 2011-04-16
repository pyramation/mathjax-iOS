//
//  FilterDesign.h
//  eBook
//
//  Created by Dan Lynch on 4/14/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Axis;

@interface FilterDesign : UIView {
    
    Axis * axis;
    NSMutableArray *bezierPoints0, *bezierPoints1;
	NSMutableArray *points;
	BOOL useStroke, bezierPoints, follower;
    CGPoint imagePoint;
    UIImageView *myImage;
    CGRect myImageRect;
    
}


- (CGPoint) lerp : (CGPoint) a p2 : (CGPoint) b time: (float) u; 
- (CGPoint) deCasteljau : (NSMutableArray *) array time: (float) u;
- (float) pDist : (CGPoint) a point2: (CGPoint) b;


- (void) drawRect : (CGRect) rect;
- (void) addPoint : (CGPoint) point;
- (void) plotPoints : (CGRect) rect theContext: (CGContextRef) context;
- (void) clearAllStrokes;

// touches
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;

- (void) clearStrokes : (id) sender;
- (void) toggleBezier : (id) sender;
- (void) toggleFollower : (id) sender;

@property (nonatomic, retain) Axis * axis;

@end

