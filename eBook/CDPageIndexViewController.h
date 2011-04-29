//
//  CDPageIndexViewController.h
//  eBook
//
//  Created by Dan Lynch on 4/26/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataFetcherDelegate.h"

@interface CDPageIndexViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIWebViewDelegate> {
    
    NSMutableArray * pages;
    IBOutlet UITableView *tableOfPages;
    
}

- (void) pushPageView: (id) sender;
- (void) reloadPages;

- (IBAction) saveAsBook;
- (IBAction) clearPages;


@property (nonatomic, retain) IBOutlet NSMutableArray *pages;
@property (nonatomic, retain) IBOutlet UITableView *tableOfPages;

@end
