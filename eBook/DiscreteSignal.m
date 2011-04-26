//
//  DiscreteSignal.m
//  eBook
//
//  Created by Dan Lynch on 4/22/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import "DiscreteSignal.h"


@implementation DiscreteSignal

@synthesize points, base;

- (void) convolve: (DiscreteSignal *) signal signalToModify: (DiscreteSignal*) signalToMod {
    
    [signalToMod.points removeAllObjects];
    
    // perform convolution here!
    for (int i = 0; i < [points count]; i++) {
        for (int j=0; j < [signal.points count]; j++) {
            //a.set(i+j, a.get(i+j) + x[i] * h[j]);
            CGPoint x = [[points objectAtIndex:i] CGPointValue];
            x.y -= base;
            CGPoint h = [[signal.points objectAtIndex:j] CGPointValue];
            h.y -= base;
            CGPoint newP;
            if ([signalToMod.points count] > i+j) {
                CGPoint cur = [[signalToMod.points objectAtIndex:i+j] CGPointValue];
                cur.y -= base;
                newP = CGPointMake(x.x, cur.y + x.y * h.y);
            } else newP = CGPointMake(x.x, x.y * h.y);
            
            newP.y += base;
            [signalToMod.points insertObject:[NSValue valueWithCGPoint:newP] atIndex:i+j];
        }
    }
    
    NSLog(@"num points: %d", [points count]);
    NSLog(@"num points: %d", [signal.points count]);
    NSLog(@"num points: %d", [signalToMod.points count]);
    
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
