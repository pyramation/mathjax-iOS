//
//  Page.m
//  eBook
//
//  Created by Dan Lynch on 4/25/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import "PageModel.h"


@implementation PageModel
@synthesize name, desc, content;


#pragma mark encoding

-(void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name];
    [aCoder encodeObject:self.desc];
    [aCoder encodeObject:self.content];
}

-(id) initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super init])) {
        self.name = [aDecoder decodeObject];
        self.desc = [aDecoder decodeObject];
        self.content = [aDecoder decodeObject];
    }
    return self;
}

#pragma mark Memory

- (void) dealloc {
    [name release];
    [desc release];
    [content release];
    [super dealloc];
}

@end
