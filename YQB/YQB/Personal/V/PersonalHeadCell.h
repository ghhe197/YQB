//
//  PersonalHeadCell.h
//  YQB
//
//  Created by jian on 15/5/26.
//  Copyright (c) 2015年 jian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+AFNetworking.h"

@interface PersonalHeadCell : UITableViewCell

@property (nonatomic,retain) IBOutlet UIImageView *headImgView;

@property (nonatomic,retain) IBOutlet UILabel *name_Label;

@property (nonatomic,retain) IBOutlet UILabel *account_Label;

@end
