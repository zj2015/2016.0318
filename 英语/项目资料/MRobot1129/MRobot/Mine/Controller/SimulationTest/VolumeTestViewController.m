//
//  VolumeTestViewController.m
//  MRobot
//
//  Created by mac on 15/9/8.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "VolumeTestViewController.h"
#import "VolumeTestTableViewCell.h"
#import "ExamTestViewController.h"

#import "SimulationPaperModel.h"
#import "SimulationListModel.h"

#import "MJRefresh.h"

@interface VolumeTestViewController ()

@end

@implementation VolumeTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self base_changeNavigationTitleWithString:@"模拟考试"];
    [self base_ExtendedLayout];
    _pageIndex = 0;
    _simulationArr = [[NSMutableArray alloc]initWithCapacity:0];
    // 集成刷新控件
    [self setupRefresh];
    [self prepareData];
}

- (void)prepareData
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    LearningPlanRequest *request = [[LearningPlanRequest alloc]init];
    [request userSimulationPaperListWithPageIndex:[NSString stringWithFormat:@"%d",_pageIndex] andPageSize:@"10" success:^(id obj) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        InfoResult *infoResult = (InfoResult *)obj;
        if ([infoResult.code isEqualToString:@"0"]) {
            SimulationPaperModel *paperModel = [[SimulationPaperModel alloc]init];
            paperModel = (SimulationPaperModel *)[infoResult extraObj];
            
            if (_pageIndex == 0) {
                if (_simulationArr != 0) {
                    [_simulationArr removeAllObjects];
                }
                for (SimulationListModel *listModel in paperModel.simulationPaperList) {
                    [_simulationArr addObject:listModel];
                }
                _pageIndex ++;
            }else{
                for (SimulationListModel *listModel in paperModel.simulationPaperList) {
                    [_simulationArr addObject:listModel];
                }
                _pageIndex ++;
            }
            
            if (_simulationArr.count == 0) {
                [aCommon iToast:@"还没有试卷内容哦~"];
            }
        }
        
        [_myTableView reloadData];
        
    } failed:^(id obj) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (void)_prepareUI
{
    CGRect rect = CGRectMake(MainSreenOrigin_X,MainSreenOrigin_Y,MainScreenSize_W,MainScreenSize_H);
    _myTableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.rowHeight = VolumeCellHeight+10;
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_myTableView];
    
    // 改变 tableView的背景色
    _myTableView.backgroundView = [aCommon tableViewsBackGroundView];
    
    //去掉多余的分割线
    _myTableView.tableFooterView = [aCommon tableViewsFooterView];
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [_myTableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    
    //自动刷新(一进入程序就下拉刷新)
//        [_myTableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [_myTableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    _myTableView.headerPullToRefreshText = @"放开以刷新...";
    _myTableView.headerReleaseToRefreshText = @"松开马上刷新了";
    _myTableView.headerRefreshingText = @"正在刷新...";
    
    _myTableView.footerPullToRefreshText = @"放开以刷新...";
    _myTableView.footerReleaseToRefreshText = @"松开马上加载了";
    _myTableView.footerRefreshingText = @"正在加载...";
}


#pragma mark ------
#pragma mark ---UITableViewDataSource---

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _simulationArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"identifier";
    VolumeTestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[VolumeTestTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;//取消选中
    }
    SimulationListModel *listModel = _simulationArr[indexPath.row];
    cell.leftLabel.text = listModel.paperName;
    if ([listModel.thisWeek isEqualToString:@"1"]) {
        cell.bgView.backgroundColor = RgbColor(30, 143, 109);
        cell.leftLabel.textColor = [UIColor whiteColor];
        cell.rightImageView.image = [UIImage imageNamed:@"select-mine"];
    }else{
        cell.bgView.backgroundColor = [UIColor whiteColor];
        cell.leftLabel.textColor = [UIColor blackColor];
        cell.rightImageView.image = [UIImage imageNamed:@"default-mine"];
    }
    return cell;
}

#pragma mark ------
#pragma mark ---UITableViewDelegate---

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [[SoundTools sharedSoundTools] playSoundWithName:@"ui_click_in"];

    
    SimulationListModel *listModel = _simulationArr[indexPath.row];
    ExamTestViewController *examTestVC = [[ExamTestViewController alloc]init];
    examTestVC.paperId = listModel.paperId;
    examTestVC.submitTitle = listModel.paperName;
    [self.navigationController pushViewController:examTestVC animated:YES];

}


#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    _pageIndex = 0;
    
    [self prepareData];
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [_myTableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [_myTableView headerEndRefreshing];
    });
}

- (void)footerRereshing
{
    [self prepareData];
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [_myTableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [_myTableView footerEndRefreshing];
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
