//
//  KnowledgeSelectViewController.m
//  MRobot
//
//  Created by BaiYu on 15/9/9.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "KnowledgeSelectViewController.h"
#import "KSelectTableViewCell.h"
#import "KnowledgeTableViewCell.h"

#import "ChildKnowledgeTableViewCell.h"
#import "ChildLevelKnowModel.h"
#import "ChildLevelListModel.h"
#import "TopLevelKnowModel.h"
#import "TopLevelListModel.h"
#import "AnalyticalKnowledgeViewController.h"
#import "ExerciseTrainViewController.h"

#import "MainViewController.h"
#import "ArrowView.h"

#define Child_BgView_Color     RgbColor(174, 159, 110)
@interface KnowledgeSelectViewController ()

@end

@implementation KnowledgeSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self base_ExtendedLayout];
    [self base_changeNavigationTitleWithString:@"知识点选择"];
    openedInSectionArr = [NSMutableArray array];
    self.selectRow = -1;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    MainViewController *mainVC = (MainViewController *)self.tabBarController;
    [mainVC showOrHiddenTabBarView:NO];
    
}

- (void)_prepareData
{
    LearningPlanRequest *levelKRequest = [[LearningPlanRequest alloc] init];
    [levelKRequest userTopLevelKnowledgeSuccess:^(id obj) {
        InfoResult *infoResult = (InfoResult *)obj;
        if ([infoResult.code isEqualToString:@"0"]) {
            TopLevelKnowModel *topLevelKModel = [[TopLevelKnowModel alloc]init];
            topLevelKModel = (TopLevelKnowModel *)[infoResult extraObj];
            kDataArr = topLevelKModel.resultArray;
            
            _kNameArr = [[NSMutableArray alloc]initWithCapacity:0];
            for (int i = 0; i < [kDataArr count]; i++) {
                TopLevelListModel *topLevelModel = [kDataArr objectAtIndex:i];
                [_kNameArr addObject:topLevelModel.kName];
            }
            
            [kTableView reloadData];
        
//            TopLevelListModel *topLevelModel = [kDataArr objectAtIndex:0];
//            [self reloadChildKId:topLevelModel.kId];
        }else{
            [aCommon iToast:@"加载失败!"];
        }
    } failed:^(id obj) {
        [aCommon iToast:@"系统未知错误!"];
    }];
}

- (void)_prepareUI
{
    CGRect rect = CGRectMake(MainSreenOrigin_X,MainSreenOrigin_Y,MainScreenSize_W,MainScreenSize_H);
    kTableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    kTableView.tag = 0;
    kTableView.delegate = self;
    kTableView.dataSource = self;
    kTableView.rowHeight = 40 *SIZE_TIMES;
    [self.view addSubview:kTableView];
    
    // 改变 tableView的背景色
    kTableView.backgroundView = [aCommon tableViewsBackImageView];
    
    //去掉多余的分割线
    kTableView.tableFooterView = [aCommon tableViewsFooterView];
    
    bgView = [[UIView alloc] initWithFrame:CGRectMake(MainScreenSize_W, 64, MainScreenSize_W - 100, MainScreenSize_H)];
    bgView.backgroundColor = Child_BgView_Color;
    [self.view addSubview:bgView];
    
//    子表
    childTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MainScreenSize_W - 100, bgView.frame.size.height) style:UITableViewStylePlain];
    childTableView.tag = 1;
    childTableView.delegate = self;
    childTableView.dataSource = self;
    childTableView.rowHeight = 40 *SIZE_TIMES;
    childTableView.backgroundColor = [UIColor clearColor];
    [bgView addSubview:childTableView];
    
    selectChildRow = -1;//int类型的变量默认值为0，所以手动设置它的默认值

    //去掉多余的分割线
    childTableView.tableFooterView = [aCommon tableViewsFooterView];
    
    UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0.5, bgView.frame.size.height)];
    lineLab.backgroundColor = [UIColor lightGrayColor];
    [bgView addSubview:lineLab];

}

-(void)creatTableHeader:(NSString *)tableHeaderTitle
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenSize_W - 100, 40*SIZE_TIMES)];
    headerView.backgroundColor = Child_BgView_Color;
    
    UIButton *clickBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    clickBtn.frame = CGRectMake(0, 0, MainScreenSize_W - 100, 40*SIZE_TIMES);
    if (childTableView.tag == 2) {
        clickBtn.tag = 2;
    }else if (childTableView.tag == 3) {
        clickBtn.tag = 3;
    }
    [clickBtn addTarget:self action:@selector(backPreTable:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:clickBtn];
    
//    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 11*SIZE_TIMES, 18*SIZE_TIMES, 18*SIZE_TIMES)];
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 11*SIZE_TIMES, 24/2, 41/2)];
    imageView.image = [UIImage imageNamed:@"back"];
    [headerView addSubview:imageView];
    
    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, MainScreenSize_W - 120, 40*SIZE_TIMES - 10)];
    nameLab.textColor = [UIColor whiteColor];
    nameLab.font = [UIFont systemFontOfSize:15.0];
    nameLab.text = [NSString stringWithFormat:@"      %@",tableHeaderTitle];
    [headerView addSubview:nameLab];
    
    if(childTableView.tag != 3){
        UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 40*SIZE_TIMES-0.5, MainScreenSize_W - 100, 0.5)];
        lineLab.backgroundColor = [UIColor lightGrayColor];
        [headerView addSubview:lineLab];
    }
    childTableView.tableHeaderView = headerView;
}

-(void)creatTableHeaderOne
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenSize_W - 100, 0*SIZE_TIMES)];
    headerView.backgroundColor = Child_BgView_Color;

    childTableView.tableHeaderView = headerView;
}

#pragma mark - 加载子表数据
- (void)reloadChildKId:(NSString *)knowledgeId
{
    LearningPlanRequest *childKRequest = [[LearningPlanRequest alloc] init];
    [childKRequest userChildLevelKnowledgeWithKId:knowledgeId success:^(id obj) {
        InfoResult *infoResult = (InfoResult *)obj;
        if ([infoResult.code isEqualToString:@"0"]) {
            ChildLevelKnowModel *topLevelKModel = [[ChildLevelKnowModel alloc]init];
            topLevelKModel = (ChildLevelKnowModel *)[infoResult extraObj];
            
            if (childTableView.tag == 1) {
                firChildArr = topLevelKModel.resultArray;
            }else if (childTableView.tag == 2){
                secChildArr = topLevelKModel.resultArray;
            }else if (childTableView.tag == 3){
                thirdChildArr = topLevelKModel.resultArray;
                
                if (openedInSectionArr.count != 0) {
                    [openedInSectionArr removeAllObjects];
                }
                for (int i=0; i< [thirdChildArr count]; i++) {
                    [openedInSectionArr addObject:@"0"];
                }
            }
            [childTableView reloadData];
        }else{
            [aCommon iToast:@"加载失败!"];
        }
    } failed:^(id obj) {
        [aCommon iToast:@"系统未知错误!"];
    }];
}

#pragma mark ------
#pragma mark ---UITableViewDataSource---
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag == 3) {
        kTableView.backgroundView = [aCommon tableViewsBackGroundView];
        return [thirdChildArr count];
    }else{
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 0) {
        
            
            return [self.kNameArr count];
        
    }else if (tableView.tag == 1) {
        return [firChildArr count];
    }else if (tableView.tag == 2) {
        return [secChildArr count];
    }else if (tableView.tag == 3) {
        if ([[openedInSectionArr objectAtIndex:section] intValue] == 1) {
            return 1;
        }else{
            return 0;
        }
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (childTableView.tag == 3) {
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenSize_W - 100, 40*SIZE_TIMES)];
        
        UIButton *headerBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        headerBtn.frame = CGRectMake(0, 0, MainScreenSize_W - 100, 40*SIZE_TIMES);
        headerBtn.tag = section;
        [headerBtn addTarget:self action:@selector(headerClick:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:headerBtn];
        
        ChildLevelListModel *childLevelModel = [thirdChildArr objectAtIndex:section];
        UILabel *thirdKLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, MainScreenSize_W - 130, 40*SIZE_TIMES)];
        thirdKLab.font = [UIFont systemFontOfSize:15.0];
        thirdKLab.text = childLevelModel.kName;
        thirdKLab.textColor = [UIColor whiteColor];
        [headerView addSubview:thirdKLab];
        
        UIImageView *signImgView = [[UIImageView alloc] initWithFrame:CGRectMake(MainScreenSize_W - 130, 12*SIZE_TIMES, 15*SIZE_TIMES, 15*SIZE_TIMES)];
        signImgView.image = [UIImage imageNamed:@"hide"];
        [headerView addSubview:signImgView];
        
        if ([[openedInSectionArr objectAtIndex:section] intValue] == 1) {
            signImgView.image = [UIImage imageNamed:@"show"];
        }else{
            signImgView.image = [UIImage imageNamed:@"hide"];
        }
        
        UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 40*SIZE_TIMES-0.5, MainScreenSize_W - 100, 0.5)];
        lineLab.backgroundColor = [UIColor lightGrayColor];
        [headerView addSubview:lineLab];
        
        if (section == 0) {
            ArrowView *arrow = [[ArrowView alloc]initWithFrame:CGRectMake(0, 0, headerView.frame.size.width, 10)];
            [headerView addSubview:arrow];
        }
        
        
        
        return headerView;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 0) {
        NSString *identifier = @"KSelectTableViewCell";
        
        KnowledgeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[KnowledgeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;//取消选中
        }
        if (indexPath.row == self.selectRow) {
            cell.knowledgeNameLab.textColor = [UIColor whiteColor];
            cell.signImgView.image = [UIImage imageNamed:@"arrowRight"];
            cell.contentView.backgroundColor =  Child_BgView_Color;
        }else{
            cell.knowledgeNameLab.textColor = RgbColor(147, 147, 147);
            cell.signImgView.image = [UIImage imageNamed:@"grayHide"];
            cell.contentView.backgroundColor = RgbColor(217,217,217);
        }
        cell.knowledgeNameLab.text = [NSString stringWithFormat:@"  %@",self.kNameArr[indexPath.row]];
        return cell;
    }else if (tableView.tag == 1 || tableView.tag == 2) {
        NSString *identifier = @"ChildKnowledgeTableViewCell";
        
        ChildKnowledgeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[ChildKnowledgeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;//取消选中
        }
        
        if (tableView.tag == 1) {
            if (indexPath.row == selectChildRow) {
                cell.kChildLab.textColor = RgbColor(0, 179, 138);
            }else{
                cell.kChildLab.textColor = [UIColor whiteColor];
            }
            ChildLevelListModel *childLevelModel = [firChildArr objectAtIndex:indexPath.row];
            cell.kChildLab.text = [NSString stringWithFormat:@"  %@",childLevelModel.kName];
        }else{
            if (indexPath.row == selectSecChildRow) {
                cell.kChildLab.textColor = RgbColor(0, 179, 138);
            }else{
                cell.kChildLab.textColor = [UIColor whiteColor];
            }
            ChildLevelListModel *childLevelModel = [secChildArr objectAtIndex:indexPath.row];
            cell.kChildLab.text = [NSString stringWithFormat:@"  %@",childLevelModel.kName];
        }
        
        return cell;
        
    }else if (tableView.tag == 3) {
        NSString *identifier = @"ThirdChildKTableViewCell";
        
        [[SoundTools sharedSoundTools] playSoundWithName:@"ui_on"];

        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;//取消选中
        }
        
        ThirdChildView *thirdChildView = [[ThirdChildView alloc] initWithFrame:CGRectMake(0, 0, MainScreenSize_W - 100, 85*SIZE_TIMES) clickIndex:indexPath.section];
        thirdChildView.delegate = self;
        [cell.contentView addSubview:thirdChildView];
        return cell;
    }
    return nil;
}

#pragma mark ------
#pragma mark ---UITableViewDelegate---
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 3) {
        return 85 * SIZE_TIMES;
    }else{
        return 40 * SIZE_TIMES;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 3) {
        return 40 * SIZE_TIMES;
    }else{
        return 0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [[SoundTools sharedSoundTools] playSoundWithName:@"ui_click_in"];

    if (tableView.tag == 0) {
        
        [self base_createLeftNavigationBarButtonWithFrontImage:nil andSelectedImageName:nil andBackGroundImageName:@"back" andTitle:nil andSize:CGSizeMake(24/2, 41/2)];
        kTableView.backgroundView =  [aCommon tableViewsBackGroundView];
        
        selectIndexPath = indexPath;
        self.selIndexPath = indexPath;
        self.selectRow = indexPath.row;
        [kTableView reloadData];
        
        childTableView.tag = 1;
        selectChildRow = -1;//第一次显示tag=1的表，单元格内字体要全为黑色
        TopLevelListModel *topLevelModel = [kDataArr objectAtIndex:indexPath.row];
        [self creatTableHeaderOne];
        childTableView.frame = CGRectMake(0, 0, MainScreenSize_W - 100, MainScreenSize_H - 64 + 40*SIZE_TIMES);
        [self reloadChildKId:topLevelModel.kId];
        
        [childTableView reloadData];
        
        [UIView animateWithDuration:0.2 animations:^{
            bgView.frame = CGRectMake(100, 64, MainScreenSize_W - 100, MainScreenSize_H);
        }];
        
        
    }else if (tableView.tag == 1) {
        selectChildRow = indexPath.row;
        childTableView.tag = 2;
        selectSecChildRow = -1;//第一次显示tag=2的表，单元格内字体要全为黑色
        
        ChildLevelListModel *childLevelModel = [firChildArr objectAtIndex:indexPath.row];
        [self creatTableHeader:childLevelModel.kName];
        lastHead = childLevelModel.kName;
        childTableView.frame = CGRectMake(0, 0, MainScreenSize_W - 100, MainScreenSize_H- 64);
        [self reloadChildKId:childLevelModel.kId];
        
    }else if (tableView.tag == 2) {
        selectSecChildRow = indexPath.row;
        childTableView.tag = 3;
        
        ChildLevelListModel *childLevelModel = [secChildArr objectAtIndex:indexPath.row];
        [self creatTableHeader:childLevelModel.kName];
        childTableView.frame = CGRectMake(0, 0, MainScreenSize_W - 100, MainScreenSize_H- 64);
        [self reloadChildKId:childLevelModel.kId];
        
    }else if (tableView.tag == 3){
        
    }
}

- (void)headerClick:(UIButton *)btn
{
    if ([[openedInSectionArr objectAtIndex:btn.tag] intValue] == 0) {
        [openedInSectionArr replaceObjectAtIndex:btn.tag withObject:@"1"];
    }
    else
    {
        [openedInSectionArr replaceObjectAtIndex:btn.tag withObject:@"0"];
    }
    childTableView.tag = 3;
    [childTableView reloadData];
}


#pragma mark - 返回上一层表
- (void)backPreTable:(UIButton *)btn
{
    
    [[SoundTools sharedSoundTools] playSoundWithName:@"ui_click_out"];

    if (btn.tag == 2) {
        childTableView.tag = 1;
        childTableView.frame = CGRectMake(0, 0*SIZE_TIMES, MainScreenSize_W - 100, MainScreenSize_H - 64 + 40*SIZE_TIMES);
        [self creatTableHeaderOne];
        [childTableView reloadData];
        
    }else if (btn.tag == 3){
        childTableView.tag = 2;
        btn.tag = 2;
        [self creatTableHeader:lastHead];
        [childTableView reloadData];
    }
}

#pragma mark- 子表TableHeader上的返回按钮点击事件
-(void)base_navigation_LeftBarButtonPressed
{
    
    [[SoundTools sharedSoundTools] playSoundWithName:@"ui_click_out"];

    
    [self base_createLeftNavigationBarButtonWithFrontImage:nil andSelectedImageName:nil andBackGroundImageName:nil andTitle:nil andSize:CGSizeMake(0, 0)];
    UIView * backColorView = [[UIView alloc] init];
    backColorView.backgroundColor = PView_BGColor;
    kTableView.backgroundView =  backColorView;
    
    [UIView animateWithDuration:0.2 animations:^{
        bgView.frame = CGRectMake(MainScreenSize_W, 64, MainScreenSize_W - 100, MainScreenSize_H);
    }];
    
//    if (self.delegate && [self.delegate respondsToSelector:@selector(passSelectIndexPath:)]) {
//        if (selectIndexPath == nil) {
//            [self.delegate passSelectIndexPath:self.selIndexPath];
//        }else{
//            [self.delegate passSelectIndexPath:selectIndexPath];
//        }
//    }
//    [self.navigationController popViewControllerAnimated:YES];
    
    
}

#pragma mark- 子表知识点解析和习题训练点击事件
-(void)passChildKBtnTag:(NSInteger)btnTag
{
    
    [[SoundTools sharedSoundTools] playSoundWithName:@"ui_click_in"];

    NSLog(@"子表知识点解析和习题训练点击事件 %ld, %ld, %ld",btnTag,btnTag/10000,btnTag%10000);
    ChildLevelListModel *childLevelModel = [thirdChildArr objectAtIndex:btnTag/10000];
    LearningPlanRequest * request = [[LearningPlanRequest alloc]init];
    if (btnTag%10000 == 0) {
        //知识点解析
        [request userModuleStatisticsWithMId:childLevelModel.kId WithMType:@"0" success:^(id obj) {
            // 1.4.35 模块统计
            InfoResult *infoResult = (InfoResult *)obj;
            if ([infoResult.code isEqualToString:@"0"]) {
                AnalyticalKnowledgeViewController *analyticalKVC = [[AnalyticalKnowledgeViewController alloc] init];
                analyticalKVC.fromType = 1;
                analyticalKVC.kId = childLevelModel.kId;
                analyticalKVC.kName = childLevelModel.kName;
                analyticalKVC.kContent = childLevelModel.kContent;
                [self.navigationController pushViewController:analyticalKVC animated:YES];
            }
        } failed:^(id obj) {
            
        }];
        
    }else{
        //习题训练
        [request userModuleStatisticsWithMId:childLevelModel.kId WithMType:@"1" success:^(id obj) {
            // 1.4.35 模块统计
            InfoResult *infoResult = (InfoResult *)obj;
            if ([infoResult.code isEqualToString:@"0"]) {
                ExerciseTrainViewController *trainExerciseVC = [[ExerciseTrainViewController alloc]init];
                trainExerciseVC.kId = childLevelModel.kId;
                trainExerciseVC.setType = 3;
                trainExerciseVC.fromType = 0;
                [UserDefaultsUtils saveValue:childLevelModel.kName forKey:KNOWLEDGENAME];
                [self.navigationController pushViewController:trainExerciseVC animated:YES];
            }
        } failed:^(id obj) {
            
        }];
        
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
