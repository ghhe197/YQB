//
//  ChangePSWViewController.m
//  YQB
//
//  Created by jian on 15/5/28.
//  Copyright (c) 2015年 jian. All rights reserved.
//

#import "ChangePSWViewController.h"

@interface ChangePSWViewController ()

@end

@implementation ChangePSWViewController

@synthesize oldPSW_TF,theNewPSW_TF,reNewPSW_TF,label1111;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"修改密码";
    
    label1111.text = @"lsjfkdsldsjfj";
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)gotoChangePSW:(id)sender
{
    [oldPSW_TF resignFirstResponder];
    [theNewPSW_TF resignFirstResponder];
    [reNewPSW_TF resignFirstResponder];
    
    if (oldPSW_TF.text.length == 0)
    {
        [self.view makeToast:@"请输入旧密码" duration:1.5 position:@"center"];
        return;
    }
    if (theNewPSW_TF.text.length == 0)
    {
        [self.view makeToast:@"请输入新密码" duration:1.5 position:@"center"];
        return;
    }
    if (reNewPSW_TF.text.length == 0)
    {
        [self.view makeToast:@"请确认新密码" duration:1.5 position:@"center"];
        return;
    }
    if (![theNewPSW_TF.text isEqualToString:reNewPSW_TF.text])
    {
        [self.view makeToast:@"两次新密码不相同" duration:1.5 position:@"center"];
        return;
    }
    
    [self changePSW];
}

-(void)changePSW
{
    Frequest *req = [[Frequest alloc]init];
    req.delegate = self;
    //    req.apiName = @"Login";
    //    req.connectEnd = @selector(movieConEnd:);
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    [postDic setObject:[oldPSW_TF.text base64String] forKey:@"old_password"];
    [postDic setObject:[theNewPSW_TF.text base64String] forKey:@"new_password"];
    [postDic setObject:[reNewPSW_TF.text base64String] forKey:@"confirm_password"];
    [postDic setObject:@"login_password" forKey:@"password_type"];
    
    [MBProgressHUD showHUDAddedTo:self.view text:@"修改中..."];
    [req callAPI:CHANGEPASSWORDURL WithParams:postDic WithFileArray:nil View:self.view author:YES];
}

-(void)connectEnd:(id)aInfo
{
    [MBProgressHUD hideHUDForView:self.view animated:NO];
    [self.view makeToast:@"修改成功" duration:1.5 position:@"center"];
    
    [self performSelector:@selector(goBack:) withObject:nil afterDelay:1.5];
    
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
