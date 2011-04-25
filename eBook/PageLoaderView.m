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

- (id) initWithFrame:(CGRect)frame page:(Page*)p {
    self = [super initWithFrame:frame];
    if (self) {
        NSString * html = @"<!DOCTYPE html><html><head><title>MathJax</title><script type=\"text/x-mathjax-config\">MathJax.Hub.Config({tex2jax: {inlineMath: [[\"$\",\"$\"],[\"\\(\",\"\\)\"]]}});</script><script type=\"text/javascript\" src=\"mathjax/MathJax.js?config=TeX-AMS_HTML-full\"></script></head><body>";
        NSString * setHtml = [[[NSString alloc] initWithFormat:@"%@%@</body></html>", html, p.content] autorelease];
        [self loadHTMLString:setHtml baseURL:[NSURL URLWithString:@"http://mathapedia.com"]]; 
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

@end
