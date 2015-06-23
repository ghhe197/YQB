//
//  ForgetPSWViewController.h
//  YQB
//
//  Created by jian on 15/6/4.
//  Copyright (c) 2015年 jian. All rights reserved.
//

#import "BaseViewController.h"
#import "JKCountDownButton.h"

@interface ForgetPSWViewController : BaseViewController

@property (nonatomic,retain) NSString *base_code;

@property (nonatomic,weak) IBOutlet UITextField *phone_tf;

@property (nonatomic,weak) IBOutlet UITextField *code_tf;

@property (nonatomic,weak) IBOutlet UITextField *password_tf;

@property (nonatomic,weak) IBOutlet UITextField *agpassword_tf;

@property (weak, nonatomic) IBOutlet JKCountDownButton *getCode_btn;

- (IBAction)gotoGetCode:(JKCountDownButton*)sender;

@property (nonatomic,weak) IBOutlet UIButton *agree_btn;

@end
