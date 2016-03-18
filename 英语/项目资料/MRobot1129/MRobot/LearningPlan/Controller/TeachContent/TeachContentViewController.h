//
//  TeachContentViewController.h
//  ERobot
//
//  Created by BaiYu on 15/6/30.
//  Copyright (c) 2015年 BaiYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TeachContentDataModel.h"

@interface TeachContentViewController :BaseViewController <UITableViewDataSource,UITableViewDelegate>
{
    UITableView *teachContentTable;
    NSMutableArray * contentLeftArr;//The course credits左边字段数组
    NSMutableArray * contentArr;//The course credits
}
//@property (strong, nonatomic) NSMutableArray * contentLeftArr;
//@property (strong, nonatomic) NSMutableArray * contentArr;
@property (strong, nonatomic) NSString *weekId;//周Id
@property (strong, nonatomic) NSString *classCatagory;//班类
@property (assign, nonatomic) NSInteger cType;//教学类型
@end
