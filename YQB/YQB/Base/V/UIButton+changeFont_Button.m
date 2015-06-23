//
//  UIButton+changeFont_Button.m
//  YQB
//
//  Created by jian on 15/5/21.
//  Copyright (c) 2015年 jian. All rights reserved.
//

#import "UIButton+changeFont_Button.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "Config.h"

@implementation UIButton (changeFont_Button)

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
        CGFloat fontSize = self.titleLabel.font.pointSize;
        self.titleLabel.font = [UIFont fontWithName:FZLTHJW size:fontSize];
    }
    return self;
}

@end
