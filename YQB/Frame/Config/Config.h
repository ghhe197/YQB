//
//  Config.h
//  anzhi
//
//  Created by HJJ on 13-9-22.
//  Copyright (c) 2013年 HJJ. All rights reserved.
//

#define debug         1    // 是否输出服务器返回的信息

//动态获取设备高度
#define IPHONE_HEIGHT [UIScreen mainScreen].bounds.size.height
#define IPHONE_WIDTH [UIScreen mainScreen].bounds.size.width

//字体
#define FZLTHJW                     @"FZLTHJW--GB1-0"

//设置颜色
#define HEXCOLOR(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//设置颜色与透明度
#define HEXCOLORAL(rgbValue, al) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:al]]

//重写NSLog,Debug模式下打印日志和当前行数
#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif



//www
////shoptest
//#define TESTSHOPURL @"http://www.lifeq.com.cn/mall/index.php?app=api_v2&act="
//
////ordertest
//#define TESTORDERURL @"http://www.lifeq.com.cn/mall/index.php?app=dapi_order&act="




//base
#define BASEURL @"http://192.168.0.104:8080/appport.php/"

//登陆接口
#define LOGINURL @"User/login"

//登出
#define LOGOUTURL @"User/logOut"

//获取注册验证码接口
#define GETCODEURL @"User/sendRegisterPhoneCode"

//验证手机号码接口
#define VERIFYPHONECODEURL @"User/verifyRegisterPhoneCode"

//注册接口
#define REGISTERURL @"User/register"

//修改密码接口
#define CHANGEPASSWORDURL @"PersonalCenter/changePassword"

//获取个人中心验证码接口
#define SENDVERIFYCODEURL @"PersonalCenter/sendVerifyCode"

//修改手机号接口
#define CHANGEPHONEURL @"PersonalCenter/changePhone"

//获取个人资料接口
#define GETBASEUSERINFOURL @"PersonalCenter/getBaseUserInfo"

//更新个人资料接口
#define UPDATEUSERINFOURL @"PersonalCenter/updateUserInfo"

//更改邮箱接口
#define CHANGEEMAILURL @"PersonalCenter/changeEmail"

//测试图片接口
#define TEXTTTTTTT @"Index/testUploadPics"

//获取用户最新的有效的借款单
#define GETLASTBORROWINFOURL @"Borrow/getLastBorrowInfo"

//忘记密码
#define RESETPASSWORDURL @"User/resetPassword"

//发送重置密码
#define SENDRESETPASSWORDCODEURL @"User/sendResetPasswordCode"




#define AUTHOR_TOKEN                @"token"

#define USERID                      @"user_id"

