//
//  BaseViewController.h
//  YQB
//
//  Created by jian on 15/5/11.
//  Copyright (c) 2015年 jian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "Config.h"
#import "JSONKit.h"
#import "MBProgressHUD.h"
#import "Toast+UIView.h"
#import "MF_Base64Additions.h"
#import "Frequest.h"
#import "LoginData.h"

@interface BaseViewController : UIViewController<UITextFieldDelegate, UITextViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource>

-(void)useImagePickerController;

-(void)setStatusBarStyle;

-(void)goBack:(UIButton *)sender;

-(void)gotoLogin;

@end
