//
//  CDBookMappingViewController.m
//  eBook
//
//  Created by Dan Lynch on 4/29/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import "CDBookMappingViewController.h"
#import "eBookAppDelegate.h"
#import "PageLoaderViewController.h"
#import "CDHelper.h"
#import "CDTableCell.h"
#import "TableCell.h"
#import "PageModel.h"
#import "BookModel.h"

@implementation CDBookMappingViewController

@synthesize books, tableOfBooks, pages, tableOfPages, iPages, tableOfIPages;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        pages = [[NSMutableArray alloc] init];
        iPages = [[NSMutableArray alloc] init];
        books = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [pages release];
    [iPages release];
    [books release];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableOfPages == tableView) {
      return [pages count];
    } else if (tableOfBooks == tableView) {
        
        return [books count];
    }
    return [iPages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier = @"Cell";

    
    if (tableOfPages == tableView) {
    
        TableCell *cell = (TableCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[TableCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
        }
        
        [[cell mEditButton] addTarget:self action:@selector(hitPageView:) forControlEvents:UIControlEventTouchUpInside];
        [[cell mEditButton] setTag:indexPath.row];
        

      
        PageModel * page = (PageModel*)[pages objectAtIndex:indexPath.row];
        cell.primaryLabel.text = page.name;
        cell.secondaryLabel.text = page.desc;
        cell.myImageView.image = [UIImage imageNamed:@"icon.png"];
        return cell;
            
    } else if (tableOfBooks== tableView) {

        CDTableCell *cell = (CDTableCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[CDTableCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
        }
        
        [[cell mEditButton] addTarget:self action:@selector(hitBookView:) forControlEvents:UIControlEventTouchUpInside];
        [[cell mEditButton] setTag:indexPath.row];

        cell.primaryLabel.text = @"";
        cell.secondaryLabel.text = @"";
        cell.myImageView.image = [UIImage imageNamed:@"96-book.png"];
        return cell;
        
        
    } else if (tableOfIPages == tableView) {
    
        CDTableCell *cell = (CDTableCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[CDTableCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
        }
        
        [[cell mEditButton] addTarget:self action:@selector(hitNetView:) forControlEvents:UIControlEventTouchUpInside];
        [[cell mEditButton] setTag:indexPath.row];
        
        
        
        cell.primaryLabel.text = @"internetbooks";
        cell.secondaryLabel.text = @"page desc";
        cell.myImageView.image = [UIImage imageNamed:@"icon.png"];
        return cell;
    }
    
	return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 50;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (tableOfPages == tableView) {
    
        PageModel * page = (PageModel*)[pages objectAtIndex:indexPath.row];
        PageLoaderViewController * vc = [[PageLoaderViewController alloc] initWithPage:page NibName:nil bundle:nil];
        
        eBookAppDelegate * delegate = (eBookAppDelegate*) [[UIApplication sharedApplication] delegate];
        UINavigationController * nav = [delegate navigationController];
        [nav pushViewController:vc animated:YES];
        [vc release];
        
    } else if (tableOfBooks == tableView) {
        
        BookModel * book = (BookModel*)[books objectAtIndex:indexPath.row];
 
        [pages removeAllObjects];
        [pages addObjectsFromArray:book.pages];
        [tableOfPages reloadData];
        
    }
}

#pragma mark - Callbacks and IBActions

- (void) hitPageView: (id) sender {
    
}

- (void) hitBookView: (id) sender {
    
}

- (void) hitNetView: (id) sender {
        
}

- (IBAction) reload {
    
    [self reloadPages];

    [tableOfPages reloadData];
    [tableOfBooks reloadData];
    [tableOfIPages reloadData];
}

- (void) reloadPages {
        
    [pages release];    
    pages = [[NSMutableArray alloc] initWithArray:[[CDHelper sharedHelper] allPages]];
    
    [books release];
    books = [[NSMutableArray alloc] initWithArray:[[CDHelper sharedHelper] allBooks]];
    
//    [iPages release];
    
    
    
}

@end
