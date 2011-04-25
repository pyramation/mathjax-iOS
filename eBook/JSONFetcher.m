//
//  JSONFetcher.m
//  eBook
//
//  Created by Dan Lynch on 4/18/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import "JSONFetcher.h"
#import "ASIHTTPRequest.h"
#import "CJSONDeserializer.h"

@implementation JSONFetcher
@synthesize _delegate;

-(void) fetchURL: (NSString*) base withQueries: (NSDictionary*) dictionary {
    NSURL* url = [self urlFromBase:base andQueries:dictionary];
    ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
    request.delegate = self;
    [request startAsynchronous];
}

-(NSURL*) urlFromBase: (NSString*) base andQueries: (NSDictionary*) dictionary {
    NSString* urlString = [NSString stringWithString:base];
    NSString* flag = @"?";
    NSString* value;
    NSEnumerator *enumerator = [dictionary keyEnumerator];
    id key;
    while ((key = [enumerator nextObject])) {
        value = [dictionary objectForKey:key];
        urlString = [urlString stringByAppendingFormat:@"%@%@=%@",
                     flag,[key stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding],
                     [value stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
        flag = @"&";
    }
    return [NSURL URLWithString:urlString];
}

// THIS CALLS THE DELEGATE AND PASSES A DICTIONARY OF THE JSON DATA
- (void)requestFinished:(ASIHTTPRequest *)request {
    NSData* data = [request responseData];
    CJSONDeserializer* deserializer = [CJSONDeserializer deserializer];
    NSDictionary* dic = [deserializer deserializeAsDictionary:data error:nil];
    if (!dic) {
        NSArray * array = [deserializer deserializeAsArray:data error:nil];
//        NSMutableArray * store = [[[NSMutableArray alloc] init] autorelease];
//        for (int i=0; i<[array count]; i++) {
//            NSDictionary * d = [deserializer deserializeAsDictionary:[array objectAtIndex:i] error:nil];
//            [store addObject:d];
//        }
//        NSArray * returnArray = [[[NSArray alloc] initWithArray:store] autorelease];
//        [_delegate fetcherFinished:self withResult:returnArray];
        [_delegate fetcherFinished:self withResult:array];
    } else
       [_delegate fetcherFinished:self withResult:dic];

}
- (void)requestFailed:(ASIHTTPRequest *)request {
    return;
}

@end