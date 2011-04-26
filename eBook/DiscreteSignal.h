//
//  DiscreteSignal.h
//  eBook
//
//  Created by Dan Lynch on 4/22/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DiscreteSignal : NSObject {

    NSMutableArray * points;
    CGFloat base;
}


- (void) convolve: (DiscreteSignal *) signal signalToModify: (DiscreteSignal*) signalToMod;

@property (nonatomic, retain) NSMutableArray * points;
@property (nonatomic, assign) CGFloat base;

@end
