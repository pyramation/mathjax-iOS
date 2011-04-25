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
