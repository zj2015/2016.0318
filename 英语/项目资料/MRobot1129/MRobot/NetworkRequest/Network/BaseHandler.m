//
//  BaseHandler.m
//  zlydoc-iphone
//
//  Created by Ryan on 14-6-25.
//  Copyright (c) 2014年 zlycare. All rights reserved.
//

#import "BaseHandler.h"
#import "APIConfig.h"

@implementation BaseHandler

+ (NSString *)requestUrlWithPath:(NSString *)path
{
#if TARGET_VERSION_LITE ==1
    //target（中考校内版）需要执行的代码
    return [BASE_URL stringByAppendingString:path];
    
#elif TARGET_VERSION_LITE ==2
    //target（中考校外版）需要执行的代码
    return [BASE_URL stringByAppendingString:path];
    
#elif TARGET_VERSION_LITE ==3
    //target（高考校内版）需要执行的代码
    return [HIGH_BASE_URL stringByAppendingString:path];
    
#elif TARGET_VERSION_LITE ==4
    //target（高考校外版）需要执行的代码
    return [HIGH_BASE_URL stringByAppendingString:path];
#endif
}

@end
