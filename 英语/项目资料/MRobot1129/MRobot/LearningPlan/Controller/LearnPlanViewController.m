//
//  LearnPlanViewController.m
//  MRobot
//
//  Created by mac on 15/8/19.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "LearnPlanViewController.h"
#import "ChooseKindView.h"
#import "TeachContentViewController.h"
#import "AnalyticalKnowledgeViewController.h"
#import "VideoExplanationViewController.h"
#import "WeekHeadView.h"
#import "ExerciseTrainViewController.h"
#import "FocusAnalysisViewController.h"
#import "SkillTrainingViewController.h"

#import "ExamProModel.h"
#import "ExamProListModel.h"
#import "MainViewController.h"
@interface LearnPlanViewController ()

@property (strong, nonatomic) WeekHeadView *headView;

@end

@implementation LearnPlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self base_changeNavigationTitleWithString:@"我的学习进度"];
    [self base_ExtendedLayout];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    MainViewController *mainVC = (MainViewController *)self.tabBarController;
    [mainVC showOrHiddenTabBarView:NO];
}

- (void)_prepareData
{
    
    UIImageView *backColorView=[[UIImageView alloc]initWithFrame:CGRectMake(0, -64, MainScreenSize_W, MainScreenSize_H)];
    backColorView.userInteractionEnabled = YES;
    [backColorView setImage:[UIImage imageNamed:@"appbackgroundView.jpg"]];
    [self.view addSubview:backColorView];
    
    
    
    LearningPlanRequest *request = [[LearningPlanRequest alloc]init];
    [request userExamProgressListSuccess:^(id obj) {
        InfoResult *infoResult = (InfoResult *)obj;
        if ([infoResult.code isEqualToString:@"0"]) {
            ExamProModel * examModel = [[ExamProModel alloc]init];
            examModel = (ExamProModel *)[infoResult extraObj];
            _proListArr = [[NSArray alloc]initWithArray:examModel.examProListArr];
            [self prepareUI];
        }
    } failed:^(id obj) {
        [self prepareUI];
    }];
}

- (void)prepareUI
{
    NSArray *titlesArr1 = [[NSArray alloc]initWithObjects:@"教学内容",@"知识点解析",@"习题训练",@"讲解视频", nil];
    NSArray *titlesArr2 = [[NSArray alloc]initWithObjects:@"教学内容",@"通用解题技巧",@"技巧训练",@"重点解析", nil];
    
    
#if TARGET_VERSION_LITE ==1
    //target（中考校内版）需要执行的代码
    NSArray *imageArr1 = [[NSArray alloc]initWithObjects:@"jxnr",@"zsdjx",@"xtxl",@"jjsp", nil];
    NSArray *imageArr2 = [[NSArray alloc]initWithObjects:@"jxnr",@"tyjtjq",@"jqxl",@"zdjx", nil];
    
#elif TARGET_VERSION_LITE ==2
    //target（中考校外版）需要执行的代码
    NSArray *imageArr1 = [[NSArray alloc]initWithObjects:@"jxnr",@"zsdjx",@"xtxl",@"jjsp", nil];
    NSArray *imageArr2 = [[NSArray alloc]initWithObjects:@"jxnr",@"tyjtjq",@"jqxl",@"zdjx", nil];
    
#elif TARGET_VERSION_LITE ==3
    //target（高考校内版）需要执行的代码
//    NSArray *imageArr1 = [[NSArray alloc]initWithObjects:@"jxnr-high",@"zsdjx-high",@"xtxl-high",@"jjsp-high", nil];
//    NSArray *imageArr2 = [[NSArray alloc]initWithObjects:@"jxnr-high",@"tyjtjq-high",@"jqxl-high",@"zdjx-high", nil];
    
    NSArray *imageArr1 = [[NSArray alloc]initWithObjects:@"jxnr",@"zsdjx",@"xtxl",@"jjsp", nil];
    NSArray *imageArr2 = [[NSArray alloc]initWithObjects:@"jxnr",@"tyjtjq",@"jqxl",@"zdjx", nil];
#elif TARGET_VERSION_LITE ==4
    //target（高考校外版）需要执行的代码
//    NSArray *imageArr1 = [[NSArray alloc]initWithObjects:@"jxnr-high",@"zsdjx-high",@"xtxl-high",@"jjsp-high", nil];
//    NSArray *imageArr2 = [[NSArray alloc]initWithObjects:@"jxnr-high",@"tyjtjq-high",@"jqxl-high",@"zdjx-high", nil];
    NSArray *imageArr1 = [[NSArray alloc]initWithObjects:@"jxnr",@"zsdjx",@"xtxl",@"jjsp", nil];
    NSArray *imageArr2 = [[NSArray alloc]initWithObjects:@"jxnr",@"tyjtjq",@"jqxl",@"zdjx", nil];
#endif
    
    if (_proListArr) {
        
        [self.view removeAllSubviews];
        ExamProListModel *listModel = _proListArr[page];
        
        
        CGFloat headH = 200*320/414;
        if (MainScreenSize_W >320) {
            headH = headH *1.4;
        }else{
            headH = 220*320/414;
        }
        _headView = [[WeekHeadView alloc]initWithFrame:CGRectMake(0, 0, MainScreenSize_W, headH) withExamModel:listModel withCount:_proListArr.count withBlock:^(int tag) {
            
            switch (tag) {
                case 1:
                {
                    if (page>0) {
                        page = page - 1;
                        
                            ExamProListModel *listModel = _proListArr[page];
                            [_myScrollView setContentOffset:CGPointMake(page*MainScreenSize_W, 0) animated:NO];
                            [_headView headDataWithModel:listModel withCount:(int)_proListArr.count withPage:page+1];
                        
                    }
                }
                    break;
                case 2:
                {
                    if (page<_proListArr.count-1) {
                        page = page + 1;
                        
                            ExamProListModel *listModel = _proListArr[page];
                            [_myScrollView setContentOffset:CGPointMake(page*MainScreenSize_W, 0) animated:NO];
                            [_headView headDataWithModel:listModel withCount:(int)_proListArr.count withPage:page+1];

                    }
                }
                    break;
                default:
                    break;
            }
        }];
        
        CGFloat scrollViewY = 25;
        
//        if (MainScreenSize_W >320) {
//            scrollViewY = 25;
//        }
        CGRect rect = CGRectMake(0.0f, _headView.bottom-scrollViewY, MainScreenSize_W, MainScreenSize_H-44.0f - _headView.bottom+60);
        
        _myScrollView = [[UIScrollView alloc]initWithFrame:rect];
        //题目的个数
        _myScrollView.contentSize= CGSizeMake(MainScreenSize_W*(_proListArr.count), 0);
       
        _myScrollView.pagingEnabled = YES;
        _myScrollView.delegate = self;
        _myScrollView.showsHorizontalScrollIndicator = NO;
        _myScrollView.showsVerticalScrollIndicator = NO;
        _myScrollView.backgroundColor = [UIColor colorWithRed:48/255.0f green:48/255.0f  blue:48/255.0f  alpha:1];
        if(MainScreenSize_H==480.0f)
        {
            
            [_myScrollView  setFrame:CGRectMake(0.0f, 170, MainScreenSize_W,260)];
            
            _myScrollView.contentSize= CGSizeMake(MainScreenSize_W*(_proListArr.count),400);
            [_headView setFrame:CGRectMake(_headView.frame.origin.x, _headView.frame.origin.y, _headView.frame.size.width, _headView.frame.size.height)];
//            _myScrollView.backgroundColor = [UIColor redColor];
            _myScrollView.pagingEnabled = YES;

            
        }else if(MainScreenSize_H==568.0f)
        {
            
            [_myScrollView  setFrame:CGRectMake(0.0f, 170, MainScreenSize_W, MainScreenSize_H-44.0f - _headView.bottom+60)];

            
        }
        [self.view addSubview:_myScrollView];
        
        
        _thisWeek = @"1";//默认的thisWeek
        for (int i = 0; i < _proListArr.count; i ++ ) {
            
            UIView *bgView = [[UIView alloc]initWithFrame:CGRectZero];
            bgView.backgroundColor = [UIColor whiteColor];
            bgView.frame = CGRectMake(MainScreenSize_W*i, 0, MainScreenSize_W, 0);
            ExamProListModel *listModel = _proListArr[i];
            isRight = 1;
            int heightValueCus = 160;
            if (MainScreenSize_W<321) {
                heightValueCus = 150;
            }
            CGFloat choseWidthConst = MainScreenSize_W;
            if ([listModel.hasBookLearn isEqualToString:@"1"]) {
                isRight = 0;
                
                ChooseKindView *chooseView1= [[ChooseKindView alloc]initWithFrame:CGRectMake(5, 5, MainScreenSize_W - 10, heightValueCus*choseWidthConst/414) withTitle:@"教材强化" withImageArr:imageArr1 withTitleArr:titlesArr1 withBlock:^(int tag) {
                    
                    
                    [[SoundTools sharedSoundTools] playSoundWithName:@"ui_click_in"];
                    
                    
                    PLog(@"%d",tag);
                    if (tag == 1) {
                        //The course credits
                        TeachContentViewController *teachVC = [[TeachContentViewController alloc] init];
                        teachVC.weekId = listModel.weekId;
                        teachVC.classCatagory = listModel.classCatagory;
                        teachVC.cType = 0;
                        [self.navigationController pushViewController:teachVC animated:YES];
                        
                    }else {
                        //学习进度统计
                        LearningPlanRequest *request = [[LearningPlanRequest alloc]init];
                        [request userProgressStatisticsWithWeekId:listModel.weekId andWeekIndex:[NSString stringWithFormat:@"%d",page+1] andThisWeekIndex:_thisWeek success:^(id obj) {
                            
                            InfoResult *infoResult = (InfoResult *)obj;
                            if ([infoResult.code isEqualToString:@"0"]) {
                                if (tag == 2){
                                    //Analysis
                                    AnalyticalKnowledgeViewController *analyticalVC = [[AnalyticalKnowledgeViewController alloc] init];
                                    analyticalVC.weekId = listModel.weekId;
                                    [self.navigationController pushViewController:analyticalVC animated:YES];
                                    
                                }else if (tag == 3){
                                    //习题训练
                                    ExerciseTrainViewController *exerciseVC = [[ExerciseTrainViewController alloc]init];
                                    exerciseVC.weekId = listModel.weekId;
                                    exerciseVC.setType = 0;
                                    [self.navigationController pushViewController:exerciseVC animated:YES];
                                }else{
                                    //Videos
                                    VideoExplanationViewController *videoVC = [[VideoExplanationViewController alloc] init];
                                    videoVC.fromVC = 0;
                                    videoVC.weekId = listModel.weekId;
                                    //                            videoVC.weekId = @"d0ba4e86-f5cb-4b5f-9d5d-2124a9ab3beb";
                                    [self.navigationController pushViewController:videoVC animated:YES];
                                }
                            }else{
                                [aCommon iToast:infoResult.desc];
                            }
                            
                        } failed:^(id obj) {
                            [aCommon iToast:@"加载失败!"];
                        }];
                    }
                }];
                [bgView addSubview:chooseView1];
                bgView.frame = CGRectMake(MainScreenSize_W*i, 0, MainScreenSize_W, chooseView1.bottom + 7);
            }
            
            if ([listModel.hasTrain isEqualToString:@"1"]) {
                ChooseKindView *chooseView2 = [[ChooseKindView alloc]initWithFrame:CGRectMake(5, bgView.bottom + 7*isRight+5, MainScreenSize_W - 10 , heightValueCus*choseWidthConst/414) withTitle:@"综合训练" withImageArr:imageArr2 withTitleArr:titlesArr2 withBlock:^(int tag) {
                    
                    [[SoundTools sharedSoundTools] playSoundWithName:@"ui_click_in"];

                    
                    PLog(@"%d",tag);
                    if (tag == 1) {
                        //The course credits
                        TeachContentViewController *teachVC = [[TeachContentViewController alloc] init];
                        teachVC.weekId = listModel.weekId;
                        teachVC.classCatagory = listModel.classCatagory;
                        teachVC.cType = 1;
                        [self.navigationController pushViewController:teachVC animated:YES];
                        
                    }else {
                        //学习进度统计
                        LearningPlanRequest *request = [[LearningPlanRequest alloc]init];
                        [request userProgressStatisticsWithWeekId:listModel.weekId andWeekIndex:[NSString stringWithFormat:@"%d",page+1] andThisWeekIndex:_thisWeek success:^(id obj) {
                            
                            InfoResult *infoResult = (InfoResult *)obj;
                            if ([infoResult.code isEqualToString:@"0"]) {
                                
                                if (tag == 2){
                                    //Lecture on answer to question Repeat
                                    VideoExplanationViewController *videoVC = [[VideoExplanationViewController alloc] init];
                                    videoVC.fromVC = 1;
                                    videoVC.weekId = listModel.weekId;
                                    //                            videoVC.weekId = @"6a0ee1e2-2498-45a0-bfa8-f73a7575796b";
                                    [self.navigationController pushViewController:videoVC animated:YES];
                                    
                                }else if (tag == 3){
                                    //技巧训练
                                    SkillTrainingViewController *skillVC = [[SkillTrainingViewController alloc] init];
                                    skillVC.fromVC = 0;
                                    skillVC.weekId = listModel.weekId;
                                    //                            skillVC.weekId = @"5b434042-f0c3-45fc-b13f-8b11dff64c18";
                                    [self.navigationController pushViewController:skillVC animated:YES];
                                }else{
                                    //重点解析
                                    FocusAnalysisViewController *focusVC = [[FocusAnalysisViewController alloc] init];
                                    focusVC.weekId = listModel.weekId;
                                    [self.navigationController pushViewController:focusVC animated:YES];
                                }
                            }else{
                                [aCommon iToast:infoResult.desc];
                            }
                            
                        } failed:^(id obj) {
                            [aCommon iToast:@"加载失败!"];
                        }];
                    }
                }];
                [bgView addSubview:chooseView2];
                CGFloat bgviewY = 65*320/414;
                if (MainScreenSize_W < 321) {
                    bgviewY = 10;
                }
                bgView.frame = CGRectMake(MainScreenSize_W*i, bgviewY, MainScreenSize_W, chooseView2.bottom + 170);
            }
            
            
            [self.view addSubview:_headView];

            
            [bgView setBackgroundColor:[UIColor colorWithRed:48/255.0f green:48/255.0f blue:48/255.0f alpha:1]];
//            bgView.backgroundColor = [UIColor blueColor];
            [_myScrollView addSubview:bgView];

            
            if ([listModel.thisWeek isEqualToString:@"1"]) {
                [_myScrollView setContentOffset:CGPointMake(i*MainScreenSize_W, 0) animated:NO];
                [_headView headDataWithModel:listModel withCount:(int)_proListArr.count withPage:i+1];
                page = i;
            }
            if ([listModel.thisWeek isEqualToString:@"1"]) {
                _thisWeek = [NSString stringWithFormat:@"%d",page+1];
            }
            
        }
    }else{
        
        
        CGRect rect = CGRectMake(0.0f,0.0f,MainScreenSize_W,MainScreenSize_H-44);
        _myScrollView = [[UIScrollView alloc]initWithFrame:rect];
        //题目的个数
        _myScrollView.contentSize= CGSizeMake(MainScreenSize_W*(_proListArr.count+1), 0);
        _myScrollView.pagingEnabled = YES;
        _myScrollView.delegate = self;
        _myScrollView.showsHorizontalScrollIndicator = NO;
        _myScrollView.showsVerticalScrollIndicator = NO;
        _myScrollView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_myScrollView];
        
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectZero];
        bgView.backgroundColor = [UIColor whiteColor];
        
        WeekHeadView *headView = [[WeekHeadView alloc]initWithFrame:CGRectMake(0, 20, MainScreenSize_W, 200) withExamModel:nil withCount:0 withBlock:^(int tag) {
            
            
        }];
        [bgView addSubview:headView];
        
        
        ChooseKindView *chooseView1= [[ChooseKindView alloc]initWithFrame:CGRectMake(5, headView.bottom-10, MainScreenSize_W - 10 , 145) withTitle:@"    教材强化" withImageArr:imageArr1 withTitleArr:titlesArr1 withBlock:^(int tag) {
            PLog(@"%d",tag);
            [aCommon iToast:@"无数据显示~"];
        }];
        
        [bgView addSubview:chooseView1];
        bgView.frame = CGRectMake(0, 0, MainScreenSize_W*(_proListArr.count+1), chooseView1.bottom + 8);
        
        ChooseKindView *chooseView2 = [[ChooseKindView alloc]initWithFrame:CGRectMake(5, bgView.bottom+28, MainScreenSize_W - 10 , 145) withTitle:@"    综合训练" withImageArr:imageArr2 withTitleArr:titlesArr2 withBlock:^(int tag) {
            PLog(@"%d",tag);
            [aCommon iToast:@"无数据显示~"];
        }];
        [bgView addSubview:chooseView2];
        
        bgView.frame = CGRectMake(0, 0, MainScreenSize_W*(_proListArr.count+1), chooseView2.bottom + 8);
        
        [_myScrollView addSubview:bgView];
        
        
    }
    
    
}

#pragma mark --UIScrollViewDelegate--
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    [[SoundTools sharedSoundTools] playSoundWithName:@"ui_week_turn"];

    page = (scrollView.contentOffset.x+MainScreenSize_W*0.5)/MainScreenSize_W;
    
    ExamProListModel *listModel = _proListArr[page];
    
    [_headView headDataWithModel:listModel withCount:(int)_proListArr.count withPage:page+1];
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    if (scrollView.contentOffset.x <= 0)
//    {
//        CGPoint offset = scrollView.contentOffset;
//        offset.x = 0;
//        scrollView.contentOffset = offset;
//    }else if (scrollView.contentOffset.x > (_proListArr.count-1)*MainScreenSize_W){
//        CGPoint offset = scrollView.contentOffset;
//        offset.x = (_proListArr.count-1)*MainScreenSize_W;
//        scrollView.contentOffset = offset;
//    }
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
