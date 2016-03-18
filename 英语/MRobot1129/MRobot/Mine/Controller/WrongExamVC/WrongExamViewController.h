//
//  WrongExamViewController.h
//  ERobot
//
//  Created by BaiYu on 15/7/1.
//  Copyright (c) 2015年 BaiYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WrongExamViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * wrongExamTableView;
    BOOL isShowMore;
    NSInteger moreBtnTag;
    NSInteger headerBtnTag;
    
    NSArray * sectionArr;//(区头信息)
    NSMutableArray *openedInSectionArr;//存储0或1 如果是0 闭合  如果是1 展开
    
    NSInteger pageIndex;
}

@property (nonatomic,strong)NSArray * dataArr;
@property (nonatomic,strong)NSMutableArray * moreDataArr;
@end
