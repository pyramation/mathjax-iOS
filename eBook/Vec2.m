//
//  Vec2.m
//  eBook
//
//  Created by Dan Lynch on 4/12/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import "Vec2.h"


@implementation Vec2

@synthesize x, y;

- (id)initiWithValuesX:(float)xx Y:(float)yy {
    
    self.x = xx;
    self.y = yy;
    return self;
}

@end
