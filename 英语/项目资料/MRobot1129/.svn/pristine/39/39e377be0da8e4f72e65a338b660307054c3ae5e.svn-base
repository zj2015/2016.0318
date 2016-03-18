//
//  LoginHandler.m
//  RTLibrary-ios
//
//  Created by Ryan on 14-8-3.
//  Copyright (c) 2014年 zlycare. All rights reserved.
//

#import "LoginHandler.h"
#import "RTHttpClient.h"
#import "AppUtils.h"
#import "UserDefaultsUtils.h"


@interface LoginHandler () {
    
}

@end
@implementation LoginHandler



+ (void)executeUrl:(NSString *)urlStr success:(SuccessBlock)success failed:(FailedBlock)failed
{
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    PLog(@"url==%@",url);
    //创建请求
    NSMutableURLRequest  *request=[NSMutableURLRequest requestWithURL:url];//默认为get请求
    //设置最大的网络等待时间
    request.timeoutInterval=20.0;
    //获取主队列
    NSOperationQueue *queue=[NSOperationQueue mainQueue];
    //发起请求 海飞丝
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        //DLog(@"response== %@，data == %@,connectionError==%@",response,data,connectionError);
        if (data) {//如果请求成功，拿到服务器返回的数据
            //解析XML数据
            NSDictionary *dict = [aCommon parseJsonDataXmls:data];
            if (success) {
                success(dict);
            }
            
        }else//如果请求失败，没有拿到数据
        {
            if (failed) {
                failed(connectionError);
            }
        }
    }];
}

+ (void)executeUrl:(NSString *)urlStr data:(NSString *)dataStr success:(SuccessBlock)success failed:(FailedBlock)failed
{
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    PLog(@"url==%@",url);
    //创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET

    NSString *str = dataStr;//设置参数
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    //获取主队列
    NSOperationQueue *queue=[NSOperationQueue mainQueue];

    //发起请求
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        //DLog(@"response== %@，data == %@,connectionError==%@",response,data,connectionError);
        if (data) {//如果请求成功，拿到服务器返回的数据
            //解析XML数据
            NSDictionary *dict = [aCommon parseJsonDataXmls:data];
            if (success) {
                success(dict);
            }
            
        }else//如果请求失败，没有拿到数据
        {
            if (failed) {
                failed(connectionError);
            }
        }
    }];
}


//获取路由器／ 也就是wifi的mac 地址
+ (NSString *)currentWifiSSID {
    // Does not work on the simulator.
//    NSString *ssid = nil;
//    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
//    for (NSString *ifnam in ifs) {
//        NSDictionary *info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
//        DLog(@"%@ => %@", ifnam, info);
//        if (info[@"BSSID"]) {
////            ssid = info[@"BSSID"];
//            ssid = [info objectForKey:(NSString*)kCNNetworkInfoKeyBSSID];
//        }
//    }
//    DLog(@"ssid is-----------> %@",ssid);
//    return ssid;
    NSString *ssid = nil;
    NSArray *wifiArr = CFBridgingRelease(CNCopySupportedInterfaces());
    id info = nil;
    for (NSString *ifnam in wifiArr) {
        info = CFBridgingRelease(CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam));
        ssid = [info objectForKey:(NSString*)kCNNetworkInfoKeyBSSID];
        
    }
    NSArray *arr = [ssid componentsSeparatedByString:@":"];
    PLog(@"arr == %@",arr);
    NSMutableArray *newArr = [[NSMutableArray alloc]initWithCapacity:10];
    for (int i = 0; i < [arr count]; i++) {
        [newArr addObject:@""];
    }
    [arr enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
        if (obj.length == 2) {
            [newArr replaceObjectAtIndex:idx withObject:obj];
        }else
        {
            NSString *str1 = [NSString stringWithFormat:@"0%@",obj];
            [newArr replaceObjectAtIndex:idx withObject:str1];
        }
    }];
    PLog(@"newArr == %@",newArr);
    NSString *ssidStr = [newArr componentsJoinedByString:@":"];
    ssid = [ssidStr stringByReplacingOccurrencesOfString:@":" withString:@""];
    PLog(@"ssid is-----------> %@",ssid);
    return ssid;
    
}

#pragma 正则匹配手机号
+ (BOOL)checkTelNumber:(NSString *) telNumber
{
    NSString *pattern = @"^1+[34578]+\\d{9}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:telNumber];
    return isMatch;
}

#pragma 正则匹配用户密码6-18位数字和字母组合
+ (BOOL)checkPassword:(NSString *) password
{
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
    
}

#pragma 正则匹配用户姓名,20位的中文或英文
+ (BOOL)checkUserName : (NSString *) userName
{
    NSString *pattern = @"^[a-zA-Z一-龥]{1,20}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:userName];
    return isMatch;
    
}


#pragma 正则匹配用户身份证号15或18位
+ (BOOL)checkUserIdCard: (NSString *) idCard
{
    NSString *pattern = @"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:idCard];
    return isMatch;
}

#pragma 正则匹员工号,12位的数字
+ (BOOL)checkEmployeeNumber : (NSString *) number
{
    NSString *pattern = @"^[0-9]{12}";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:number];
    return isMatch;
    
}

#pragma 正则匹配URL
+ (BOOL)checkURL : (NSString *) url
{
    NSString *pattern = @"^[0-9A-Za-z]{1,50}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:url];
    return isMatch;
    
}

@end
