//
//  ChangePhoneViewController.h
//  YQB
//
//  Created by jian on 15/5/29.
//  Copyright (c) 2015年 jian. All rights reserved.
//

#import "BaseViewController.h"
#import "JKCountDownButton.h"

@interface ChangePhoneViewController : BaseViewController

@property (nonatomic,retain) IBOutlet UITextField *oldPSW_TF;

@property (nonatomic,retain) IBOutlet UITextField *oldPhone_TF;

@property (nonatomic,retain) IBOutlet UITextField *theNewPhone_TF;

@property (nonatomic,retain) IBOutlet UITextField *code_TF;

@property (weak, nonatomic) IBOutlet JKCountDownButton *getCode_btn;

-(IBAction)gotoGetCode:(JKCountDownButton*)sender;

@end
