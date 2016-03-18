//
//  ExamOutlineViewController.h
//  MRobot
//
//  Created by mac on 15/9/7.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "BaseViewController.h"

@interface ExamOutlineViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

{
    BOOL isClick;//单元格被点击
    NSInteger selectRow;//当前点击的单元格
    NSMutableArray *openedInSectionArr;//存储0或1 如果是0 闭合  如果是1 展开
    
    NSArray *resultArr;
}

@property (strong, nonatomic) UITableView *myTableView;

@end
