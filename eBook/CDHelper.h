//
//  CDHelper.h
//  eBook
//
//  Created by Dan Lynch on 4/26/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PageModel;
@class BookModel;
@class CDBook;
@interface CDHelper : NSObject {}

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
+(id) sharedHelper;

- (void) savePage: (PageModel*) page;
- (NSArray*) allPages;
- (void) clearPages;


- (void) saveBook: (BookModel*) book;
- (void) deleteBook: (CDBook*) book;
- (NSArray*) allCDBooks;
- (NSArray*) allBooks;
- (void) clearBooks;


@end
