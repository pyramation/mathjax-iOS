//
//  BookModel.m
//  eBook
//
//  Created by Dan Lynch on 4/29/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import "BookModel.h"


@implementation BookModel
@synthesize pages;


- (void)dealloc {
    [pages release];
    [super dealloc];
    
}

@end
