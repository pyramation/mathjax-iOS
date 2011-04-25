//
//  PageLoaderView.m
//  eBook
//
//  Created by Dan Lynch on 4/25/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import "PageLoaderView.h"
#import "Page.h"

@implementation PageLoaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id) initWithFrame:(CGRect)frame page:(Page*)p {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadHTMLString:p.content baseURL:[NSURL URLWithString:@"http://mathapedia.com"]]; 
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

@end
