//
//  PersonalViewController.h
//  YQB
//
//  Created by jian on 15/5/26.
//  Copyright (c) 2015年 jian. All rights reserved.
//

#import "BaseViewController.h"

@interface PersonalViewController : BaseViewController

@property (nonatomic,retain) IBOutlet UITableView *personalTableView;

@property (nonatomic,retain) NSMutableArray *groupArr;

@end
