//
//  IndexParser.m
//  YQB
//
//  Created by jian on 15/6/18.
//  Copyright (c) 2015年 jian. All rights reserved.
//

#import "IndexParser.h"

@implementation IndexParser

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    
    return @{
             //将JSON字典里name键对应的值，赋值给name属性
             @"borrow_id": @"borrow_id",
             @"borrow_user_id":@"borrow_user_id",
             @"borrow_code":@"borrow_code",
             @"borrow_money":@"borrow_money",
             @"borrow_repay":@"borrow_repay",
             @"borrow_expire":@"borrow_expire",
             @"borrow_rate":@"borrow_rate",
             @"borrow_work_unit":@"borrow_work_unit",
             @"borrow_content":@"borrow_content",
             @"borrow_account_yes":@"borrow_account_yes",
             @"borrow_account_wait":@"borrow_account_wait",
             @"borrow_account_scale":@"borrow_account_scale",
             @"borrow_left_time":@"borrow_left_time",
             @"borrow_full_status":@"borrow_full_status",
             @"borrow_now_status":@"borrow_now_status",
             @"borrow_user_total":@"borrow_user_total",
             @"borrow_pic":@"borrow_pic",
             @"login_name":@"borrow_user.login_name",
             @"real_name":@"borrow_user.real_name",
             @"phone":@"borrow_user.phone",
             @"head_pic":@"borrow_user.head_pic",
             @"email":@"borrow_user.email",
             @"ifSelf":@"borrow_user.self",
             @"self_loan_money":@"self_loan_money",
             };
}

@end
