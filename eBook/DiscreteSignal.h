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
    
}

- (id) convolve: (DiscreteSignal *) signal;

@property (nonatomic, retain) NSMutableArray * points;

@end
