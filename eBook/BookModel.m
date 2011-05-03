//
//  BookModel.m
//  eBook
//
//  Created by Dan Lynch on 4/29/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import "BookModel.h"


@implementation BookModel
@synthesize pages, desc, title;

- (id) init {
    
    if ((self = [super init])) {
        self.pages = [[NSMutableArray alloc] init];
        self.title = [[NSString alloc] init]; 
        self.desc = [[NSString alloc] init]; 
    }
    return self;
}

- (void)dealloc {
    [title release];
    [desc release];
    [pages release];
    [super dealloc];
    
}

@end
