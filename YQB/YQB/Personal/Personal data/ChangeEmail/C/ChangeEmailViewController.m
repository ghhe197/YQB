//
//  ChangeEmailViewController.m
//  YQB
//
//  Created by jian on 15/5/29.
//  Copyright (c) 2015年 jian. All rights reserved.
//

#import "ChangeEmailViewController.h"

@interface ChangeEmailViewController ()

@end

@implementation ChangeEmailViewController

@synthesize oldEmail_TF,theNewEmail_TF;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"更换邮箱";
    
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
    [addGoodsBtn addTarget:self action:@selector(gotoChangeEmail:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barItem =[[UIBarButtonItem alloc] initWithCustomView:addGoodsBtn];
    self.navigationItem.rightBarButtonItem = barItem;
}

-(void)initData
{
    
}

-(void)gotoChangeEmail:(UIButton *)sender
{
    [oldEmail_TF resignFirstResponder];
    [theNewEmail_TF resignFirstResponder];
    
    if (oldEmail_TF.text.length == 0)
    {
        [self.view makeToast:@"请输入旧邮箱" duration:1.5 position:@"center"];
        return;
    }
    if (theNewEmail_TF.text.length == 0)
    {
        [self.view makeToast:@"请输入新邮箱" duration:1.5 position:@"center"];
        return;
    }
    
    [self changeEmail];
}

-(void)changeEmail
{
    Frequest *req = [[Frequest alloc]init];
    req.delegate = self;
    //    req.apiName = @"Login";
    //    req.connectEnd = @selector(movieConEnd:);
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    [postDic setObject:oldEmail_TF.text forKey:@"old_email"];
    [postDic setObject:theNewEmail_TF.text forKey:@"new_email"];
    
    [MBProgressHUD showHUDAddedTo:self.view text:@"修改中..."];
    [req callAPI:CHANGEEMAILURL WithParams:postDic WithFileArray:nil View:self.view author:YES];
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
