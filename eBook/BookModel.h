//
//  BookModel.h
//  eBook
//
//  Created by Dan Lynch on 4/29/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BookModel : NSObject {

    NSMutableArray * pages;
    NSString * title;
    NSString * desc;
    
}

@property (nonatomic, retain) NSMutableArray * pages;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * desc;

@end
