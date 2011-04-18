//
//  FilterDesignViewController.m
//  eBook
//
//  Created by Dan Lynch on 4/14/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import "FilterDesignViewController.h"
#import "FilterDesign.h"

@implementation FilterDesignViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setView:[[FilterDesign alloc] initWithFrame:[[UIScreen mainScreen] bounds]]];
        
//        UIToolbar* toolbar = [[UIToolbar alloc] init];
        
        UIToolbar* toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height-155, [[UIScreen mainScreen] bounds].size.width, 100)];
        [toolbar sizeToFit];
        toolbar.barStyle = UIBarStyleBlackTranslucent;
        
        
        UIBarButtonItem* buttonItem = [[UIBarButtonItem alloc] initWithTitle:@"Clear" style:UIBarButtonSystemItemAction target:self.view action:@selector(clearAllStrokes)];
        [toolbar setItems:[NSArray arrayWithObjects:buttonItem, nil]];
        [buttonItem release];
        
        [self.view addSubview:toolbar];
        [toolbar release];
        
        
        
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
