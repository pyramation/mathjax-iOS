//
//  SplitViewController.m
//  eBook
//
//  Created by Dan Lynch on 4/16/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import "SplitViewController.h"
#import "PolesZerosView.h"
#import "FilterDesign.h"

#import "DiscreteSignal.h"


@implementation SplitViewController
@synthesize view1, view2, returnView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
        // create continaer
        CGRect rect = [[UIScreen mainScreen] bounds];  
        UIView * container = [[UIView alloc] initWithFrame:rect];
        
        // add views
        CGRect rect1 = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height/4.0);
        CGRect rect2 = CGRectMake(rect.origin.x, rect.size.height/4.0, rect.size.width, rect.size.height/4.0);
        CGRect rect3 = CGRectMake(rect.origin.x, 2*rect.size.height/4.0, rect.size.width, rect.size.height/4.0);

        view1 = [[ConvolveDeltasView alloc] initWithFrame:rect1];
        view2 = [[ConvolveDeltasView alloc] initWithFrame:rect2];
        returnView =[[ConvolveDeltasView alloc] initWithFrame:rect3]; 
        [container addSubview:view1];
        [container addSubview:view2];
        [container addSubview:returnView];
        

        // add slider
        CGRect frame = CGRectMake(rect.origin.x, 3*rect.size.height/4.0, rect.size.width, rect.size.height/4.0);
        UISlider *slider = [[UISlider alloc] initWithFrame:frame];
        [slider addTarget:self action:@selector(convolve:) forControlEvents:UIControlEventValueChanged];
        [slider setBackgroundColor:[UIColor blackColor]];
        slider.minimumValue = 1.0;
        slider.maximumValue = 100.0;
        slider.continuous = YES;
        slider.value = 25.0;
            
        [container addSubview:slider];
        [slider release];

        
        // set up container
        [self setView:container];
        [container release];
        
    }
    return self;
}

- (void) convolve: (id) sender {
    
//    UISlider * slider = (UISlider*) sender;
//    float val = slider.value;
//    
//    NSLog(@"val is %f", val);
    
    [returnView clearAll];

    returnView.signal = [view1.signal convolve:view1.signal];
       
}

- (void)dealloc {
    [view1 release];
    [view2 release];
    [returnView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
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
