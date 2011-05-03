//
//  CDBook.h
//  eBook
//
//  Created by Dan Lynch on 4/30/11.
//  Copyright (c) 2011 Pyramation Media. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CDBook : NSManagedObject {
@private
}


@property (nonatomic, retain) id pages;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * desc;

@end
