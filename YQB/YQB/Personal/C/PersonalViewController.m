//
//  PersonalViewController.m
//  YQB
//
//  Created by jian on 15/5/26.
//  Copyright (c) 2015年 jian. All rights reserved.
//

#import "PersonalViewController.h"
#import "PersonalHeadCell.h"
#import "PersonalCell.h"
#import "PersonalFootView.h"
#import "ChangePSWViewController.h"
#import "PersonalDataViewController.h"
#import "HelpViewController.h"

@interface PersonalViewController ()

@end

@implementation PersonalViewController

@synthesize groupArr,personalTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人中心";
    
    [self initControl];
    
    [self initData];
    // Do any additional setup after loading the view from its nib.
}

-(void)initControl
{
    
}

-(void)initData
{
    groupArr = [[NSMutableArray alloc]init];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc]init];
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSMutableArray *nameArr = [[NSMutableArray alloc]initWithObjects:@"修改密码",@"更换资料",@"帮助中心",@"版本更新", nil];
    NSMutableArray *imgArr = [[NSMutableArray alloc]initWithObjects:@"personal_trade_password_icon.png",@"personal_data_icon.png",@"personal_help_icon.png",@"personal_update_icon.png", nil];
    
    [dataDic setObject:@"" forKey:@"name"];
    [arr addObject:dataDic];
    [dic setObject:arr forKey:@"users"];
    [groupArr addObject:dic];
    
    dic = [[NSMutableDictionary alloc]init];
    arr = [[NSMutableArray alloc]init];
    for (int i = 0; i < nameArr.count; i ++)
    {
        dataDic = [[NSMutableDictionary alloc]init];
        [dataDic setObject:[nameArr objectAtIndex:i] forKey:@"title"];
        [dataDic setObject:[imgArr objectAtIndex:i] forKey:@"img"];
        
        [arr addObject:dataDic];
    }

    [dic setObject:arr forKey:@"users"];
    [groupArr addObject:dic];
    
    dic = [[NSMutableDictionary alloc]init];
    dataDic = [[NSMutableDictionary alloc]init];
    arr = [[NSMutableArray alloc]init];
    
    [dataDic setObject:@"关于我们" forKey:@"title"];
    [arr addObject:dataDic];
    [dic setObject:arr forKey:@"users"];
    [groupArr addObject:dic];
    
    [personalTableView reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return groupArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary* d=[groupArr objectAtIndex:section];
    return [[d objectForKey:@"users"] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 70;
    }
    else
    {
        return 44;
    }
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *headCellIdentifier = @"PersonalHeadCell";
    static NSString *CellIdentifier = @"PersonalCell";
    
    PersonalHeadCell *headCell = [tableView dequeueReusableCellWithIdentifier:headCellIdentifier];
    if (headCell == nil)
    {
        headCell = (PersonalHeadCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"PersonalHeadCell" owner:self options:nil]  lastObject];
    }
    PersonalCell *Cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (Cell == nil)
    {
        Cell = (PersonalCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"PersonalCell" owner:self options:nil]  lastObject];
    }
    
    NSDictionary* m= (NSDictionary*)[groupArr objectAtIndex: indexPath.section];
    NSArray *d = (NSArray*)[m objectForKey:@"users"];
    
    if (indexPath.section == 0)
    {
        [headCell.headImgView sd_setImageWithURL:[NSURL URLWithString:[LoginData mineData].avatar] placeholderImage:nil];
        headCell.name_Label.text = [LoginData mineData].nickname;
        headCell.account_Label.text = [NSString stringWithFormat:@"账号：%@",[LoginData mineData].phone];
        return headCell;
    }
    if (indexPath.section == 1)
    {
        Cell.ImgView.hidden = NO;
        [Cell.ImgView setImage:[UIImage imageNamed:[[d objectAtIndex:indexPath.row] objectForKey:@"img"]]];
        Cell.title_Label.text = [[d objectAtIndex:indexPath.row] objectForKey:@"title"];
        return Cell;
    }
    if (indexPath.section == 2)
    {
        Cell.ImgView.hidden = YES;
        Cell.title_Label.text = [[d objectAtIndex:indexPath.row] objectForKey:@"title"];
        return Cell;
    }
    
    return Cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 14;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 2)
    {
        return self.view.frame.size.height - 348;
    }
    return tableView.tableFooterView.frame.size.height;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 2)
    {
        PersonalFootView *footView = [[[NSBundle mainBundle] loadNibNamed:@"PersonalFootView" owner:self options:nil] lastObject];
//        [footView.exit_Btn addTarget:self action:@selector(AAAA) forControlEvents:UIControlEventTouchUpInside];
        footView.frame = CGRectMake(0, 0, self.view.frame.size.width, 160);
        [footView.exitBtn addTarget:self action:@selector(goBacktoLogin:) forControlEvents:UIControlEventTouchUpInside];
        
        return footView;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        
    }
    if (indexPath.section == 1)
    {
        if (indexPath.row == 0)
        {
            ChangePSWViewController *changePSW = [[ChangePSWViewController alloc]initWithNibName:@"ChangePSWViewController" bundle:nil];
            [self.navigationController pushViewController:changePSW animated:YES];
        }
        if (indexPath.row == 1)
        {
            PersonalDataViewController *personalData = [[PersonalDataViewController alloc]initWithNibName:@"PersonalDataViewController" bundle:nil];
            [self.navigationController pushViewController:personalData animated:YES];
        }
        if (indexPath.row == 2)
        {
            HelpViewController *help = [[HelpViewController alloc]initWithNibName:@"HelpViewController" bundle:nil];
            [self.navigationController pushViewController:help animated:YES];
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)goBacktoLogin:(UIButton *)sender
{
    Frequest *req = [[Frequest alloc]init];
    req.delegate = self;
    //    req.apiName = @"Login";
//    req.connectEnd = @selector(codeConEnd:);
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    [postDic setObject:[LoginData mineData].user_id forKey:@"user_id"];
    //    NSString *forBase64Str = [password.text base64String];
    //    NSLog(@"%@",forBase64Str);
    [MBProgressHUD showHUDAddedTo:self.view text:@"发送中..."];
    [req callAPI:LOGOUTURL WithParams:postDic WithFileArray:nil View:self.view author:YES];
}

-(void)connectEnd:(id)aInfo
{
    [MBProgressHUD hideHUDForView:self.view animated:NO];
    [self.view makeToast:@"退出成功" duration:1.5 position:@"center"];
    [self performSelector:@selector(gotoLogin) withObject:nil afterDelay:1.5];
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
