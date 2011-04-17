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
    
}

- (void) drawRect : (CGRect) rect;


- (void) changeFreq:(id) sender;


@property (nonatomic, readwrite, assign) float freq;


@end

