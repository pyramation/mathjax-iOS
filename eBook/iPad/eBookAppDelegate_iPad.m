//
//  eBookAppDelegate_iPad.m
//  eBook
//
//  Created by Dan Lynch on 4/7/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import "eBookAppDelegate_iPad.h"

@implementation eBookAppDelegate_iPad

- (void)dealloc{[super dealloc];}

- (IBAction)loadDemo:(UIButton *)sender {
        
    UIWebView *htmlView = [[UIWebView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 480.0)];
    [htmlView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://mathapedia.com"]]];
    [htmlView setScalesPageToFit:YES];
	[self.window addSubview:htmlView];
	[htmlView release];
    
}


@end
