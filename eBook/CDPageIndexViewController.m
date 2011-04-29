//
//  CDPageIndexViewController.m
//  eBook
//
//  Created by Dan Lynch on 4/26/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import "CDPageIndexViewController.h"
#import "PageIndexViewController.h"
#import "PageLoaderViewController.h"
#import "CDTableCell.h"
#import "DataFetcher.h"
#import "PageModel.h"
#import "eBookAppDelegate.h"
#import "CDHelper.h"
#import "CDPage.h"
#import "BookModel.h"

@implementation CDPageIndexViewController

@synthesize tableOfPages, pages;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        pages = [[NSMutableArray alloc] init];
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

- (void)viewWillAppear:(BOOL)animated {
    [self reloadPages];
    [tableOfPages reloadData];
}

# pragma mark - TableView methods

- (void) reloadPages {
    [pages release];    
    pages = [[NSMutableArray alloc] initWithArray:[[CDHelper sharedHelper] allPages]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [pages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier = @"Cell";
	
	CDTableCell *cell = (CDTableCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[CDTableCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
	}
	
    [[cell mEditButton] addTarget:self action:@selector(pushPageView:) forControlEvents:UIControlEventTouchUpInside];
    [[cell mEditButton] setTag:indexPath.row];
    
    PageModel * page = (PageModel*)[pages objectAtIndex:indexPath.row];
    
    cell.primaryLabel.text = page.name;
    cell.secondaryLabel.text = page.desc;
    cell.myImageView.image = [UIImage imageNamed:@"icon.png"];
	
	return cell;
	
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 50;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PageModel * page = (PageModel*)[pages objectAtIndex:indexPath.row];
    PageLoaderViewController * vc = [[PageLoaderViewController alloc] initWithPage:page NibName:nil bundle:nil];
    
    eBookAppDelegate * delegate = (eBookAppDelegate*) [[UIApplication sharedApplication] delegate];
    UINavigationController * nav = [delegate navigationController];
    [nav pushViewController:vc animated:YES];
    [vc release];
    
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return @"Select a Page";
}

#pragma mark - Callbacks

- (void) pushPageView: (id) sender {
    PageModel * page = (PageModel*)[pages objectAtIndex:((UIButton*)sender).tag];
    PageLoaderViewController * vc = [[PageLoaderViewController alloc] initWithPage:page NibName:nil bundle:nil]; 
    eBookAppDelegate * delegate = (eBookAppDelegate*) [[UIApplication sharedApplication] delegate];
    UINavigationController * nav = [delegate navigationController];
    [nav pushViewController:vc animated:YES];
    [vc release];
}

- (IBAction) saveAsBook {
    
    NSLog(@"save as a book!!");
    BookModel * model = [[BookModel alloc] init];
    model.pages = pages;    
    [[CDHelper sharedHelper] saveBook:model];
 
    [self reloadPages];
    [tableOfPages reloadData];
}

- (IBAction) clearPages {
    
    [[CDHelper sharedHelper] clearPages];

    [self reloadPages];
    [tableOfPages reloadData];
    
}


@end
