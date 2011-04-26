//
//  PageLoaderViewController.h
//  eBook
//
//  Created by Dan Lynch on 4/25/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PageModel;
@interface PageLoaderViewController : UIViewController {
    PageModel * page;
}

- (id)initWithPage:(PageModel*)p NibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;

@property (nonatomic, retain) PageModel*page;

@end
