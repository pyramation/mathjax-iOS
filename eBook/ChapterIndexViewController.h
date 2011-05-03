//
//  ChapterIndexViewController.h
//  eBook
//
//  Created by Dan Lynch on 4/25/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataFetcherDelegate.h"

@interface ChapterIndexViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIWebViewDelegate, DataFetcherDelegate> {
    
    NSMutableArray * books;
    IBOutlet UITableView *tableOfChapters;
    
}

- (void) downloadPage: (id) sender;
- (void) reloadChapters;
- (IBAction) reload;

@property (nonatomic, retain) IBOutlet NSMutableArray *books;
@property (nonatomic, retain) IBOutlet UITableView *tableOfChapters;

@end
