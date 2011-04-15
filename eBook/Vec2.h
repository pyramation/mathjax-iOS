//
//  Vec2.h
//  eBook
//
//  Created by Dan Lynch on 4/12/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Vec2 : NSObject {
    float x;
    float y;
}

- (id)initiWithValuesX:(float)xx Y:(float)yy;

@property (nonatomic, readwrite, assign) float x;
@property (nonatomic, readwrite, assign) float y;
@end
