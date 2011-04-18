//
//  JSONFetcherDelegate.h
//  eBook
//
//  Created by Dan Lynch on 4/18/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

@class JSONFetcher;

@protocol JSONFetcherDelegate <NSObject>

@optional

@required
- (void)fetcherFinished: (JSONFetcher*) fetcher withResult: (id) result;

@end