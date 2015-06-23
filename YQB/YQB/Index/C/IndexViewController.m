//
//  IndexViewController.m
//  YQB
//
//  Created by jian on 15/6/5.
//  Copyright (c) 2015年 jian. All rights reserved.
//

#import "IndexViewController.h"
#import "PersonalViewController.h"

@interface IndexViewController ()

@end

@implementation IndexViewController

@synthesize largeProgressView,indexData,nobgView,name_label,time_label,showtime_label,percent_label,loan_label,showloan_label,borrowMoney_label,showBorrowMoney_label,expire_label,rate_label,user_total_label;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"首页";
    
    [self initControl];
    [self initData];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.leftBarButtonItem.customView.hidden = YES;
}

-(void)initControl
{
    largeProgressView.roundedCorners = YES;
    largeProgressView.trackTintColor = HEXCOLOR(0x48E5FF);
    largeProgressView.progressTintColor = HEXCOLOR(0xFF741C);
}


-(void)initData
{
    Frequest *req = [[Frequest alloc]init];
    req.delegate = self;
    req.apiName = @"Index";
    //    req.connectEnd = @selector(movieConEnd:);
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    [MBProgressHUD showHUDAddedTo:self.view text:@"加载中..."];
    [req callAPI:GETLASTBORROWINFOURL WithParams:postDic WithFileArray:nil View:self.view author:YES];
}

-(void)connectEnd:(id)aInfo
{
    [MBProgressHUD hideHUDForView:self.view animated:NO];
    
    indexData = aInfo;
    
    if ([indexData.borrow_id isKindOfClass:[NSNull class]])
    {
        nobgView.hidden = NO;
    }
    else
    {
        nobgView.hidden = YES;
        
        if ((int)indexData.ifSelf == 1)
        {
            name_label.text = @"我";
        }
        else
        {
            name_label.text = indexData.login_name;
        }
        showBorrowMoney_label.text = indexData.borrow_money;
        showtime_label.text = indexData.borrow_left_time;
        percent_label.text = indexData.borrow_account_scale;
//        showloan_label.text = indexData.self_loan_money;
        expire_label.text = [NSString stringWithFormat:@"还款期限：%@天",indexData.borrow_expire];
        rate_label.text = [NSString stringWithFormat:@"年利率：%@%%",indexData.borrow_rate];
        user_total_label.text = [NSString stringWithFormat:@"募集人数：%@",indexData.borrow_user_total];
        
        CGFloat pro = [[NSString stringWithFormat:@"0.%@",indexData.borrow_account_scale] floatValue];
        [largeProgressView setProgress:pro animated:YES];
    }
}

//找人借钱
-(IBAction)gotoBorrowMoney:(id)sender
{
    
}

//输入邀请码
-(IBAction)gotoSetCode:(id)sender
{
    UITextField *textField;
    BlockTextPromptAlertView *alert = [BlockTextPromptAlertView promptWithTitle:@"输入借款邀请码" message:nil textField:&textField block:^(BlockTextPromptAlertView *alert)
                                       {
                                           [alert.textField resignFirstResponder];
                                           return YES;
                                       }];
    
    textField.keyboardType = UIKeyboardTypeNamePhonePad;
    [alert setCancelButtonWithTitle:@"取消" block:nil];
    [alert addButtonWithTitle:@"确定" block:^
     {
         NSLog(@"Text: %@", textField.text);
         
         if (textField.text.length == 0)
         {
             [alert.view makeToast:@"请输入借款邀请码" duration:1.0 position:@"center"];
             return ;
         }
         [alert removeTheView];
//         [self submitToCheck:textField.text];
     }];
    [alert show];
}

//扫描二维码
-(IBAction)gotoScanCode:(id)sender
{
    
}

//个人资料
-(IBAction)gotoPersonal:(id)sender
{
    
}

//钱包
-(IBAction)gotoWallet:(id)sender
{
    
}

//信息
-(IBAction)gotoMessage:(id)sender
{
    
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
