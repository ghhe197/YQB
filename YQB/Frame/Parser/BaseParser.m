//
//  BaseParser.m
//  TuDou
//
//  Created by Kallen on 13-5-21.
//  Copyright (c) 2013年 Kallen. All rights reserved.
//

#import "BaseParser.h"

@implementation BaseParser
//@synthesize parserString = _parserString;
//@synthesize parseredDic = _parseredDic;

//-(id)initWithDic:(NSDictionary *)aDic
//{
//    if (self = [super init])
//    {
////        self.parserString = aStr;
////        self.parseredDic = [NSMutableDictionary dictionary];
//    }
//    return self;
//}

//-(id)superParser
//{
//    return [self parser:self.parseredDic];
//}
//
// 虚函数
//-(id)parser:(id)aDic
//{
//    return nil;
//}

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             
             };
}

+ (NSValueTransformer *)dateJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *dateNum) {
        return [NSDate dateWithTimeIntervalSince1970:dateNum.floatValue];
    } reverseBlock:^(NSDate *date) {
        return [NSString stringWithFormat:@"%f",[date timeIntervalSince1970]];
    }];
}

@end
