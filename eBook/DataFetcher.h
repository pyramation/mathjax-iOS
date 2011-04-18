//
//  DataFetcher.h
//  eBook
//
//  Created by Dan Lynch on 4/18/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataFetcherDelegate.h"
#import "JSONFetcher.h"

@class JSONFetcher;

@interface DataFetcher : NSObject <JSONFetcherDelegate> {
    JSONFetcher* fetcher;
    id<DataFetcherDelegate> delegate;
    NSString* base;
    NSDictionary* queries;
}

@property (nonatomic, retain) JSONFetcher* fetcher;
@property (nonatomic, assign) id<DataFetcherDelegate> delegate;
@property (nonatomic, retain) NSString* base;
@property (nonatomic, retain) NSDictionary* queries;

-(id) getResponseFromResult: (id) result;
-(void) fetcherFinished:(JSONFetcher *)_fetcher withResult:(id)result;
-(id) initWithBase: (NSString*) _base andQueries: (NSDictionary*) _queries andDelegate: (id<DataFetcherDelegate>) _delegate;
-(void) fetch;
@end

