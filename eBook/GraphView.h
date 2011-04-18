//
//  GraphView.h
//  eBook
//
//  Created by Dan Lynch on 4/7/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GraphView : UIView {
    
    CGPoint lastTouch;
    float freq;

    CGPoint lLimit;
    CGPoint rLimit;
    
}

- (void) drawRect : (CGRect) rect;


- (void) changeFreq:(id) sender;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;

@property (nonatomic, readwrite, assign) float freq;

@end

