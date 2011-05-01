//
//  DelDelTableCell.h
//  eBook
//
//  Created by Dan Lynch on 4/25/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DelTableCell : UITableViewCell {
	UILabel *primaryLabel;
	UILabel *secondaryLabel;
	UIImageView *myImageView;
    UIButton *mEditButton;
}

@property(nonatomic,retain)UILabel *primaryLabel;
@property(nonatomic,retain)UILabel *secondaryLabel;
@property(nonatomic,retain)UIImageView *myImageView;
@property(nonatomic,retain)UIButton *mEditButton;

@end
