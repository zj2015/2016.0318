//
//  LoginHandler.h
//  RTLibrary-ios
//
//  Created by Ryan on 14-8-3.
//  Copyright (c) 2014年 zlycare. All rights reserved.
//


#import <Foundation/Foundation.h>
//#import "UserEntity.h"
#import <SystemConfiguration/CaptiveNetwork.h>

/**
 *  Handler处理成功时调用的Block
 */
typedef void (^SuccessBlock)(id obj);
/**
 *  Handler处理失败时调用的Block
 */
typedef void (^FailedBlock)(id obj);

@interface LoginHandler : NSObject

/**
 *  用户登录业务逻辑处理
 *
 *  @param user
 *  @param success
 *  @param failed  
 */
+ (void)executeUrl:(NSString *)urlStr success:(SuccessBlock)success failed:(FailedBlock)failed;
+ (void)executeUrl:(NSString *)urlStr data:(NSString *)dataStr success:(SuccessBlock)success failed:(FailedBlock)failed;
+ (NSString *)currentWifiSSID;

#pragma 正则匹配手机号
+ (BOOL)checkTelNumber:(NSString *) telNumber;
#pragma 正则匹配用户密码6-18位数字和字母组合
+ (BOOL)checkPassword:(NSString *) password;
#pragma 正则匹配用户姓名,20位的中文或英文
+ (BOOL)checkUserName : (NSString *) userName;
#pragma 正则匹配用户身份证号
+ (BOOL)checkUserIdCard: (NSString *) idCard;
#pragma 正则匹员工号,12位的数字
+ (BOOL)checkEmployeeNumber : (NSString *) number;
#pragma 正则匹配URL
+ (BOOL)checkURL : (NSString *) url;


@end
