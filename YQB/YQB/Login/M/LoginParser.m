//
//  LoginParser.m
//  YQB
//
//  Created by jian on 15/5/12.
//  Copyright (c) 2015年 jian. All rights reserved.
//

#import "LoginParser.h"

@implementation LoginParser


+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    
    return @{
             //将JSON字典里name键对应的值，赋值给name属性
             @"phone": @"phone",
             @"user_id":@"user_id",
             @"real_name":@"real_name",
             @"is_status":@"is_status",
             @"total":@"total",
             @"income":@"income",
             @"expend":@"expend",
             @"balance":@"balance",
             @"balance_cash":@"balance_cash",
             @"balance_frost":@"balance_frost",
             @"frost":@"frost",
             @"await":@"await",
             @"repay":@"repay",
             @"frost_cash":@"frost_cash",
             @"nickname":@"nickname",
             @"avatar":@"avatar",
             @"token":@"token",
             };
}

@end
