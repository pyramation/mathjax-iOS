
//
//  PageIndexViewController.m
//  eBook
//
//  Created by Dan Lynch on 4/25/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import "PageIndexViewController.h"
#import "PageLoaderViewController.h"
#import "TableCell.h"
#import "DataFetcher.h"
#import "Page.h"

@implementation PageIndexViewController

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
   [self reloadPages];
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
    DataFetcher * fetcher = [[DataFetcher alloc] initWithBase:@"http://www.mathapedia.com/sections.json" andQueries:nil andDelegate:self];    

    [fetcher fetch];

    //DataFetcher * fetcher2 = [[DataFetcher alloc] initWithBase:@"http://www.mathapedia.com/sections/21.json" andQueries:nil andDelegate:self];
    //[fetcher2 fetch];
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
	
    [[cell mEditButton] addTarget:self action:@selector(pushPageView:) forControlEvents:UIControlEventTouchUpInside];
    [[cell mEditButton] setTag:indexPath.row];
    
    Page * page = (Page*)[pages objectAtIndex:indexPath.row];
    
    cell.primaryLabel.text = page.name;
    cell.secondaryLabel.text = page.desc;
    cell.myImageView.image = [UIImage imageNamed:@"icon.png"];
	
	return cell;
	
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 50;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    Page * page = (Page*)[pages objectAtIndex:indexPath.row];
    PageLoaderViewController * vc = [[PageLoaderViewController alloc] initWithPage:page NibName:nil bundle:nil]; 
    [[self navigationController] pushViewController:vc animated:YES];
    [vc release];
    
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return @"Select a Page";
}

#pragma mark - Callbacks

- (void) pushPageView: (id) sender {
    Page * page = (Page*)[pages objectAtIndex:((UIButton*)sender).tag];
    PageLoaderViewController * vc = [[PageLoaderViewController alloc] initWithPage:page NibName:nil bundle:nil]; 
    [[self navigationController] pushViewController:vc animated:YES];
    [vc release];
}


#pragma mark - DataFetcher 

- (void) dataFetcher: (DataFetcher*) fetcher hasResponse: (id) response {
    
    //NSLog(@" type: %@", [[response class] description]);
    
    NSArray * array = (NSArray*) response;
    
    for (int i=0; i<[array count]; i++) {
        //NSLog(@" type: %@", [[[array objectAtIndex:i] class] description]);
        
        NSDictionary * dic = [array objectAtIndex:i];
        NSDictionary * section = [dic valueForKey:@"section"];
        NSLog(@"name %@", [section valueForKey:@"name"]);
        Page * page = [[[Page alloc] init] autorelease];
        page.name = [section valueForKey:@"name"];
        page.desc = [section valueForKey:@"created_at"];
        page.content = [section valueForKey:@"content"];
        [pages addObject:page];
  
    }
    
    [fetcher release];
    
    [tableOfPages reloadData];

    NSLog(@"pages: %d", [pages count]);
}


@end
