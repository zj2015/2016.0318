//
//  TrainResultViewController.h
//  MRobot
//
//  Created by mac on 15/8/22.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "BaseViewController.h"
#import "SubmitListModel.h"
#import "SubmitByWeekModel.h"
#import "ResultListModel.h"
#import "QuestionDataModel.h"
#import "UIFolderTableView.h"

@interface TrainResultViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIFolderTableViewDelegate>
{
    NSIndexPath *currentIndexPath;
    BOOL isClick;//单元格被点击
    NSInteger selectRow;//当前点击的单元格
}
@property (strong, nonatomic) SubmitByWeekModel *weekModel;
@property (strong, nonatomic) QuestionDataModel *questionModel;

@property(nonatomic,strong)UIFolderTableView *myTableView;
@property (strong, nonatomic) NSArray *arr;
@property (strong, nonatomic) NSArray *arrRight;
@property (copy, nonatomic) NSString *weekId;
@property (copy, nonatomic) NSString *unitName;

@property (strong, nonatomic) NSArray *badArray;

@property (strong, nonatomic) NSArray *answerArray;
@property (strong, nonatomic) NSMutableArray *answerArr;// 0 没写， 1正确   2错误

@end
