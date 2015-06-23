//
//  SignPSWViewController.m
//  YQB
//
//  Created by jian on 15/5/21.
//  Copyright (c) 2015年 jian. All rights reserved.
//

#import "SignPSWViewController.h"
#import "SignDetailViewController.h"

@interface SignPSWViewController ()
{
    NSString *base_code;
}

@end

@implementation SignPSWViewController

@synthesize phone,code,getCode_btn;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"注册";
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)gotoGetCode:(JKCountDownButton*)sender
{
    [self getCode];
}

//获取验证码
-(void)getCode
{
    [phone resignFirstResponder];
    [code resignFirstResponder];
    
    if (phone.text.length == 0)
    {
        [self.view makeToast:@"请输入手机号码" duration:1.5 position:@"center"];
        return;
    }
    Frequest *req = [[Frequest alloc]init];
    req.delegate = self;
//    req.apiName = @"Login";
    req.connectEnd = @selector(codeConEnd:);
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    [postDic setObject:phone.text forKey:@"phone"];
    //    NSString *forBase64Str = [password.text base64String];
    //    NSLog(@"%@",forBase64Str);
    [MBProgressHUD showHUDAddedTo:self.view text:@"发送中..."];
    [req callAPI:GETCODEURL WithParams:postDic WithFileArray:nil View:self.view author:NO];
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

-(IBAction)gotoSignDetail:(id)sender
{
    [phone resignFirstResponder];
    [code resignFirstResponder];
    
    if (phone.text.length == 0)
    {
        [self.view makeToast:@"请输入手机号码" duration:1.5 position:@"center"];
        return;
    }
    if (code.text.length == 0)
    {
        [self.view makeToast:@"请输入验证码" duration:1.5 position:@"center"];
        return;
    }
    
    [self gotoNext];

}

-(void)gotoNext
{
    Frequest *req = [[Frequest alloc]init];
    req.delegate = self;
//    req.apiName = @"Login";
    req.connectEnd = @selector(nextConEnd:);
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    [postDic setObject:phone.text forKey:@"phone"];
//    NSString *forBase64Str = [password.text base64String];
//    NSLog(@"%@",forBase64Str);
    [postDic setObject:code.text forKey:@"verify_code"];
    [postDic setObject:base_code forKeyedSubscript:@"base_code"];
    [MBProgressHUD showHUDAddedTo:self.view text:@"验证中..."];
    [req callAPI:VERIFYPHONECODEURL WithParams:postDic WithFileArray:nil View:self.view author:NO];
}

-(void)nextConEnd:(id)aInfo
{
    [MBProgressHUD hideHUDForView:self.view animated:NO];
    SignDetailViewController *signDetail = [[SignDetailViewController alloc]initWithNibName:@"SignDetailViewController" bundle:nil];
    base_code = [aInfo objectForKey:@"base_code"];
    signDetail.base_code = base_code;
    [[NSUserDefaults standardUserDefaults] setObject:phone.text forKey:@"signphone"];
    [self.navigationController pushViewController:signDetail animated:YES];
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
