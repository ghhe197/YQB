//
//  ChangePhoneViewController.m
//  YQB
//
//  Created by jian on 15/5/29.
//  Copyright (c) 2015年 jian. All rights reserved.
//

#import "ChangePhoneViewController.h"

@interface ChangePhoneViewController ()
{
    NSString *base_code;
}

@end

@implementation ChangePhoneViewController

@synthesize oldPSW_TF,oldPhone_TF,theNewPhone_TF,getCode_btn,code_TF;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"更换手机号";
    
    //加载控件
    [self initControl];
    
    //请求数据
    [self initData];
    // Do any additional setup after loading the view from its nib.
}

-(void)initControl
{
    UIButton *addGoodsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addGoodsBtn.frame = CGRectMake(0, 0, 35, 40);
    [addGoodsBtn setTitle:@"提交" forState:0];
    addGoodsBtn.titleLabel.font = [UIFont fontWithName:@"FZLTHJW--GB1-0" size:16];
    [addGoodsBtn addTarget:self action:@selector(gotoChangePhone:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barItem =[[UIBarButtonItem alloc] initWithCustomView:addGoodsBtn];
    self.navigationItem.rightBarButtonItem = barItem;
}

-(void)initData
{
    
}

-(IBAction)gotoGetCode:(id)sender
{
    [oldPSW_TF resignFirstResponder];
    [oldPhone_TF resignFirstResponder];
    [theNewPhone_TF resignFirstResponder];
    [code_TF resignFirstResponder];
    
    if (theNewPhone_TF.text.length == 0)
    {
        [self.view makeToast:@"请输入新手机号码" duration:1.5 position:@"center"];
        return;
    }
    Frequest *req = [[Frequest alloc]init];
    req.delegate = self;
    //    req.apiName = @"Login";
    req.connectEnd = @selector(codeConEnd:);
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    [postDic setObject:theNewPhone_TF.text forKey:@"new_phone"];
    [postDic setObject:@"change_phone" forKey:@"code_type"];
    //    NSString *forBase64Str = [password.text base64String];
    //    NSLog(@"%@",forBase64Str);
    [MBProgressHUD showHUDAddedTo:self.view text:@"发送中..."];
    [req callAPI:SENDVERIFYCODEURL WithParams:postDic WithFileArray:nil View:self.view author:YES];
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
//        code_TF.text = @"123456";
        NSString *title = [NSString stringWithFormat:@"剩余%d秒",second];
        return title;
    }];
    [getCode_btn didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
        countDownButton.enabled = YES;
        return @"点击重新获取";
    }];
}

-(void)gotoChangePhone:(UIButton *)sender
{
    [oldPSW_TF resignFirstResponder];
    [oldPhone_TF resignFirstResponder];
    [theNewPhone_TF resignFirstResponder];
    [code_TF resignFirstResponder];
    
    if (oldPSW_TF.text.length == 0)
    {
        [self.view makeToast:@"请输入原密码" duration:1.5 position:@"center"];
        return;
    }
    if (oldPhone_TF.text.length == 0)
    {
        [self.view makeToast:@"请输入旧手机号码" duration:1.5 position:@"center"];
        return;
    }
    if (theNewPhone_TF.text.length == 0)
    {
        [self.view makeToast:@"请输入新手机号码" duration:1.5 position:@"center"];
        return;
    }
    if (code_TF.text.length == 0)
    {
        [self.view makeToast:@"请输入手机验证码" duration:1.5 position:@"center"];
        return;
    }
    
    [self changePhone];
}

-(void)changePhone
{
    Frequest *req = [[Frequest alloc]init];
    req.delegate = self;
    //    req.apiName = @"Login";
    //    req.connectEnd = @selector(movieConEnd:);
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    [postDic setObject:[oldPSW_TF.text base64String] forKey:@"password"];
    [postDic setObject:oldPhone_TF.text forKey:@"old_phone"];
    [postDic setObject:theNewPhone_TF.text forKey:@"new_phone"];
    [postDic setObject:base_code forKey:@"base_code"];
    [postDic setObject:code_TF.text forKey:@"verify_code"];
    
    [MBProgressHUD showHUDAddedTo:self.view text:@"修改中..."];
    [req callAPI:CHANGEPHONEURL WithParams:postDic WithFileArray:nil View:self.view author:YES];
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
