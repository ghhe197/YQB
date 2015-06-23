//
//  LoginViewController.m
//  YQB
//
//  Created by jian on 15/5/20.
//  Copyright (c) 2015年 jian. All rights reserved.
//

#import "LoginViewController.h"
#import "SignPSWViewController.h"
#import "IndexViewController.h"
#import "LoginData.h"
#import "ForgetPSWViewController.h"
#import "PersonalViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize phone,password;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"登录";
    
    //加载控件
    [self initControl];
    
    //请求数据
    [self initData];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.leftBarButtonItem = nil;
}

-(void)initControl
{
    
}

-(void)initData
{
    phone.text = @"15913175401";
    password.text = @"123456";
}

-(IBAction)checkLogin:(id)sender
{
    [phone resignFirstResponder];
    [password resignFirstResponder];
    
    if (phone.text.length == 0)
    {
        [self.view makeToast:@"请输入手机号码" duration:1.5 position:@"center"];
        return;
    }
    if (password.text.length == 0)
    {
        [self.view makeToast:@"请输入登录密码" duration:1.5 position:@"center"];
        return;
    }
    [self getLogin];
}

//登录
-(void)getLogin
{
    Frequest *req = [[Frequest alloc]init];
    req.delegate = self;
//    req.apiName = @"Login";
    //    req.connectEnd = @selector(movieConEnd:);
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    [postDic setObject:phone.text forKey:@"phone"];
    NSString *forBase64Str = [password.text base64String];
    [postDic setObject:forBase64Str forKey:@"password"];
    [MBProgressHUD showHUDAddedTo:self.view text:@"登录中..."];
    [req callAPI:LOGINURL WithParams:postDic WithFileArray:nil View:self.view author:NO];
}

-(void)connectEnd:(id)aInfo
{
    [MBProgressHUD hideHUDForView:self.view animated:NO];
    [self.view makeToast:@"登录成功" duration:1.5 position:@"center"];
//    LoginParser *loginInfo = [aInfo objectForKey:@"info"];
    
    [[NSUserDefaults standardUserDefaults] setObject:[aInfo objectForKey:AUTHOR_TOKEN] forKey:AUTHOR_TOKEN];
    [[NSUserDefaults standardUserDefaults] setObject:[aInfo objectForKey:USERID] forKey:USERID];
    
    for (NSString *key in [aInfo allKeys])
    {
        NSString *value = [aInfo valueForKey:key];
        
        [[LoginData mineData] setValue:value forKey:key];
    }
    
    [self performSelector:@selector(gotoIndex) withObject:nil afterDelay:1.5];

}

-(void)gotoIndex
{
    IndexViewController *index = [[IndexViewController alloc]initWithNibName:@"IndexViewController" bundle:nil];
    [self.navigationController pushViewController:index animated:YES];
}

-(IBAction)gotoSign:(id)sender
{
    SignPSWViewController *signPSW = [[SignPSWViewController alloc]initWithNibName:@"SignPSWViewController" bundle:nil];
    [self.navigationController pushViewController:signPSW animated:YES];
}

-(IBAction)forgetPSW:(id)sender
{
    ForgetPSWViewController *forgetPSW = [[ForgetPSWViewController alloc]initWithNibName:@"ForgetPSWViewController" bundle:nil];
    [self.navigationController pushViewController:forgetPSW animated:YES];
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
