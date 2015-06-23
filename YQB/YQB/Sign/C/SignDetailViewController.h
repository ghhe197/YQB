//
//  SignDetailViewController.h
//  YQB
//
//  Created by jian on 15/5/21.
//  Copyright (c) 2015年 jian. All rights reserved.
//

#import "BaseViewController.h"

@interface SignDetailViewController : BaseViewController<UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,UINavigationControllerDelegate>

@property (nonatomic,retain) NSURL *filePath;

@property (nonatomic,retain) NSString *base_code;

@property (nonatomic,weak) IBOutlet UIImageView *headView;

@property (nonatomic,weak) IBOutlet UITextField *name_tf;

@property (nonatomic,weak) IBOutlet UITextField *password_tf;

@property (nonatomic,weak) IBOutlet UITextField *agpassword_tf;

@property (nonatomic,weak) IBOutlet UIButton *agree_btn;

@end
