//
//  PersonalDataViewController.m
//  YQB
//
//  Created by jian on 15/5/28.
//  Copyright (c) 2015年 jian. All rights reserved.
//

#import "PersonalDataViewController.h"
#import "ChangePhoneViewController.h"
#import "ChangeEmailViewController.h"

@interface PersonalDataViewController ()

@end

@implementation PersonalDataViewController

@synthesize realName_TF,personalNumber_TF,phone_TF,email_TF,changeEmail_Btn,changePhone_Btn;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人资料";
    
    //加载控件
    [self initControl];
    
    //请求数据
    [self initData];
    // Do any additional setup after loading the view from its nib.
}

-(void)initControl
{
    
}

-(void)initData
{
    
    Frequest *req = [[Frequest alloc]init];
    req.delegate = self;
    //    req.apiName = @"Login";
    req.connectEnd = @selector(userinfoConEnd:);
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    
    [MBProgressHUD showHUDAddedTo:self.view text:@"加载中..."];
    [req callAPI:GETBASEUSERINFOURL WithParams:postDic WithFileArray:nil View:self.view author:YES];
}

-(void)userinfoConEnd:(id)aInfo
{
    [MBProgressHUD hideHUDForView:self.view animated:NO];
    
    if (realName_TF.text.length != 0)
    {
        realName_TF.userInteractionEnabled = NO;
    }
    if (personalNumber_TF.text.length != 0)
    {
        personalNumber_TF.userInteractionEnabled = NO;
    }
    if (phone_TF.text.length != 0)
    {
        phone_TF.userInteractionEnabled = NO;
        changePhone_Btn.hidden = NO;
    }
    if (email_TF.text.length != 0)
    {
        email_TF.userInteractionEnabled = NO;
        changeEmail_Btn.hidden = NO;
    }
}

-(void)addPicture:(UIGestureRecognizer *)gestureRecognizer
{
    [realName_TF resignFirstResponder];
    [personalNumber_TF resignFirstResponder];
    [phone_TF resignFirstResponder];
    [email_TF resignFirstResponder];
    
    [super useImagePickerController];
}

-(void)gotoChangeData:(UIButton *)sender
{
    [realName_TF resignFirstResponder];
    [personalNumber_TF resignFirstResponder];
    [phone_TF resignFirstResponder];
    [email_TF resignFirstResponder];
    
    Frequest *req = [[Frequest alloc]init];
    req.delegate = self;
    //    req.apiName = @"Login";
    //    req.connectEnd = @selector(movieConEnd:);
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];

    [MBProgressHUD showHUDAddedTo:self.view text:@"提交中..."];
}

-(void)connectEnd:(id)aInfo
{
    [MBProgressHUD hideHUDForView:self.view animated:NO];
//    [self.view makeToast:@"退出成功" duration:1.5 position:@"center"];
//    [self performSelector:@selector(gotoLogin) withObject:nil afterDelay:1.5];
}

-(IBAction)gotoChangePhone:(id)sender
{
    ChangePhoneViewController *changePhone = [[ChangePhoneViewController alloc]initWithNibName:@"ChangePhoneViewController" bundle:nil];
    [self.navigationController pushViewController:changePhone animated:YES];
}

-(IBAction)gotoChangeEmail:(id)sender
{
    ChangeEmailViewController *changeEmail = [[ChangeEmailViewController alloc]initWithNibName:@"ChangeEmailViewController" bundle:nil];
    [self.navigationController pushViewController:changeEmail animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
