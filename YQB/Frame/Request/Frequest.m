//
//  Frequest.m
//  YQB
//
//  Created by jian on 15/5/11.
//  Copyright (c) 2015年 jian. All rights reserved.
//

#import "Frequest.h"

@implementation Frequest

@synthesize apiName = _apiName;
@synthesize connectEnd = _connectEnd;
@synthesize connectFailded =  _connectFailded;
@synthesize delegate = _delegate;

-(id)init
{
    if (self = [super init])
    {
        self.apiName = nil;
        self.responseDic = [NSMutableDictionary dictionary];
    }
    
    return self;
}

-(void)callAPI:(NSString *)aAPI
    WithParams:(NSMutableDictionary *)aParams
 WithFileArray:(NSMutableArray *)aArray
          View:(UIView *)aView
        author:(BOOL)yes
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *postData = [NSMutableDictionary dictionary];
    NSMutableDictionary *postJson = [NSMutableDictionary dictionary];
    
    //是否需要授权
    if(yes)
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *token = [defaults stringForKey:AUTHOR_TOKEN];
        NSString *user_id = [defaults stringForKey:USERID];
        [aParams setObject:token forKey:AUTHOR_TOKEN];
        [aParams setObject:user_id forKey:USERID];
    }

    [postData setObject:aParams forKey:@"data"];
    NSString *jsonStr = [postData JSONString];
    [postJson setObject:jsonStr forKey:@"json"];
    manager.requestSerializer.timeoutInterval = 10;
    NSMutableString *theUrl = [NSMutableString string];
    [theUrl appendString:BASEURL];
    [theUrl appendString:aAPI];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:theUrl parameters:postJson constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         if (aArray.count != 0)
         {
             for (int i = 0; i < aArray.count; i++)
             {
                 NSURL *postFile = aArray[i];
                 
                 NSString *fileName = [NSMutableString stringWithFormat:@"pic[%d]",i];
                 [formData appendPartWithFileURL:postFile name:fileName error:nil];
             }
         }
     } success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSDictionary *resDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"%@",resDic);
         int error = [[resDic objectForKey:@"error"] intValue];
         
         if (!self.connectEnd)
         {
             self.connectEnd = @selector(connectEnd:);
         }
         
         if (error == 0)
         {
             NSDictionary *resData = [resDic objectForKey:@"data"];
             
             if (self.apiName.length != 0)
             {
             NSString *parserName = [self.apiName stringByAppendingString:@"Parser"];
              
             Class _parserClass = NSClassFromString(parserName);
             BaseParser *parser = nil;
             
             parser = [MTLJSONAdapter modelOfClass:[_parserClass class] fromJSONDictionary:resData error:nil];
                 
//             id obj = [parser superParser];
             
             [self.delegate performSelector:self.connectEnd
                                 withObject:parser];
             }
             else
             {
                 [self.delegate performSelector:self.connectEnd
                                     withObject:resData];
             }
         }
         else
         {
             [MBProgressHUD hideHUDForView:aView animated:NO];
             [aView makeToast:[resDic objectForKey:@"msg"] duration:1.5 position:@"center"];
         }

         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [MBProgressHUD hideHUDForView:aView animated:NO];
         [aView makeToast:@"网络连接失败" duration:1.5 position:@"center"];
     }];
}

-(void)callAPI:(NSString *)aAPI
    WithParams:(NSMutableDictionary *)aParams
          path:(NSURL *)aPath
          View:(UIView *)aView
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *postData = [NSMutableDictionary dictionary];
    NSMutableDictionary *postJson = [NSMutableDictionary dictionary];
    
    [postData setObject:aParams forKey:@"data"];
    NSString *jsonStr = [postData JSONString];
    [postJson setObject:jsonStr forKey:@"json"];
    manager.requestSerializer.timeoutInterval = 10;
    NSMutableString *theUrl = [NSMutableString string];
    [theUrl appendString:BASEURL];
    [theUrl appendString:aAPI];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:theUrl parameters:postJson constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
    {
        if (aPath)
        {
            [formData appendPartWithFileURL:aPath name:@"pic[]" error:nil];
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSDictionary *resDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",resDic);
        int error = [[resDic objectForKey:@"error"] intValue];
        
        if (!self.connectEnd)
        {
            self.connectEnd = @selector(connectEnd:);
        }
        
        if (error == 0)
        {
            NSDictionary *resData = [resDic objectForKey:@"data"];
            
            [self.delegate performSelector:self.connectEnd
                                    withObject:resData];

        }
        else
        {
            [MBProgressHUD hideHUDForView:aView animated:NO];
            [aView makeToast:[resDic objectForKey:@"msg"] duration:1.5 position:@"center"];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        [MBProgressHUD hideHUDForView:aView animated:NO];
        [aView makeToast:@"网络连接失败" duration:1.5 position:@"center"];
    }];
}

@end
