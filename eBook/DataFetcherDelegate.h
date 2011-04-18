//
//  DataFetcherDelegate.h
//  eBook
//
//  Created by Dan Lynch on 4/18/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

@class DataFetcher;

@protocol DataFetcherDelegate <NSObject>

-(void) dataFetcher: (DataFetcher*) fetcher hasResponse: (id) response;

@end
