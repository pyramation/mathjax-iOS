//
//  Delta.m
//  eBook
//
//  Created by Dan Lynch on 4/21/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import "Delta.h"


@implementation Delta

- (void) draw:(CGContextRef)context {
    
    [self drawVector:context];
    [self drawDot:context];
    
}

@end
