//
//  LoginData.m
//  YQB
//
//  Created by jian on 15/5/29.
//  Copyright (c) 2015年 jian. All rights reserved.
//

#import "LoginData.h"

@implementation LoginData

@synthesize phone,real_name,user_id,is_status,total,income,expend,balance,balance_cash,balance_frost,frost,await,repay,frost_cash,nickname,avatar,token;

static LoginData *mineData = nil;

+(LoginData *)mineData
{
    if (mineData == Nil)
    {
        mineData = [[LoginData alloc]init];
    }
    return mineData;
}

@end
