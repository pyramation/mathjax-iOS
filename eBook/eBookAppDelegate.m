//
//  eBookAppDelegate.m
//  eBook
//
//  Created by Dan Lynch on 4/7/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import "eBookAppDelegate.h"


#import "PolesZerosViewController.h"
#import "FilterDesignViewController.h"
#import "GraphViewController.h"
#import "DiracDeltasViewController.h"
#import "SplitViewController.h"
#import "UnitCircleViewController.h"
#import "equationEditorViewController.h"
#import "ConvolveDeltasViewController.h"
#import "PageIndexViewController.h"
#import "CDPageIndexViewController.h"
#import "CDBookMappingViewController.h"
#import "BookshelfViewController.h"


@implementation eBookAppDelegate

@synthesize window=_window;
@synthesize navigationController;

#define addMe(view, nav, title, icon, class) class * view = [[class alloc] init]; \
UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:view]; \
nav.navigationBar.barStyle = UIBarStyleBlackTranslucent; \
[view.tabBarItem initWithTitle:title image:[UIImage imageNamed:icon] tag:0];\
[controllers addObject:nav]; \
[nav release]; \
[view release]


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    

    /* set-up tabs */
    NSMutableArray * controllers = [[NSMutableArray alloc] init];
    addMe(bViewC, bNav, @"Bookshelf", @"96-book.png", BookshelfViewController);
//    addMe(webViewC, webNav, @"Web View", @"96-book.png", UIViewController);
    addMe(aViewc, aNav, @"Network Library", @"96-book.png", PageIndexViewController);
    addMe(cdViewc, cdNav, @"Library", @"96-book.png", CDPageIndexViewController);
    addMe(bdViewc, bdNav, @"Book Library", @"96-book.png", CDBookMappingViewController);
    
//    addMe(unitViewC, unitNav, @"Unit Circle", @"11-clock.png", UnitCircleViewController);
//    addMe(poleViewC, poleNav, @"Poles and Zeros", @"73-radar.png", PolesZerosViewController);
//    addMe(plotViewC, plotNav, @"Graphs", @"77-ekg.png", GraphViewController);
//    addMe(dViewC, dNav, @"Convolve Deltas", @"55-network.png", ConvolveDeltasViewController);
//    addMe(blockViewC, blockNav, @"Dirac Deltas", @"55-network.png", DiracDeltasViewController);
//    addMe(splitViewC, splitNav, @"Split View", @"95-equalizer.png", SplitViewController);
//    addMe(filterViewC, filterNav, @"Filter Design", @"122-stats.png", FilterDesignViewController);
    addMe(eqViewC, eqNav, @"Equation Editor", @"06-magnify.png", equationEditorViewController);    
    
//    UIWebView *htmlView = [[UIWebView alloc] init];
//    [htmlView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"sample-tex" ofType:@"html" inDirectory:@"MathJax/test"]isDirectory:NO]]];
//    [htmlView setScalesPageToFit:YES];
//    webViewC.view = htmlView;
//    htmlView.delegate = self;
//    [htmlView release];
    
    
    UITabBarController * tbarController = [[UITabBarController alloc] init];
    tbarController.viewControllers = controllers;
    tbarController.customizableViewControllers = controllers;
    tbarController.delegate = self;
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:tbarController];
    [tbarController release];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    _window.rootViewController = self.navigationController;
    
    // ASITEST
    //    DataFetcher * fetcher = [[DataFetcher alloc] initWithBase:@"http://da.nlynch.com/categories/26.json" andQueries:nil andDelegate:self];
    //  [fetcher fetch];

    
    
    // Override point for customization after application launch.
    [_window makeKeyAndVisible];
    return YES;
}


- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
    //CAPTURE USER LINK-CLICK.
    
    NSLog(@"%@ %d", request, navigationType);
    
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        NSURL *URL = [request URL]; 
        if ([[URL scheme] isEqualToString:@"FilterDesign"]) {
            FilterDesignViewController * temp = [[FilterDesignViewController alloc] init];
            [self.navigationController pushViewController:temp animated:TRUE];
            [temp release];
        } else if ([[URL scheme] isEqualToString:@"DiracDeltas"]) {
            FilterDesignViewController * temp = [[DiracDeltasViewController alloc] init];
            [self.navigationController pushViewController:temp animated:TRUE];
            [temp release];
            
        } else if ([[URL scheme] isEqualToString:@"UnitCircle"]) {
            FilterDesignViewController * temp = [[UnitCircleViewController alloc] init];
            [self.navigationController pushViewController:temp animated:TRUE];
            [temp release];
            
        } else if ([[URL scheme] isEqualToString:@"PolesZeros"]) {
            FilterDesignViewController * temp = [[PolesZerosViewController alloc] init];
            [self.navigationController pushViewController:temp animated:TRUE];
            [temp release];
            
        } else if ([[URL scheme] isEqualToString:@"Graph"]) {
            FilterDesignViewController * temp = [[GraphViewController alloc] init];
            [self.navigationController pushViewController:temp animated:TRUE];
            [temp release];
            
        } else if ([[URL scheme] isEqualToString:@"http"]) {
            
            [webView loadRequest:request];
            
        } else {
            NSLog(@"other");
            
        }
        return NO;
    }   
    return YES;   
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
}

- (void)awakeFromNib
{
    /*
     Typically you should set up the Core Data stack here, usually by passing the managed object context to the first view controller.
     self.managedObjectContext = self.managedObjectContext;
    */
}

#pragma mark - Memory

- (void)dealloc
{
    [_window release];
    [navigationController release];
    [super dealloc];
}


@end
