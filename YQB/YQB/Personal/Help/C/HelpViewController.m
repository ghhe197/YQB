//
//  HelpViewController.m
//  YQB
//
//  Created by jian on 15/5/29.
//  Copyright (c) 2015年 jian. All rights reserved.
//

#import "HelpViewController.h"
#import "HelpCell.h"

@interface HelpViewController ()

@end

@implementation HelpViewController

@synthesize helpTableView,groupArr;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"帮助中心";
    
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
    NSMutableArray *nameArr = [[NSMutableArray alloc]initWithObjects:@"资金安全",@"账户安全",@"使用教程",@"常见问题", nil];
    NSMutableArray *imgArr = [[NSMutableArray alloc]initWithObjects:@"help_money_safety_icon.png",@"help_account_safety_icon.png",@"help_use_icon.png",@"help_question_icon.png", nil];
    
    for (int i = 0; i < nameArr.count; i ++)
    {
        dataDic = [[NSMutableDictionary alloc]init];
        [dataDic setObject:[nameArr objectAtIndex:i] forKey:@"title"];
        [dataDic setObject:[imgArr objectAtIndex:i] forKey:@"img"];
        
        [arr addObject:dataDic];
    }
    
    [dic setObject:arr forKey:@"users"];
    [groupArr addObject:dic];
    
    [helpTableView reloadData];
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
    return 44;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"PersonalCell";
    
    HelpCell *Cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (Cell == nil)
    {
        Cell = (HelpCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"HelpCell" owner:self options:nil]  lastObject];
    }
    
    NSDictionary* m= (NSDictionary*)[groupArr objectAtIndex: indexPath.section];
    NSArray *d = (NSArray*)[m objectForKey:@"users"];
    
    if (indexPath.section == 0)
    {
        Cell.ImgView.hidden = NO;
        [Cell.ImgView setImage:[UIImage imageNamed:[[d objectAtIndex:indexPath.row] objectForKey:@"img"]]];
        Cell.title_Label.text = [[d objectAtIndex:indexPath.row] objectForKey:@"title"];
        return Cell;
    }
    
    return Cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 14;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
