//
//  CDBookMappingViewController.h
//  eBook
//
//  Created by Dan Lynch on 4/29/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CDBookMappingViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate> {
    
    NSMutableArray * books;
    IBOutlet UITableView *tableOfBooks;

    NSMutableArray * iPages;
    IBOutlet UITableView *tableOfIPages;

    
    NSMutableArray * pages;
    IBOutlet UITableView *tableOfPages; 
    
    IBOutlet UITextField * mTitle;
    IBOutlet UITextField * mDesc;
    
    
}

- (IBAction) reload;

- (IBAction) updateBook;
- (IBAction) deleteBook;
- (IBAction) deleteBooks;


- (void) reloadPages;
- (void) reloadAll;


- (void) hitPageView: (id) sender;
- (void) hitBookView: (id) sender;
- (void) hitNetView: (id) sender;

@property (nonatomic, retain) IBOutlet NSMutableArray *iPages;
@property (nonatomic, retain) IBOutlet UITableView *tableOfIPages;


@property (nonatomic, retain) IBOutlet NSMutableArray *books;
@property (nonatomic, retain) IBOutlet UITableView *tableOfBooks;

@property (nonatomic, retain) IBOutlet NSMutableArray *pages;
@property (nonatomic, retain) IBOutlet UITableView *tableOfPages;

@property (nonatomic, retain) IBOutlet UITextField * mTitle;
@property (nonatomic, retain) IBOutlet UITextField * mDesc;


@end
