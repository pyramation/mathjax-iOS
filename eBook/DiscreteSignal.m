//
//  DiscreteSignal.m
//  eBook
//
//  Created by Dan Lynch on 4/22/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import "DiscreteSignal.h"


@implementation DiscreteSignal

@synthesize points;

- (id) convolve: (DiscreteSignal *) signal {
    DiscreteSignal * returnSignal = [[DiscreteSignal alloc] init];
    
    // perform convolution here!
    NSMutableArray * new = [[NSMutableArray alloc] init];
    for (int i = 0; i < [points count]; i++) {
        for (int j=0; j < [signal.points count]; j++) {
            //a.set(i+j, a.get(i+j) + x[i] * h[j]);
            CGPoint x = [[points objectAtIndex:i] CGPointValue];
            CGPoint h = [[signal.points objectAtIndex:j] CGPointValue];
            CGPoint newP;
            if ([new count] > i+j) {
                CGPoint cur = [[new objectAtIndex:i+j] CGPointValue];
                newP = CGPointMake(x.x, cur.y + x.y * h.y);
            } else newP = CGPointMake(x.x, x.y * h.y);
            
            [new insertObject:[NSValue valueWithCGPoint:newP] atIndex:i+j];
        }
    }
    returnSignal.points = new;
    return returnSignal;
}

- (id) init {
    if ((self = [super init])) {
        points = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) dealloc {
    [super dealloc];
    [points release];
}

@end
