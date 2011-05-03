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
#import "DelTableCell.h"
#import "CDBook.h"
#import "TableCell.h"
#import "PageModel.h"
#import "BookModel.h"
#import "BookView.h"

@implementation CDBookMappingViewController

@synthesize books, tableOfBooks, pages, tableOfPages, iPages, tableOfIPages, mTitle, mDesc, mSearch;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        pages = [[NSMutableArray alloc] init];
        iPages = [[NSMutableArray alloc] init];
        books = [[NSMutableArray alloc] init];
        curBook = nil;
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

- (void) viewWillAppear:(BOOL)animated {
    
    [self reloadAll];    
}

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
    
        DelTableCell *cell = (DelTableCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[DelTableCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
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

        
        CDBook * book = (CDBook*) [books objectAtIndex:indexPath.row];
        cell.primaryLabel.text = book.title;
        cell.secondaryLabel.text = book.desc;
        cell.myImageView.image = [UIImage imageNamed:@"96-book.png"];
        return cell;
        
        
    } else if (tableOfIPages == tableView) {
    
        CDTableCell *cell = (CDTableCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[CDTableCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
        }
        
        [[cell mEditButton] addTarget:self action:@selector(hitNetView:) forControlEvents:UIControlEventTouchUpInside];
        [[cell mEditButton] setTag:indexPath.row];
        
        
        PageModel * page = (PageModel*)[iPages objectAtIndex:indexPath.row];        
        cell.primaryLabel.text = page.name;
        cell.secondaryLabel.text = page.desc;
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
        
        curBook = (CDBook*) [books objectAtIndex:indexPath.row];
        
        [pages removeAllObjects];
        [pages addObjectsFromArray:curBook.pages];
        [tableOfPages reloadData];
        
        self.mDesc.text = curBook.desc;
        self.mTitle.text = curBook.title;
        
    }
}

#pragma mark - Callbacks and IBActions

- (void) hitPageView: (id) sender {
    // delete the page
    
    
}

- (void) hitBookView: (id) sender {

    CDBook * cdbook = (CDBook*)[books objectAtIndex:((UIButton*)sender).tag];

    BookView * v = [[BookView alloc] initWithFrame:[[UIScreen mainScreen] bounds] withPages:cdbook.pages];
    
    eBookAppDelegate * delegate = (eBookAppDelegate*) [[UIApplication sharedApplication] delegate];
    UINavigationController * nav = [delegate navigationController];

    UIViewController * vc = [[UIViewController alloc] init];
    [vc setView:v];
    [v release];
    [nav pushViewController:vc animated:YES];
    [vc release];
    
}

- (void) hitNetView: (id) sender {
  // add page to current book!

//    if (!curBook) return;
    
//    id pgs = [curBook pages];
//    [pgs addObject:(PageModel*)[iPages objectAtIndex:((UIButton*)sender).tag]];    
//    [curBook setPages:[[[NSMutableArray alloc] initWithArray:pgs] autorelease]];
//    [[CDHelper sharedHelper] saveContext];

    [pages addObject:(PageModel*)[iPages objectAtIndex:((UIButton*)sender).tag]];
    [tableOfPages reloadData];
    
}

- (IBAction) reload {
    
    [self reloadAll];
}

- (IBAction) deleteBook {
    if (!curBook) return;
    [[CDHelper sharedHelper] deleteBook:curBook];
    curBook = nil;
    [tableOfBooks reloadData];
    [pages removeAllObjects];
    [tableOfPages reloadData];
}

- (IBAction) deleteBooks {
    [[CDHelper sharedHelper] clearBooks];
}

- (IBAction) clearPages {
    
    [pages removeAllObjects];
    [tableOfPages reloadData];
    
}

- (IBAction) updateBook {
     
    if (!curBook) return;
    curBook.title = self.mTitle.text;
    curBook.desc = self.mDesc.text;
    [[CDHelper sharedHelper] saveContext];
    [tableOfBooks reloadData];
}

- (IBAction) saveBook {
        
    BookModel * model = [[BookModel alloc] init];
    model.pages = pages;
    model.title = self.mTitle.text;
    model.desc = self.mDesc.text;
    [[CDHelper sharedHelper] saveBook:model];
    
    [books removeAllObjects];
    [books addObjectsFromArray:[[CDHelper sharedHelper] allBooks]];
    [tableOfBooks reloadData];
}

- (void) reloadAll {
    [self reloadPages];
    [tableOfPages reloadData];
    [tableOfBooks reloadData];    
}

- (void) reloadPages {
        
    [pages removeAllObjects];    
    [pages addObjectsFromArray:[[CDHelper sharedHelper] allPages]];
    
    [books removeAllObjects];
    [books addObjectsFromArray:[[CDHelper sharedHelper] allBooks]];
    
    
    DataFetcher * fetcher = [[DataFetcher alloc] initWithBase:@"http://www.mathapedia.com/sections.json" andQueries:nil andDelegate:self];    
    
    [fetcher fetch];
    
}

- (IBAction) search {

    NSString * base = [[[NSString alloc] initWithFormat:@"http://www.mathapedia.com/sections.json?&search=%@", self.mSearch.text] autorelease];
    base = [base stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    DataFetcher * fetcher = [[DataFetcher alloc] initWithBase:base andQueries:nil andDelegate:self];    
    
    [fetcher fetch];    
    
}

#pragma mark - UITextViewDelegate

-(BOOL) textFieldShouldReturn:(UITextField*) textField {
    [textField resignFirstResponder]; 
    return YES;
}

#pragma mark - DataFetcher Delegate

- (void) dataFetcher: (DataFetcher*) fetcher hasResponse: (id) response {
    
    //NSLog(@" type: %@", [[response class] description]);
    
    [iPages removeAllObjects];
    NSArray * array = (NSArray*) response;
    
    for (int i=0; i<[array count]; i++) {
        //NSLog(@" type: %@", [[[array objectAtIndex:i] class] description]);
        
        NSDictionary * dic = [array objectAtIndex:i];
        NSDictionary * section = [dic valueForKey:@"section"];
        NSLog(@"name %@", [section valueForKey:@"name"]);
        PageModel * page = [[[PageModel alloc] init] autorelease];
        page.name = [section valueForKey:@"name"];
        page.desc = [section valueForKey:@"description"];
        page.content = [section valueForKey:@"content"];
        [iPages addObject:page];        
    }
    
    [fetcher release];
    [tableOfIPages reloadData];
    
    
}



@end
