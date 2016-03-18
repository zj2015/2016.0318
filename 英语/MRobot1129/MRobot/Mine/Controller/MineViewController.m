//
//  MineViewController.m
//  MRobot
//
//  Created by mac on 15/8/19.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "MineViewController.h"
#import "MineHeadView.h"
#import "MineTableViewCell.h"

#import "WrongExamViewController.h"
#import "FeedbackViewController.h"
#import "ErrorKnowledgeViewController.h"

#import "ExamOutlineViewController.h"
#import "VolumeTestViewController.h"

#import "StudyPlanViewController.h"
#import "LoginViewController.h"
#import "BaseNavigationController.h"

@interface MineViewController ()
{
    NSArray *cellArr;
    NSArray *cellImageArr;
}
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self base_changeNavigationTitleWithString:@"我的"];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _myTableView.tableHeaderView = [self tableHeadView];
}

- (UIView *)tableHeadView
{
    MineHeadView *headView = [[MineHeadView alloc]initWithFrame:CGRectMake(0, 0, MainScreenSize_W, HeadViewCellHeight)];
    return headView;
}

- (void)_prepareUI
{
#if TARGET_VERSION_LITE ==1
    if ([UserDefaultsUtils boolValueWithKey:ISINNER]) {
        //target（中考校内版）需要执行的代码
        cellArr = @[@"易错知识点",@"我的错题库",@"模拟考试",@"意见反馈",@"注销"];
        cellImageArr = @[@"yicuo",@"cuotiku",@"monikaoshi",@"fankui",@"zhuxiao2"];
    }else{
        //target（中考校外版）需要执行的代码
        cellArr = @[@"易错知识点",@"我的错题库",@"模拟考试",@"意见反馈",@"更改学习计划",@"注销"];
        cellImageArr = @[@"yicuo",@"cuotiku",@"monikaoshi",@"fankui",@"plan",@"zhuxiao2"];
    }
    
#elif TARGET_VERSION_LITE ==2
    //target（中考校外版）需要执行的代码
    cellArr = @[@"易错知识点",@"我的错题库",@"模拟考试",@"意见反馈",@"更改学习计划",@"注销"];
    cellImageArr = @[@"yicuo",@"cuotiku",@"monikaoshi",@"fankui",@"plan",@"zhuxiao2"];
    
#elif TARGET_VERSION_LITE ==3
    if ([UserDefaultsUtils boolValueWithKey:ISINNER]) {
        //target（高考校内版）需要执行的代码
        cellArr = @[@"易错知识点",@"我的错题库",@"模拟考试",@"意见反馈",@"注销"];
        cellImageArr = @[@"yicuo",@"cuotiku",@"monikaoshi",@"fankui",@"zhuxiao2"];
    }else{
        //target（高考校外版）需要执行的代码
        cellArr = @[@"易错知识点",@"我的错题库",@"模拟考试",@"意见反馈",@"更改学习计划",@"注销"];
        cellImageArr = @[@"yicuo",@"cuotiku",@"monikaoshi",@"fankui",@"plan",@"zhuxiao2"];
    }
    
#elif TARGET_VERSION_LITE ==4
    //target（高考校外版）需要执行的代码
    cellArr = @[@"易错知识点",@"我的错题库",@"模拟考试",@"意见反馈",@"更改学习计划",@"注销"];
    cellImageArr = @[@"yicuo",@"cuotiku",@"monikaoshi",@"fankui",@"plan",@"zhuxiao2"];
    
#endif
    
    CGRect rect = CGRectMake(MainSreenOrigin_X,MainSreenOrigin_Y,MainScreenSize_W,MainScreenSize_H);
    _myTableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.rowHeight = MineCellHeight;
    _myTableView.tableHeaderView = [self tableHeadView];
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_myTableView];
    
    // 改变 tableView的背景色
    _myTableView.backgroundView = [aCommon tableViewsBackGroundView];
    _myTableView.backgroundView.backgroundColor = RgbColor(217, 217, 217);
    //去掉多余的分割线
    _myTableView.tableFooterView = [aCommon tableViewsFooterView];
}

#pragma mark ------
#pragma mark ---UITableViewDataSource---

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return cellArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"identifier";
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MineTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;//取消选中
    }
    
    if ((indexPath.row % 2) == 0) {
        cell.backgroundColor = [UIColor whiteColor];
    }else{
        cell.backgroundColor = [UIColor clearColor];
    }
    
    cell.rightLabel.text = cellArr[indexPath.row];
//    cell.leftImageView.image = [UIImage imageNamed:cellImageArr[indexPath.row]];
    return cell;
}

#pragma mark ------
#pragma mark ---UITableViewDelegate---
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [[SoundTools sharedSoundTools] playSoundWithName:@"ui_click_in"];

    
    [self.view endEditing:YES];
    switch (indexPath.row) {
        case 0:
        {
            PLog(@"易错知识点");
//            [aCommon iToast:@"功能正在开发中，敬请期待~"];
            ErrorKnowledgeViewController *errorVC = [[ErrorKnowledgeViewController alloc]init];
            [self.navigationController pushViewController:errorVC animated:YES];
        }
            break;
        case 1:
        {
            PLog(@"我的错题库");
            //我的错题库
            WrongExamViewController *wrongExamVC = [[WrongExamViewController alloc] init];
            [self.navigationController pushViewController:wrongExamVC animated:YES];
        }
            break;
        case 2:
        {
            PLog(@"模拟考试");
            VolumeTestViewController *volumeTestVC = [[VolumeTestViewController alloc]init];
            [self.navigationController pushViewController:volumeTestVC animated:YES];
//
//            ExamOutlineViewController *examVC = [[ExamOutlineViewController alloc]init];
//            [self.navigationController pushViewController:examVC animated:YES];
           
        }
            break;
//        case 3:
//        {
//            PLog(@"学习指导");
//        }
//            break;
        case 3:
        {
            PLog(@"意见反馈");
            FeedbackViewController *feedBackVC = [[FeedbackViewController alloc]init];
            [self.navigationController pushViewController:feedBackVC animated:YES];
        }
            break;
        case 4:
        {
#if TARGET_VERSION_LITE ==1
            if ([UserDefaultsUtils boolValueWithKey:ISINNER]) {
                //target（中考校内版）需要执行的代码
                PLog(@"校内的-注销")
                BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:[[LoginViewController alloc]init]];
                [UserDefaultsUtils saveBoolValue:YES withKey:WHETHERTHECANCELLATION];
                self.view.window.rootViewController = nav;
            }else{
                //target（中考校外版）需要执行的代码
                PLog(@"校外的-更改学习计划");
                StudyPlanViewController *studyPlanVC = [[StudyPlanViewController alloc]init];
                studyPlanVC.planType = 1;
                [self.navigationController pushViewController:studyPlanVC animated:YES];
            }
            
#elif TARGET_VERSION_LITE ==2
            //target（中考校外版）需要执行的代码
            PLog(@"校外的-更改学习计划");
            StudyPlanViewController *studyPlanVC = [[StudyPlanViewController alloc]init];
            studyPlanVC.planType = 1;
            [self.navigationController pushViewController:studyPlanVC animated:YES];
            
#elif TARGET_VERSION_LITE ==3
        
            if ([UserDefaultsUtils boolValueWithKey:ISINNER]) {
                //target（高考校内版）需要执行的代码
                PLog(@"校内的-注销")
                BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:[[LoginViewController alloc]init]];
                [UserDefaultsUtils saveBoolValue:YES withKey:WHETHERTHECANCELLATION];
                self.view.window.rootViewController = nav;
            }else{
                //target（高考校外版）需要执行的代码
                PLog(@"校外的-更改学习计划");
                StudyPlanViewController *studyPlanVC = [[StudyPlanViewController alloc]init];
                studyPlanVC.planType = 1;
                [self.navigationController pushViewController:studyPlanVC animated:YES];
            }
            
#elif TARGET_VERSION_LITE ==4
            //target（高考校外版）需要执行的代码
            PLog(@"校外的-更改学习计划");
            StudyPlanViewController *studyPlanVC = [[StudyPlanViewController alloc]init];
            studyPlanVC.planType = 1;
            [self.navigationController pushViewController:studyPlanVC animated:YES];
            
#endif
           
        }
            break;
        case 5:
        {
#if TARGET_VERSION_LITE ==1
            
            if ([UserDefaultsUtils boolValueWithKey:ISINNER]) {
                //target（中考校内版）需要执行的代码
                
            }else{
                //target（中考校外版）需要执行的代码
                PLog(@"校外的-注销")
                BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:[[LoginViewController alloc]init]];
                [UserDefaultsUtils saveBoolValue:YES withKey:WHETHERTHECANCELLATION];
                self.view.window.rootViewController = nav;
            }
#elif TARGET_VERSION_LITE ==2
            //target（中考校外版）需要执行的代码
            PLog(@"校外的-注销")
            BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:[[LoginViewController alloc]init]];
            [UserDefaultsUtils saveBoolValue:YES withKey:WHETHERTHECANCELLATION];
            self.view.window.rootViewController = nav;
            
#elif TARGET_VERSION_LITE ==3
            if ([UserDefaultsUtils boolValueWithKey:ISINNER]) {
                //target（高考校内版）需要执行的代码
                
            }else{
                //target（高考校外版）需要执行的代码
                PLog(@"校外的-注销")
                BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:[[LoginViewController alloc]init]];
                [UserDefaultsUtils saveBoolValue:YES withKey:WHETHERTHECANCELLATION];
                self.view.window.rootViewController = nav;
            }
#elif TARGET_VERSION_LITE ==4
            //target（高考校外版）需要执行的代码
            PLog(@"校外的-注销")
            BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:[[LoginViewController alloc]init]];
            [UserDefaultsUtils saveBoolValue:YES withKey:WHETHERTHECANCELLATION];
            self.view.window.rootViewController = nav;
            
#endif
        }
            break;
        default:
            break;
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
