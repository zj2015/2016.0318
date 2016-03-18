//
//  WrongTitleViewController.h
//  ERobot
//
//  Created by BaiYu on 15/7/6.
//  Copyright (c) 2015年 BaiYu. All rights reserved.
//

#import "BaseViewController.h"
#import "WrongExamViewController.h"

@interface WrongTitleViewController : UIViewController
{
    
}
@property (strong, nonatomic) WrongExamViewController *wrongExamVC;
@property (strong, nonatomic) UIView *bgView;
@property (strong, nonatomic) NSString *dateStr;
@property (strong, nonatomic) NSArray *dataArr;
@end
