//
//  AppDelegate.m
//  MRobot
//
//  Created by mac on 15/8/19.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "AppDelegate.h"
//#import "LoginViewController.h"
#import "BaseNavigationController.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaSSOHandler.h"

#import "MainViewController.h"
#import "InfoResult.h"
#import "UserLoginModel.h"
#import "ChooseIdentityViewController.h"

#import <SMS_SDK/SMS_SDK.h>
#define appKeyMes @"58684c569a0e"
#define appSecretMes @"08ae8e126fb1d0fba8b4acdad889c840"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //设置友盟社会化组件appkey
    [UMSocialData setAppKey:UmengAppkey];
    
    //打开调试log的开关
    [UMSocialData openLog:YES];
    
    //如果你要支持不同的屏幕方向，需要这样设置，否则在iPhone只支持一个竖屏方向
    [UMSocialConfig setSupportedInterfaceOrientations:UIInterfaceOrientationMaskLandscapeRight];
    
    //由于苹果审核政策需求，建议大家对未安装客户端平台进行隐藏，在设置QQ、微信AppID之后调用下面的方法
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline]];
    
    //设置微信AppId，设置分享url，默认使用友盟的网址
    [UMSocialWechatHandler setWXAppId:@"wxb336dd0a1af2d97c" appSecret:@"a95cc1eed190b7af9828bff1f6900586" url:@"http://www.cc-english.com"];
    
    //设置分享到QQ空间的应用Id，和分享url 链接
    [UMSocialQQHandler setQQWithAppId:@"101105930" appKey:@"b589241d988d151e04619d98916f5531" url:@"http://www.cc-english.com"];
    
    [SMS_SDK registerApp:appKeyMes withSecret:appSecretMes];
    
//    if (![UserDefaultsUtils boolValueWithKey:WHETHERTHECANCELLATION]) {
//        if ([UserDefaultsUtils valueWithKey:MYNAME]&&[UserDefaultsUtils valueWithKey:MYPHONE]&&[UserDefaultsUtils valueWithKey:MYPASSWORD]) {
//            
//            MainViewController *mainViewController = [[MainViewController alloc]init];
//            [UserDefaultsUtils saveBoolValue:NO withKey:WHETHERTHECANCELLATION];
//            mainViewController.isAutoLogin = YES;
//            self.window.rootViewController = mainViewController;
//            
//        }else{
//            BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:[[LoginViewController alloc]init]];
//            self.window.rootViewController = nav;
//        }
//        
//    }else{
//        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:[[LoginViewController alloc]init]];
//        self.window.rootViewController = nav;
//    }
//    
    
    if (![UserDefaultsUtils boolValueWithKey:WHETHERTHECANCELLATION]) {
        NSString *myName = nil;
        NSString *myPhone = nil;
        NSString *myPassword = nil;
        if ([UserDefaultsUtils boolValueWithKey:ISINNER]) {
            myName = [UserDefaultsUtils valueWithKey:INNER_MYNAME];
            myPhone = [UserDefaultsUtils valueWithKey:INNER_MYPHONE];
            myPassword = [UserDefaultsUtils valueWithKey:INNER_MYPASSWORD];
        }else{
            myName = [UserDefaultsUtils valueWithKey:OUT_MYNAME];
            myPhone = [UserDefaultsUtils valueWithKey:OUT_MYPHONE];
            myPassword = [UserDefaultsUtils valueWithKey:OUT_MYPASSWORD];
        }
        if (myName && myPhone && myPassword) {
            MainViewController *mainViewController = [[MainViewController alloc]init];
            [UserDefaultsUtils saveBoolValue:NO withKey:WHETHERTHECANCELLATION];
            mainViewController.isAutoLogin = YES;
            self.window.rootViewController = mainViewController;
        }else{
            BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:[[ChooseIdentityViewController alloc]init]];
            self.window.rootViewController = nav;
        }
    }else{
        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:[[ChooseIdentityViewController alloc]init]];
        self.window.rootViewController = nav;
    }
    
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}

/**
 这里处理新浪微博SSO授权之后跳转回来，和微信分享完成之后跳转回来
 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
}

/**
 这里处理新浪微博SSO授权进入新浪微博客户端后进入后台，再返回原来应用
 */
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [UMSocialSnsService  applicationDidBecomeActive];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    [[SoundTools sharedSoundTools] playSoundWithName:@"ui_new"];
}
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [[SoundTools sharedSoundTools] playSoundWithName:@"ui_new"];

}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
