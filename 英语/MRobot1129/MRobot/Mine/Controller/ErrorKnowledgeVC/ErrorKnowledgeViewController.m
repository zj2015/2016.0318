//
//  ErrorKnowledgeViewController.m
//  ERobot
//
//  Created by BaiYu on 15/7/1.
//  Copyright (c) 2015年 BaiYu. All rights reserved.
//

#import "ErrorKnowledgeViewController.h"
#import "ErrorKnowledgeHeadView.h"
#import "ErrorKnowledgeCell.h"

#import "AnalyticalKnowledgeViewController.h"
#import "ExerciseTrainViewController.h"

#import "ErrorTopicSetViewController.h"
#import "WrongKnowledgeListModel.h"
#import "WrongKnowledgeDataModel.h"

#import "MJRefresh.h"

@interface ErrorKnowledgeViewController ()<ErrorKnowledgeCellDelegate>
@property (strong, nonatomic) NSMutableArray *wrongDataArr;
@end

@implementation ErrorKnowledgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self base_changeNavigationTitleWithString:@"易错知识点"];
   
    errorTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MainScreenSize_W, MainScreenSize_H) style:UITableViewStylePlain];
    errorTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    errorTable.delegate = self;
    errorTable.dataSource = self;
    [self.view addSubview:errorTable];
    
    _pageIndex = 0;
    // 集成刷新控件
    [self setupRefresh];

    _wrongDataArr = [[NSMutableArray alloc]initWithCapacity:0];
    openedInSectionArr = [NSMutableArray array];
    preHeaderIndex = 0;
    [self loadData];
    
    
}

-(void)loadData
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //易错知识点
    LearningPlanRequest *request = [[LearningPlanRequest alloc]init];
    [request userWrongKnowledgeListWithPageIndex:[NSString stringWithFormat:@"%d",_pageIndex] andPageSize:@"10" success:^(id obj) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        InfoResult *infoResult = (InfoResult *)obj;
        if ([infoResult.code isEqualToString:@"0"]) {
            WrongKnowledgeListModel *wrongListModel = [[WrongKnowledgeListModel alloc] init];
            wrongListModel = (WrongKnowledgeListModel *)[infoResult extraObj];
            
            if (_pageIndex == 0) {
                if (_wrongDataArr != 0) {
                    [_wrongDataArr removeAllObjects];
                    [openedInSectionArr removeAllObjects];
                }
                
                for (int i = 0; i < wrongListModel.wrongListArr.count; i ++) {
                    WrongKnowledgeDataModel *wrongDataModel = [wrongListModel.wrongListArr objectAtIndex:i];
                    [_wrongDataArr addObject:wrongDataModel];
                    if (preHeaderIndex > wrongListModel.wrongListArr.count - 1) {
                        if (i == 0) {
                            [openedInSectionArr addObject:@"1"];
                        }else{
                            [openedInSectionArr addObject:@"0"];
                        }
                        preHeaderIndex = 0;
                    }else{
                        if (i == preHeaderIndex) {
                            [openedInSectionArr addObject:@"1"];
                        }else{
                            [openedInSectionArr addObject:@"0"];
                        }
                    }
                }
                
                _pageIndex ++;
            }else{
                for (WrongKnowledgeDataModel *wrongDataModel in wrongListModel.wrongListArr) {
                    [_wrongDataArr addObject:wrongDataModel];
                    [openedInSectionArr addObject:@"0"];
                }
                _pageIndex ++;
            }
            
//            openedInSectionArr = [NSMutableArray array];
//            for (int i=0; i< [_wrongDataArr count]; i++) {
//                if (i == 0) {
//                    [openedInSectionArr addObject:@"1"];
//                }else{
//                    [openedInSectionArr addObject:@"0"];
//                }
//            }
//            preHeaderIndex = 0;
            
        }
        
        [errorTable reloadData];
        
        
    } failed:^(id obj) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];

}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [errorTable addHeaderWithTarget:self action:@selector(headerRereshing)];
    
    //自动刷新(一进入程序就下拉刷新)
    //    [mineTable headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [errorTable addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    errorTable.headerPullToRefreshText = @"放开以刷新...";
    errorTable.headerReleaseToRefreshText = @"松开马上刷新了";
    errorTable.headerRefreshingText = @"正在刷新...";
    
    errorTable.footerPullToRefreshText = @"放开以刷新...";
    errorTable.footerReleaseToRefreshText = @"松开马上加载了";
    errorTable.footerRefreshingText = @"正在加载...";
}


#pragma mark- UITableViewDataSourcer

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _wrongDataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([[openedInSectionArr objectAtIndex:section] intValue] == 1) {
        return 1;
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"ErrorKnowledgeCell";
    
    ErrorKnowledgeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[ErrorKnowledgeCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.delegate = self;
    return cell;
}

#pragma mark- UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ErrorKnowledgeHeadView *headView = [ErrorKnowledgeHeadView headViewWithTableView:tableView withBlock:^(NSInteger tag) {
        if ([[openedInSectionArr objectAtIndex:tag] intValue] == 0) {
            [openedInSectionArr replaceObjectAtIndex:preHeaderIndex withObject:@"0"];//将上一个被点击的区置为闭合状态
            [openedInSectionArr replaceObjectAtIndex:tag withObject:@"1"];
            
            preHeaderIndex = tag;
            _selectIndexRow = section;
        }
        else
        {
            [openedInSectionArr replaceObjectAtIndex:tag withObject:@"0"];
        }
        [errorTable reloadData];
    }];
    headView.contentView.tag = section;
    WrongKnowledgeDataModel *wrongDataModel = [[WrongKnowledgeDataModel alloc] init];
    if ([_wrongDataArr count] != 0) {
        wrongDataModel = [_wrongDataArr objectAtIndex:section];
    }
    headView.knowledgeLab.text = wrongDataModel.kName;
    headView.errorLab.text = [NSString stringWithFormat:@"%@",wrongDataModel.wrongPercent];
    
    if ([[openedInSectionArr objectAtIndex:section] intValue] == 1){
        headView.signImgView.image = [UIImage imageNamed:@"show-1"];
        headView.errorPercentLab.textColor = PView_RedColor;
        headView.knowledgeLab.textColor = PView_RedColor;
    }else{
        headView.signImgView.image = [UIImage imageNamed:@"hide"];
        headView.errorPercentLab.textColor = [UIColor blackColor];
        headView.knowledgeLab.textColor = [UIColor blackColor];
    }
    
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44*SIZE_TIMES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ROWHEIGHT*SIZE_TIMES;
}

#pragma mark - 展开view上的btn点击事件  ErrorKnowledgeCellDelegate
-(void)errorKnowledgeCellChooseBtn:(NSInteger)btnTag
{
    
    [[SoundTools sharedSoundTools] playSoundWithName:@"ui_click_in"];

    
    WrongKnowledgeDataModel *dataModel = _wrongDataArr[_selectIndexRow];
    
    if (btnTag == 0)
    {
        //知识点解析
        AnalyticalKnowledgeViewController *analyticalVC = [[AnalyticalKnowledgeViewController alloc] init];
        analyticalVC.fromType = 1;
//        analyticalVC.mainPage = 1;
        analyticalVC.kId = dataModel.kId;
        analyticalVC.kName = dataModel.kName;
        analyticalVC.kContent = dataModel.kContent;
        analyticalVC.weekId = dataModel.kId;
        [self.navigationController pushViewController:analyticalVC animated:YES];
    }
    else if (btnTag == 1)
    {
        //我的错题集
        ErrorTopicSetViewController *topicSetVC = [[ErrorTopicSetViewController alloc]init];
        topicSetVC.kId = dataModel.kId;
        topicSetVC.errorType = 1;
        [self.navigationController pushViewController:topicSetVC animated:YES];
    }
    else if (btnTag == 2)
    {
        //重新训练
        ExerciseTrainViewController *trainExerciseVC = [[ExerciseTrainViewController alloc]init];
        trainExerciseVC.setType = 3;
        trainExerciseVC.kId = dataModel.kId;
        trainExerciseVC.fromType = 1;
        [UserDefaultsUtils saveValue:dataModel.kName forKey:KNOWLEDGENAME];
//        trainExerciseVC.unitName =  dataModel.kName;
        [self.navigationController pushViewController:trainExerciseVC animated:YES];
    }
    else{
        
    }
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    _pageIndex = 0;
    
    [self loadData];
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [errorTable reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [errorTable headerEndRefreshing];
    });
}

- (void)footerRereshing
{
    [self loadData];
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [errorTable reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [errorTable footerEndRefreshing];
    });
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
