
//
//  PageIndexViewController.m
//  eBook
//
//  Created by Dan Lynch on 4/25/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import "PageIndexViewController.h"
#import "TableCell.h"
#import "DataFetcher.h"

@implementation PageIndexViewController

@synthesize tableOfPages, pages;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)dealloc
{
    [pages release];
    [tableOfPages release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

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

# pragma mark - TableView methods

- (void) reloadPages {
    DataFetcher * fetcher = [[DataFetcher alloc] initWithBase:@"http://da.nlynch.com/categories/26.json" andQueries:nil andDelegate:self];
    [fetcher fetch];
}

- (void)viewWillAppear:(BOOL)animated {
    [self reloadPages];
    [tableOfPages reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [pages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier = @"Cell";
	
	TableCell *cell = (TableCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[TableCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
	}
	
    [[cell mEditButton] addTarget:self action:@selector(pushEditView:) forControlEvents:UIControlEventTouchUpInside];
    [[cell mEditButton] setTag:indexPath.row];
    
//    CDRoute * cdRoute = (CDRoute*)[routes objectAtIndex:indexPath.row];
    
    cell.primaryLabel.text = @"title";
    cell.secondaryLabel.text = @"description";
    cell.myImageView.image = [UIImage imageNamed:@"icon.png"];
	
	return cell;
	
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 50;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    CDRoute * cdRoute = (CDRoute*)[routes objectAtIndex:indexPath.row];
//    ScenicRoute * route = (ScenicRoute*) cdRoute.route;
//    PageLoaderViewController* tripVC = [[PageLoaderViewController alloc] initWithNibName:@"ScenicTripViewController" bundle:nil route:route];
//    
//    [[self navigationController] pushViewController:tripVC animated:YES];
//    [tripVC release];
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return @"Select a Route";
}

#pragma mark - DataFetcher 

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
