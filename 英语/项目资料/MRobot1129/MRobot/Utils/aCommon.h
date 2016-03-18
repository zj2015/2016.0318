//
//  aCommon.h
//  CCEnglish
//
//  Created by RD on 14-5-6.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "iToast.h"

@interface aCommon : NSObject {
    
}

+(NSData *)parseJsonDataXml:(NSData *)jsonDataXml;
+(void)iToast:(NSString *)msg;
+(BOOL)isBlankString:(NSString *)string;
+(NSMutableData *)dataWithPath:(NSString *)path;
+(long long)fileSizeAtPath:(NSString*) filePath;
+(NSString *)stringWithDictionary:(NSMutableDictionary *)dic;
+(NSURL *)convert2Mp4:(NSURL *)movUrl;
//返回View覆盖多余的tableview cell线条
+ (UIView *)tableViewsFooterView;

//返回view 确定tableView的背景颜色
+ (UIView *)tableViewsBackGroundView;

//返回view 确定tableView的背景图片
+ (UIView *)tableViewsBackImageView;

+(NSDictionary *)parseJsonDataXmls:(NSData *)jsonDataXml;

+ (BOOL)checkPassword:(NSString *) password;

//验证邮箱的合法性
+ (BOOL)validateEmail:(NSString *)email;

@end
