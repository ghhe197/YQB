//
//  Frequest.h
//  YQB
//
//  Created by jian on 15/5/11.
//  Copyright (c) 2015年 jian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "Config.h"
#import "JSONKit.h"
#import "BaseParser.h"
#import "MBProgressHUD.h"
#import "Toast+UIView.h"

@interface Frequest : NSObject
{
    NSString *_apiName;
    
    NSMutableDictionary *_responseDic;
    
    id delegate;
}

@property(nonatomic,assign)id delegate;
@property(nonatomic,retain) NSMutableDictionary *responseDic;
@property(nonatomic,retain) NSString *apiName;
@property(nonatomic,assign) SEL connectEnd;         // 请求成功
@property(nonatomic,assign) SEL connectFailded;     // 请求失败

//yes表示需要授权
-(void)callAPI:(NSString *)aAPI
    WithParams:(NSMutableDictionary *)aParams
 WithFileArray:(NSMutableArray *)aArray
          View:(UIView *)aView
        author:(BOOL)yes;

//注册
-(void)callAPI:(NSString *)aAPI
    WithParams:(NSMutableDictionary *)aParams
          path:(NSURL *)aPath
          View:(UIView *)aView;

@end
