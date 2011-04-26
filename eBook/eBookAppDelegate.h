//
//  eBookAppDelegate.h
//  eBook
//
//  Created by Dan Lynch on 4/7/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface eBookAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate, UIWebViewDelegate> {
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) UINavigationController *navigationController;

@end
