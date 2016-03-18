//
//  ErrorKnowledgeViewController.h
//  ERobot
//
//  Created by BaiYu on 15/7/1.
//  Copyright (c) 2015年 BaiYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIFolderTableView.h"

@interface ErrorKnowledgeViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,UIFolderTableViewDelegate,UITextViewDelegate>
{
    UITableView *errorTable;
    BOOL isClick;//单元格被点击
    NSInteger preHeaderIndex;//上一个被点击的区头
    NSMutableArray *openedInSectionArr;
}

@property (assign, nonatomic) NSInteger selectIndexRow;

@property (nonatomic,assign) int pageIndex;//分页页码

@end
