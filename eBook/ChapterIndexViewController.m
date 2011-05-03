//
//  ChapterIndexViewController.m
//  eBook
//
//  Created by Dan Lynch on 4/25/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import "ChapterIndexViewController.h"
#import "PageLoaderViewController.h"
#import "TableCell.h"
#import "DataFetcher.h"
#import "eBookAppDelegate.h"
#import "CDHelper.h"
#import "CDPage.h"
#import "BookModel.h"
#import "PageModel.h"


@implementation ChapterIndexViewController

@synthesize tableOfChapters, books;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        books = [[NSMutableArray alloc] init];
    }
    return self;
}


- (void)dealloc
{
    [books release];
    [tableOfChapters release];
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
   [self reloadChapters];
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

- (void) reloadChapters {
    DataFetcher * fetcher = [[DataFetcher alloc] initWithBase:@"http://www.mathapedia.com/chapters.json" andQueries:nil andDelegate:self];    

    [fetcher fetch];

    //DataFetcher * fetcher2 = [[DataFetcher alloc] initWithBase:@"http://www.mathapedia.com/sections/21.json" andQueries:nil andDelegate:self];
    //[fetcher2 fetch];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [books count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier = @"Cell";
	
	TableCell *cell = (TableCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[TableCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
	}
	
    [[cell mEditButton] addTarget:self action:@selector(downloadPage:) forControlEvents:UIControlEventTouchUpInside];
    [[cell mEditButton] setTag:indexPath.row];
    
    BookModel * book = (BookModel*)[books objectAtIndex:indexPath.row];
    
    cell.primaryLabel.text = book.title;
    cell.secondaryLabel.text = book.desc;
    cell.myImageView.image = [UIImage imageNamed:@"icon.png"];
	
	return cell;
	
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 50;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

//    BookModel * book = (BookModel*)[books objectAtIndex:indexPath.row];
//    PageLoaderViewController * vc = [[PageLoaderViewController alloc] initWithPage:book NibName:nil bundle:nil];
//    
//    eBookAppDelegate * delegate = (eBookAppDelegate*) [[UIApplication sharedApplication] delegate];
//    UINavigationController * nav = [delegate navigationController];
//    [nav pushViewController:vc animated:YES];
//    [vc release];
    
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return @"Select a Chapter";
}

#pragma mark - IBActions

- (IBAction) reload {

    [self reloadChapters];
    
}

#pragma mark - Callbacks

- (void) downloadPage: (id) sender {
    BookModel * book = (BookModel*)[books objectAtIndex:((UIButton*)sender).tag];    
    [[CDHelper sharedHelper] saveBook:book];
}

#pragma mark - DataFetcher 

- (void) dataFetcher: (DataFetcher*) fetcher hasResponse: (id) response {
    
    //NSLog(@" type: %@", [[response class] description]);
        
    [books removeAllObjects];
    
    NSArray * chapter_array = (NSArray*) response;

    for (int j=0; j<[chapter_array count]; j++) {
 

        NSDictionary * dic0 = [chapter_array objectAtIndex:j];
        NSDictionary * chapter = [dic0 valueForKey:@"chapter"];
        BookModel * book = [[[BookModel alloc] init] autorelease];
        book.title = [chapter valueForKey:@"name"];
        book.desc = [chapter valueForKey:@"desc"];
         
        PageModel * page0 = [[[PageModel alloc] init] autorelease];
        page0.name = book.title;
        page0.desc = book.desc;
        page0.content = [[[NSString alloc] initWithFormat:@"<br><br><br><br><br><div style=\"text-align: center;font-family: Helvetica, Arial;\"><h2>%@</h2><h3>%@</h3></div>", page0.name, page0.desc] autorelease];
        [book.pages addObject:page0];        

        
        NSArray * array = (NSArray*) [chapter valueForKey:@"sections"];

        for (int i=0; i<[array count]; i++) {
            NSDictionary * section = [array objectAtIndex:i];
            
            PageModel * page = [[[PageModel alloc] init] autorelease];
            page.name = [section valueForKey:@"name"];
            page.desc = [section valueForKey:@"description"];
            page.content = [section valueForKey:@"content"];
            [book.pages addObject:page];        
        }
        
      [books addObject:book];
        
    }
    
    [fetcher release];
    [tableOfChapters reloadData];

    
}


@end
