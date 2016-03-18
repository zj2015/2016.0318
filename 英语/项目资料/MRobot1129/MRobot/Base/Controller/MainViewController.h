//
//  MainViewController.h
//  BaseDemo
//
//  Created by 张娇娇 on 15/7/22.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ItemView.h"
@interface MainViewController : UITabBarController<ItemViewDelegate>
{
@private
    UIImageView *_tabBarBG;//背景
    UIImageView *_selectView;//选择图片效果
}
@property (strong, nonatomic) NSMutableArray *itemArr;

@property (assign, nonatomic) BOOL isAutoLogin;//自动登录 YES

- (void)showOrHiddenTabBarView:(BOOL)isHidden;
@end
