//
//  SplitViewController.h
//  eBook
//
//  Created by Dan Lynch on 4/16/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConvolveDeltasView.h"


@interface SplitViewController : UIViewController {
 
    ConvolveDeltasView * view1;
    ConvolveDeltasView * view2;
    ConvolveDeltasView * returnView;
    
}

- (void) convolve: (id) sender;

@property (nonatomic, retain) ConvolveDeltasView * view1;
@property (nonatomic, retain) ConvolveDeltasView * view2;
@property (nonatomic, retain) ConvolveDeltasView * returnView;

@end
