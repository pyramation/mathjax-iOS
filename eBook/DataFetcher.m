//
//  DataFetcher.m
//  eBook
//
//  Created by Dan Lynch on 4/18/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import "DataFetcher.h"


@implementation DataFetcher
@synthesize fetcher, delegate, base, queries;

-(id) initWithBase: (NSString*) _base andQueries: (NSDictionary*) _queries andDelegate: (id<DataFetcherDelegate>) _delegate {
    if ((self = [super init])) {
        self.base = _base;
        self.queries = _queries;
        self.delegate = _delegate;        
    }
    return self;
}

-(void) fetch {
    JSONFetcher* temp = [[JSONFetcher alloc] init];
    self.fetcher = temp;
    [temp release];
    fetcher._delegate = self;
    [fetcher fetchURL:base withQueries:queries];
}


-(id) getResponseFromResult: (id) result {
    return result;
}


// RESULT SHOULD BE A DICTIONARY, PASSED IN FROM JSONFetcher.m
-(void) fetcherFinished:(JSONFetcher *)_fetcher withResult:(id)result {
    id response = [self getResponseFromResult:result];
    [delegate dataFetcher:self hasResponse:response];
}

-(void) dealloc {
    [super dealloc];
    [base release];
    [queries release];
}

@end
