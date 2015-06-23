//
//  LoginData.h
//  YQB
//
//  Created by jian on 15/5/29.
//  Copyright (c) 2015年 jian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginData : NSObject

//手机号码
@property (nonatomic, strong) NSString *phone;
//唯一token(授权)
@property (nonatomic, strong) NSString *token;
//头像
@property (nonatomic, strong) NSString *avatar;
//真名
@property (nonatomic, strong) NSString *real_name;
//账户总额
@property (nonatomic, strong) NSString *total;
//收入
@property (nonatomic, strong) NSString *income;
//支出
@property (nonatomic, strong) NSString *expend;
//可用金额
@property (nonatomic, strong) NSString *balance;
//可提现金额
@property (nonatomic, strong) NSString *balance_cash;
//不可提现金额
@property (nonatomic, strong) NSString *balance_frost;
//冻结金额
@property (nonatomic, strong) NSString *frost;
//待收金额
@property (nonatomic, strong) NSString *await;
//待还金额
@property (nonatomic, strong) NSString *repay;
//提现冻结金额
@property (nonatomic, strong) NSString *frost_cash;
//昵称
@property (nonatomic, strong) NSString *nickname;
//唯一ID
@property (nonatomic, strong) NSString *user_id;
//状态
@property (nonatomic, strong) NSString *is_status;
//状态
@property (nonatomic, strong) NSString *is_validated;
//状态
@property (nonatomic, strong) NSString *is_edit;

+(LoginData *)mineData;

@end
