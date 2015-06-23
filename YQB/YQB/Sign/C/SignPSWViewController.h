//
//  SignPSWViewController.h
//  YQB
//
//  Created by jian on 15/5/21.
//  Copyright (c) 2015年 jian. All rights reserved.
//

#import "BaseViewController.h"
#import "JKCountDownButton.h"

@interface SignPSWViewController : BaseViewController

@property (nonatomic,retain) IBOutlet UITextField *phone;

@property (nonatomic,retain) IBOutlet UITextField *code;

@property (weak, nonatomic) IBOutlet JKCountDownButton *getCode_btn;

- (IBAction)gotoGetCode:(JKCountDownButton*)sender;

@end
