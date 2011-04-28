//
//  PageLoaderView.m
//  eBook
//
//  Created by Dan Lynch on 4/25/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import "PageLoaderView.h"
#import "PageModel.h"

#import "FilterDesignViewController.h"
#import "DiracDeltasViewController.h"
#import "UnitCircleViewController.h"
#import "PolesZerosViewController.h"
#import "GraphViewController.h"
#import "SplitViewController.h"
#import "eBookAppDelegate.h"

@implementation PageLoaderView

- (id) initWithFrame:(CGRect)frame page:(PageModel*)p {
    self = [super initWithFrame:frame];
    if (self) {
        NSString * html = @"<!DOCTYPE html><html><head><title>MathJax</title><script type=\"text/x-mathjax-config\">MathJax.Hub.Config({tex2jax: {inlineMath: [[\"$\",\"$\"],[\"\\(\",\"\\)\"]]}});</script><script type=\"text/javascript\" src=\"mathjax/MathJax.js?config=TeX-AMS_HTML-full\"></script></head><style>body{font-size: 18pt;}a{text-decoration:none;color:black;}</style><body>";
        NSString * setHtml = [[[NSString alloc] initWithFormat:@"%@%@</body></html>", html, p.content] autorelease];
        [self loadHTMLString:setHtml baseURL:[NSURL URLWithString:@"http://mathapedia.com"]]; 
        self.delegate = self;
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

#pragma UIWebView stuff

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
    //CAPTURE USER LINK-CLICK.
    
    // NSLog(@"%@ %d", request, navigationType);
    
    eBookAppDelegate * delegate = (eBookAppDelegate*) [[UIApplication sharedApplication] delegate];
    UINavigationController * nav = [delegate navigationController];
                                   
    
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        NSURL *URL = [request URL]; 
        if ([[URL scheme] isEqualToString:@"FilterDesign"]) {
            FilterDesignViewController * temp = [[FilterDesignViewController alloc] init];
            [nav pushViewController:temp animated:TRUE];
            [temp release];
        } else if ([[URL scheme] isEqualToString:@"DiracDeltas"]) {
            FilterDesignViewController * temp = [[DiracDeltasViewController alloc] init];
            [nav pushViewController:temp animated:TRUE];
            [temp release];
            
        } else if ([[URL scheme] isEqualToString:@"UnitCircle"]) {
            FilterDesignViewController * temp = [[UnitCircleViewController alloc] init];
            [nav pushViewController:temp animated:TRUE];
            [temp release];
            
        } else if ([[URL scheme] isEqualToString:@"PolesZeros"]) {
            FilterDesignViewController * temp = [[PolesZerosViewController alloc] init];
            [nav pushViewController:temp animated:TRUE];
            [temp release];
            
        } else if ([[URL scheme] isEqualToString:@"Convolution"]) {
            SplitViewController * temp = [[SplitViewController alloc] init];
            [nav pushViewController:temp animated:TRUE];
            [temp release];
            
        } else if ([[URL scheme] isEqualToString:@"Graph"]) {
            FilterDesignViewController * temp = [[GraphViewController alloc] init];
            [nav pushViewController:temp animated:TRUE];
            [temp release];
            
        } else if ([[URL scheme] isEqualToString:@"http"]) {
            
            [webView loadRequest:request];
            
        } else {
            NSLog(@"other");
            
        }
        return NO;
    }   
    return YES;   
}


@end
