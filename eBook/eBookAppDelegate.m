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


#import "DataFetcher.h"



@implementation eBookAppDelegate


@synthesize window=_window;

@synthesize managedObjectContext=__managedObjectContext;

@synthesize managedObjectModel=__managedObjectModel;

@synthesize persistentStoreCoordinator=__persistentStoreCoordinator;

@synthesize navigationController;

#define addMe(view, nav, title, icon, class) class * view = [[class alloc] init]; \
UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:view]; \
nav.navigationBar.barStyle = UIBarStyleBlackTranslucent; \
[view.tabBarItem initWithTitle:title image:[UIImage imageNamed:icon] tag:0];\
[controllers addObject:nav]




- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    

    /* set-up tabs */
    NSMutableArray * controllers = [[NSMutableArray alloc] init];
    addMe(unitViewC, unitNav, @"Unit Circle", @"11-clock.png", UnitCircleViewController);
    addMe(poleViewC, poleNav, @"Poles and Zeros", @"73-radar.png", PolesZerosViewController);
    addMe(plotViewC, plotNav, @"Graphs", @"04-squiggle.png", GraphViewController);
    addMe(blockViewC, blockNav, @"Dirac Deltas", @"55-network.png", DiracDeltasViewController);
    addMe(splitViewC, splitNav, @"Split View", @"95-equalizer.png", SplitViewController);
    addMe(webViewC, webNav, @"Web View", @"96-book.png", UIViewController);
    addMe(filterViewC, filterNav, @"Filter Design", @"77-ekg.png", FilterDesignViewController);
 
//    blockViewC.view = [[GraphView alloc] init];
    
    UIWebView * webView = [[UIWebView alloc] init];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://mathapedia.com"]]];
    webView.backgroundColor = [UIColor whiteColor];
    webView.scalesPageToFit = YES;
    webView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    webView.delegate = self;
    webViewC.view = webView;
    
    
    UITabBarController * tbarController = [[UITabBarController alloc] init];
    tbarController.viewControllers = controllers;
    tbarController.customizableViewControllers = controllers;
    tbarController.delegate = self;
        
    //[_window addSubview:tbarController.view];
    
    
    // ASITEST
//    DataFetcher * fetcher = [[DataFetcher alloc] initWithBase:@"http://da.nlynch.com/categories/26.json" andQueries:nil andDelegate:self];
//    [fetcher fetch];
    
    
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:tbarController];
    navigationController.navigationBar.barStyle = UIBarStyleBlack;

    [_window addSubview:[navigationController view]]; 

    
    
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
    [self saveContext];
}

- (void)dealloc
{
    [_window release];
    [__managedObjectContext release];
    [__managedObjectModel release];
    [__persistentStoreCoordinator release];
    [super dealloc];
}

- (void)awakeFromNib
{
    /*
     Typically you should set up the Core Data stack here, usually by passing the managed object context to the first view controller.
     self.<#View controller#>.managedObjectContext = self.managedObjectContext;
    */
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil)
    {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil)
    {
        return __managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"eBook" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];    
    return __managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil)
    {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"eBook.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return __persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


// DATAFETCHER

-(void) dataFetcher: (DataFetcher*) fetcher hasResponse: (id) response {
    
    NSDictionary * dic = (NSDictionary*) response;
    NSLog(@"dictionary: ? => %@", [dic description]);
    
    if (dic) {
        NSLog(@"success: ? %@", [dic description]);
        NSDictionary * d2 = [dic valueForKey:@"category"];
        NSLog(@" %@", [[d2 valueForKey:@"name"] description]);
    } 
    [fetcher release];
    
}


@end
