//
//  PolesZerosView.h
//  eBook
//
//  Created by Dan Lynch on 4/7/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PolesZerosView : UIView {
    

    NSMutableArray *zeros;
    NSMutableArray *poles;
    
    CGPoint imagePoint;

    bool _poles;
    bool _vectors;
    
}


- (float) pDist : (CGPoint) a point2: (CGPoint) b;

- (void) clearAll;
- (void) vectorDisplay;
- (void) addPoles;
- (void) addZeros;
- (bool) onTouch: (NSMutableArray*) array touch:(UITouch*) t;
- (void) drawPolesZeros:(NSMutableArray*) array context: (CGContextRef) context x:(float) x y: (float) y poleOrZero:(bool)poleOrZero;

- (void) drawRect : (CGRect) rect;
- (void) addPoint : (CGPoint) point;

// touches
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;



@end

