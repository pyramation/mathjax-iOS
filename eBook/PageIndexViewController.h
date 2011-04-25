//
//  PageIndexViewController.h
//  eBook
//
//  Created by Dan Lynch on 4/25/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataFetcherDelegate.h"

@interface PageIndexViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, DataFetcherDelegate> {
    
    NSMutableArray * pages;
    IBOutlet UITableView *tableOfPages;
    
}

- (void) pushPageView: (id) sender;
- (void) reloadPages;

@property (nonatomic, retain) IBOutlet NSMutableArray *pages;
@property (nonatomic, retain) IBOutlet UITableView *tableOfPages;

@end
