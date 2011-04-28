//
//  equationEditorViewController.m
//  eBook
//
//  Created by Dan Lynch on 4/20/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import "equationEditorViewController.h"


@implementation equationEditorViewController
@synthesize webview, equation;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction) equationEdited {
    
    bool useServer = false;
    
    webview.delegate = self;
    
    if (!useServer) {
        NSString * html = @"<!DOCTYPE html><html><head><title>MathJax</title><script type=\"text/javascript\" src=\"../MathJax.js?config=TeX-AMS_HTML-full\"></script><script type=\"text/x-mathjax-config\">MathJax.Hub.Config({tex2jax: {inlineMath: [[\"$\",\"$\"],[\"\\(\",\"\\)\"]]}});</script></head><body>$$\\int_x^y f(x) dx$$<img src=\"../../images/test.png\">";       

        NSString * setHtml = [[NSString alloc] initWithFormat:@"<br><br><br>%@%@</body></html>", html, equation.text];
        NSString * path = [[NSBundle mainBundle] resourcePath]; 
//        path = [path stringByReplacingOccurrencesOfString:@"/" withString:@"//"];
        path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString * resourcesPath = [[NSString alloc] initWithFormat:@"file://%@/MathJax/test/", path];
        NSLog(@"%@", resourcesPath);
        
        [webview loadHTMLString:setHtml baseURL:[NSURL URLWithString:resourcesPath]];
        //[webview loadHTMLString:setHtml baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] resourcePath]]];
        //[webview loadHTMLString:setHtml baseURL:[[NSBundle mainBundle] resourceURL]];
        
    } else {
        NSString * html = @"<!DOCTYPE html><html><head><title>MathJax</title><script type=\"text/javascript\" src=\"mathjax/MathJax.js?config=TeX-AMS_HTML-full\"></script><script type=\"text/x-mathjax-config\">MathJax.Hub.Config({tex2jax: {inlineMath: [[\"$\",\"$\"],[\"\\(\",\"\\)\"]]}});</script></head><body>";
        NSString * setHtml = [[NSString alloc] initWithFormat:@"%@<br><br><br><br>$$%@$$</body></html>", html, equation.text];
        [webview loadHTMLString:setHtml baseURL:[NSURL URLWithString:@"http://www.mathapedia.com"]];
    }

    
}

- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    NSLog(@"error %@", [error description]);
    
}

- (BOOL) textFieldShouldReturn:(UITextField*)textField {
    [textField resignFirstResponder];
    return YES;
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

@end
