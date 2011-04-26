//
//  PageModel.h
//  eBook
//
//  Created by Dan Lynch on 4/25/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PageModel : NSObject <NSCoding> {

    NSString * name;
    NSString * desc;
    NSString * content;
    
}

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString * content;

@end
