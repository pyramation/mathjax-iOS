//
//  Axis.h
//  eBook
//
//  Created by Dan Lynch on 4/12/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Axis : NSObject {
 
    int xSpacing;
    int ySpacing;
    
}

- (id) initWithSpacingX:(int)x Y:(int) y;
- (void) draw: (CGContextRef) context;
- (void) drawAxis:(CGContextRef) context rect:(CGRect)rect;
@end
