//
//  JSONFetcher.h
//  eBook
//
//  Created by Dan Lynch on 4/18/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import <Foundation/Foundation.h>


#import <Foundation/Foundation.h>
#import "ASIHTTPRequestDelegate.h"
#import "JSONFetcherDelegate.h"


@class ASIHTTPRequest;
@interface JSONFetcher : NSObject <ASIHTTPRequestDelegate> {
    id<JSONFetcherDelegate> _delegate;
}

@property (assign, nonatomic) id<JSONFetcherDelegate> _delegate;

-(void) fetchURL: (NSString*) base withQueries: (NSDictionary*) dictionary;
-(NSURL*) urlFromBase: (NSString*) base andQueries: (NSDictionary*) dictionary;

- (void)requestFinished:(ASIHTTPRequest *)request;
- (void)requestFailed:(ASIHTTPRequest *)request;

@end

