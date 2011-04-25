//
//  Page.m
//  eBook
//
//  Created by Dan Lynch on 4/25/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import "Page.h"


@implementation Page
@synthesize name, desc, content;

- (void) dealloc {
    [name release];
    [desc release];
    [content release];
    [super dealloc];
}

@end
