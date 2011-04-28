//
//  equationEditorViewController.h
//  eBook
//
//  Created by Dan Lynch on 4/20/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface equationEditorViewController : UIViewController <UIWebViewDelegate> {
    
    UIWebView * webview;
    UITextField * equation;
    
}

- (IBAction) equationEdited;

@property (nonatomic, retain) IBOutlet UIWebView * webview;
@property (nonatomic, retain) IBOutlet UITextField * equation;

@end
