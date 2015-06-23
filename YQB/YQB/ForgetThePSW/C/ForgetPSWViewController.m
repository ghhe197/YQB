//
//  ForgetPSWViewController.m
//  YQB
//
//  Created by jian on 15/6/4.
//  Copyright (c) 2015年 jian. All rights reserved.
//

#import "ForgetPSWViewController.h"
#import "JKCountDownButton.h"

@interface ForgetPSWViewController ()
{
    NSString *base_code;
}

@end

@implementation ForgetPSWViewController

@synthesize phone_tf,password_tf,agpassword_tf,code_tf,getCode_btn;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"忘记密码";
    
    [self initControl];
    
    [self initData];
    // Do any additional setup after loading the view from its nib.
}

-(void)initControl
{
    
}

-(void)initData
{
    
}

-(IBAction)gotoGetCode:(JKCountDownButton *)sender
{
    [phone_tf resignFirstResponder];
    [code_tf resignFirstResponder];
    
    if (phone_tf.text.length == 0)
    {
        [self.view makeToast:@"请输入手机号码" duration:1.5 position:@"center"];
        return;
    }
    [self getCode];
}

-(void)getCode
{
    Frequest *req = [[Frequest alloc]init];
    req.delegate = self;
    //    req.apiName = @"Login";
    req.connectEnd = @selector(codeConEnd:);
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    [postDic setObject:phone_tf.text forKey:@"phone"];
    //    NSString *forBase64Str = [password.text base64String];
    //    NSLog(@"%@",forBase64Str);
    [MBProgressHUD showHUDAddedTo:self.view text:@"发送中..."];
    [req callAPI:SENDRESETPASSWORDCODEURL WithParams:postDic WithFileArray:nil View:self.view author:NO];
}

-(void)codeConEnd:(id)aInfo
{
    
    
    [MBProgressHUD hideHUDForView:self.view animated:NO];
    NSDictionary *Dict = [NSDictionary dictionaryWithDictionary:aInfo];
    base_code = [Dict objectForKey:@"base_code"];
    
    getCode_btn.enabled = NO;
    //button type要 设置成custom 否则会闪动
    [getCode_btn startWithSecond:60];
    
    [getCode_btn didChange:^NSString *(JKCountDownButton *countDownButton,int second) {
        //默认为123456
        //        code.text = @"123456";
        NSString *title = [NSString stringWithFormat:@"剩余%d秒",second];
        return title;
    }];
    [getCode_btn didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
        countDownButton.enabled = YES;
        return @"点击重新获取";
    }];
}

-(IBAction)gotoChangePSW:(id)sender
{
    if (code_tf.text.length == 0)
    {
        [self.view makeToast:@"请输入验证码" duration:1.5 position:@"center"];
        return;
    }
    if (password_tf.text.length == 0)
    {
        [self.view makeToast:@"请输入新密码" duration:1.5 position:@"center"];
        return;
    }
    if (agpassword_tf.text.length == 0)
    {
        [self.view makeToast:@"请确认新密码" duration:1.5 position:@"center"];
        return;
    }
    if (![agpassword_tf.text isEqualToString:password_tf.text])
    {
        [self.view makeToast:@"两次密码不相同" duration:1.5 position:@"center"];
        return;
    }
    Frequest *req = [[Frequest alloc]init];
    req.delegate = self;
    //    req.apiName = @"Login";
    //    req.connectEnd = @selector(movieConEnd:);
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    [postDic setObject:phone_tf.text forKey:@"phone"];
    [postDic setObject:password_tf.text forKey:@"new_password"];
    [postDic setObject:agpassword_tf.text forKey:@"confirm_password"];
    [postDic setObject:base_code forKey:@"base_code"];
    [postDic setObject:code_tf.text forKey:@"verify_code"];
    
    [MBProgressHUD showHUDAddedTo:self.view text:@"设置中..."];
    [req callAPI:RESETPASSWORDURL WithParams:postDic WithFileArray:nil View:self.view author:YES];
}

-(void)connectEnd:(id)aInfo
{
    [MBProgressHUD hideHUDForView:self.view animated:NO];
    [self.view makeToast:@"设置成功" duration:1.5 position:@"center"];
    
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
