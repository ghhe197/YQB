//
//  UILabel+changeFont_Label.m
//  YQB
//
//  Created by jian on 15/5/21.
//  Copyright (c) 2015年 jian. All rights reserved.
//

#import "UILabel+changeFont_Label.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "Config.h"

@implementation UILabel (changeFont_Label)

+ (void)load
{
    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
    method_exchangeImplementations(imp, myImp);
}

- (id)myInitWithCoder:(NSCoder*)aDecode
{
    [self myInitWithCoder:aDecode];
    if (self) {
        CGFloat fontSize = self.font.pointSize;
        self.font = [UIFont fontWithName:FZLTHJW size:fontSize];
    }
    return self;
}

@end
