//
//  TrainResultThreeViewController.m
//  MRobot
//
//  Created by mac on 15/8/22.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "TrainResultThreeViewController.h"
#import "SubmitWrongViewController.h"
#import "SubmitWrongTViewController.h"
#import "SkillTrainingViewController.h"
#import "UserLoginModel.h"
#import "TopicVideoViewController.h"
#import "ExerciseTrainViewController.h"

@interface TrainResultThreeViewController ()

@end

@implementation TrainResultThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self base_changeNavigationTitleWithString:@"Result"];
//    [self base_createRightNavigationBarButtonWithFrontImage:@"share" andSelectedImageName:nil andBackGroundImageName:@"share" andTitle:nil andSize:CGSizeMake(30, 30)];
    
}

-(void)base_navigation_LeftBarButtonPressed
{
//    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    
    if (_isAgain) {
        for (UIViewController *vcHome in self.navigationController.viewControllers) {
            if ([vcHome isKindOfClass:[SkillTrainingViewController class]]) {
                [self.navigationController popToViewController:vcHome animated:YES];
            }
        }
    }else{
        for (UIViewController *vcHome in self.navigationController.viewControllers) {
            if ([vcHome isKindOfClass:[TopicVideoViewController class]]) {
                [self.navigationController popToViewController:vcHome animated:YES];
            }
        }
    }
    
}

- (void)_prepareUI
{
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 64.0, MainScreenSize_W, 40*SIZE_TIMES)];
    titleLabel.backgroundColor = [UIColor whiteColor];
    titleLabel.text = [NSString stringWithFormat:@"   %@",[UserDefaultsUtils valueWithKey:SKILLNAME]];
    titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:titleLabel];
    
    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, titleLabel.bottom, MainScreenSize_W, 0.5)];
    lineLabel.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineLabel];
    
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = RgbColor(240.0f, 240.0f, 240.0f);
    
    int temp = 0;
    for (int i = 0; i < _skillModel.resultList.count; i ++ ) {
        
        SkillResultListModel *listModel = _skillModel.resultList[i];
        
        UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(MainScreenSize_W/2, temp, MainScreenSize_W/2, 34)];
        lineView.backgroundColor = RgbColor(173, 159, 110);
        lineView.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapViewGestureRecognizer:)];
        [lineView addGestureRecognizer:tap];
        [bgView addSubview:lineView];
        
        
        UILabel *flagLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 2, 30, 30)];
        if ([listModel.isRight isEqualToString:@"1"]) {
            //            flagLabel.backgroundColor = PView_GreenColor;
            UIImageView* imageViewLabelBg = [[UIImageView alloc] initWithFrame:CGRectMake(15,2, 30, 30)];
            imageViewLabelBg.image = [UIImage imageNamed:@"resultstate1"];
            [lineView addSubview:imageViewLabelBg];
        }else{
            
            UIImageView* imageViewLabelBg = [[UIImageView alloc] initWithFrame:CGRectMake(15,2, 30, 30)];
            imageViewLabelBg.image = [UIImage imageNamed:@"resultstate2"];
            [lineView addSubview:imageViewLabelBg];
            //            flagLabel.backgroundColor = PView_RedColor;
            
            
        }
       
        flagLabel.layer.masksToBounds = YES;
        flagLabel.layer.cornerRadius = 9.0;
        flagLabel.font = [UIFont boldSystemFontOfSize:13];
        flagLabel.textColor = [UIColor whiteColor];
        flagLabel.textAlignment = NSTextAlignmentCenter;
        flagLabel.text = [NSString stringWithFormat:@"%d",i+1];
        [lineView addSubview:flagLabel];
        
        UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(flagLabel.right + 10, flagLabel.top, MainScreenSize_W/2-20, 18)];
        detailLabel.text = listModel.sName;
        detailLabel.font = [UIFont systemFontOfSize:14];
        [lineView addSubview:detailLabel];
        
        temp += 34;
    }
    
    if (_isAgain) {
        UIButton *tryAgainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        tryAgainBtn.layer.masksToBounds = YES;
        tryAgainBtn.layer.cornerRadius = 4.0;
        [tryAgainBtn setTitle:@"Repeat" forState:UIControlStateNormal];
        tryAgainBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        tryAgainBtn.backgroundColor = RgbColor(235, 79, 28);
        [tryAgainBtn addTarget:self action:@selector(clickTheBtnWithTry:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:tryAgainBtn];
        tryAgainBtn.frame = CGRectMake(15, temp + 15 - 35*SIZE_TIMES, MainScreenSize_W/2 - 30 , 35*SIZE_TIMES);
    }
    
    [bgView setBackgroundColor:RgbColor(173, 159, 110)];
    bgView.frame = CGRectMake(0, lineLabel.bottom, MainScreenSize_W, temp+30);
    
    UIImageView *line2Label = [[UIImageView alloc]initWithFrame:CGRectMake(MainScreenSize_W/2, 0, 10, temp+20)];
    line2Label.backgroundColor = [UIColor clearColor];
    [bgView addSubview:line2Label];
    
    self.view.backgroundColor=[UIColor blueColor];
    
    UIGraphicsBeginImageContext(line2Label.frame.size);
    [line2Label.image drawInRect:CGRectMake(0, 0, line2Label.frame.size.width, line2Label.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 2.0);  //线宽
    CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 144.0/255.0f, 131/255.0f, 92/255.0f, 1.0);  //颜色
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), 0, 0);  //起点坐标
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), 0, line2Label.frame.size.height/2-10);   //终点坐标
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), 10, line2Label.frame.size.height/2);   //终点坐标
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), 0, line2Label.frame.size.height/2+10);   //终点坐标
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), 0, line2Label.frame.size.height);   //终点坐标
    
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), 0, line2Label.frame.size.height);   //终点坐标
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    CGContextSetShadowWithColor(UIGraphicsGetCurrentContext(),CGSizeMake(2, 2),1,[UIColor grayColor].CGColor);
    line2Label.image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self.view addSubview:bgView];
    self.view.backgroundColor = PView_BGColor;

}

- (void)clickTheBtnWithTry:(UIButton *)btn
{
    
    [[SoundTools sharedSoundTools] playSoundWithName:@"ui_click_in"];

    PLog(@"再次训练");
    if ([[UserDefaultsUtils valueWithKey:USER_VIPSTATUS] isEqualToString:@"1"]) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:MYNOTI_USER_TRYAGAIN object:nil];
//        [self.navigationController popViewControllerAnimated:YES];
        
        ExerciseTrainViewController *exerciseVC = [[ExerciseTrainViewController alloc]init];
        exerciseVC.sId = _sId;
        exerciseVC.skillModel = _skillListModel;
        exerciseVC.setType = 1;
        exerciseVC.sType = _sType;
        [self.navigationController pushViewController:exerciseVC animated:YES];

    }else{
        
        [[SoundTools sharedSoundTools] playSoundWithName:@"ui_warning"];

        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"友情提示" message:[NSString stringWithFormat:@"本次训练需要消耗%@CC币\n确定继续吗?",[UserDefaultsUtils valueWithKey:USER_ACCNUM]] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }
}

- (void)tapViewGestureRecognizer:(UITapGestureRecognizer *)tap
{
    
    [[SoundTools sharedSoundTools] playSoundWithName:@"ui_click_in"];

    
    SkillResultListModel *listModel = _skillModel.resultList[tap.view.tag];
    SubmitWrongTViewController *submitWrongVC = [[SubmitWrongTViewController alloc]init];
    submitWrongVC.wrongId = listModel.qId;
    submitWrongVC.questionModel = _questionModel;
    submitWrongVC.optionsArr = _answerArray;
    submitWrongVC.answerArr = _answerArr;
    NSMutableArray *count = [NSMutableArray array];
    for (SkillResultListModel *list in _skillModel.resultList) {
        [count addObject:list.qId];
        if ([list.qId isEqualToString:submitWrongVC.wrongId]) {
            submitWrongVC.location = (int)count.count;
        }
    }
    submitWrongVC.errorIdArray = count;
    [self.navigationController pushViewController:submitWrongVC animated:YES];

}

#pragma mark  ---UIAlertViewDelegate---

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex) {
        [self tryagain];
    }
}

- (void)tryagain
{
    LearningPlanRequest * request = [[LearningPlanRequest alloc]init];
    [request userPayCCWithVideoId:@"" source:@"1" success:^(id obj) {
        InfoResult *infoResult = (InfoResult *)obj;
        if ([infoResult.code isEqualToString:@"0"]) {
            UserLoginModel *loginModel = [[UserLoginModel alloc] init];
            loginModel = (UserLoginModel *)[infoResult extraObj];
            
            [UserDefaultsUtils saveValue:loginModel.ccAmount forKey:USER_CCAMOUNT];
            
            //            [[NSNotificationCenter defaultCenter] postNotificationName:MYNOTI_USER_TRYAGAIN object:nil];
            //            [self.navigationController popViewControllerAnimated:YES];
            
            
            ExerciseTrainViewController *exerciseVC = [[ExerciseTrainViewController alloc]init];
            exerciseVC.sId = _sId;
            exerciseVC.skillModel = _skillListModel;
            exerciseVC.setType = 1;
            exerciseVC.sType = _sType;
            [self.navigationController pushViewController:exerciseVC animated:YES];
            [[SoundTools sharedSoundTools] playSoundWithName:@"ui_click_in"];

        }
    } failed:^(id obj) {
        
    }];
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
