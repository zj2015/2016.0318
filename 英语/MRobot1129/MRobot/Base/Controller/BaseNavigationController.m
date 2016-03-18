//
//  BaseNavigationController.m
//  BaseDemo
//
//  Created by 张娇娇 on 15/7/1.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@end

@implementation BaseNavigationController

#pragma mark  ---右滑返回出栈---
//
//-(id)initWithRootViewController:(UIViewController *)rootViewController
//{
//    BaseNavigationController* nvc = [super initWithRootViewController:rootViewController];
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
//        self.interactivePopGestureRecognizer.delegate = self;
//    }
//    nvc.delegate = self;
//    return nvc;
//}
//
//-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    if (navigationController.viewControllers.count == 1)
//        self.currentShowVC = nil;
//    else
//        self.currentShowVC = viewController;
//}
//
//-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
//{
//    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
//        return (self.currentShowVC == self.topViewController);
//    }
//    return YES;
//}

#pragma mark ---Nav-Color---
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Navgation's backgroundColor
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    if (iOS7) {
        return UIStatusBarStyleLightContent;
    }else
    {
        return UIStatusBarStyleDefault;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
