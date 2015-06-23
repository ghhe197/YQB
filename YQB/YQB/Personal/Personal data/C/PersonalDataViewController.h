//
//  PersonalDataViewController.h
//  YQB
//
//  Created by jian on 15/5/28.
//  Copyright (c) 2015年 jian. All rights reserved.
//

#import "BaseViewController.h"

@interface PersonalDataViewController : BaseViewController


@property (nonatomic,retain) IBOutlet UITextField *realName_TF;

@property (nonatomic,retain) IBOutlet UITextField *personalNumber_TF;

@property (nonatomic,retain) IBOutlet UITextField *phone_TF;

@property (nonatomic,retain) IBOutlet UITextField *email_TF;

@property (nonatomic,retain) IBOutlet UIButton *changePhone_Btn;

@property (nonatomic,retain) IBOutlet UIButton *changeEmail_Btn;

@end
