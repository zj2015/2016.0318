//
//  TrainResultFourViewController.m
//  MRobot
//
//  Created by mac on 15/8/22.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "TrainResultFourViewController.h"
#import "SubmitWrongViewController.h"
#import "SubmitWrongTViewController.h"
#import "SkillTrainingViewController.h"
#import "UserLoginModel.h"
#import "TopicVideoViewController.h"
#import "ExerciseTrainViewController.h"
@interface TrainResultFourViewController ()

@end

@implementation TrainResultFourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self base_changeNavigationTitleWithString:@"Drill result"];
//    [self base_createRightNavigationBarButtonWithFrontImage:@"share" andSelectedImageName:nil andBackGroundImageName:@"share" andTitle:nil andSize:CGSizeMake(30, 30)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     self.tabBarController.tabBar.hidden = YES;
}

-(void)base_navigation_LeftBarButtonPressed
{
//    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    
    if (_type == 0) {
        for (UIViewController *vcHome in self.navigationController.viewControllers) {
            if ([vcHome isKindOfClass:[SkillTrainingViewController class]]) {
                [self.navigationController popToViewController:vcHome animated:YES];
            }
        }
    }else if (_type == 1){
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
        
        UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(MainScreenSize_W/2, temp, MainScreenSize_W/2, 38)];
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
        flagLabel.layer.cornerRadius = 2.0;
        flagLabel.font = [UIFont boldSystemFontOfSize:18];
        flagLabel.textColor = [UIColor whiteColor];
        flagLabel.textAlignment = NSTextAlignmentCenter;
        flagLabel.text = [NSString stringWithFormat:@"%d",i+1];
        [lineView addSubview:flagLabel];
        
        UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(flagLabel.right + 10, flagLabel.top, MainScreenSize_W/2 - 48, 30)];
        detailLabel.text = listModel.sName;
        detailLabel.backgroundColor = [UIColor clearColor];
        detailLabel.lineBreakMode = NSLineBreakByCharWrapping;
        detailLabel.font = [UIFont systemFontOfSize:14];
        [lineView addSubview:detailLabel];
        
        temp += 34;
    }
    
    if (temp < 160) {
        temp = 160;
    }
    
    UIButton *tryAgainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tryAgainBtn.frame = CGRectMake(20*SIZE_TIMES, temp - 30, MainScreenSize_W/2 - 40*SIZE_TIMES , 35);
    tryAgainBtn.layer.masksToBounds = YES;
    tryAgainBtn.layer.cornerRadius = 4.0;
    [tryAgainBtn setTitle:@"Repeat" forState:UIControlStateNormal];
    tryAgainBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    tryAgainBtn.backgroundColor = RgbColor(235, 79, 28);
    [tryAgainBtn addTarget:self action:@selector(clickTheBtnWithTry:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:tryAgainBtn];
    
    UILabel *videoLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, tryAgainBtn.top - 30, MainScreenSize_W/2, 25)];
    videoLabel.textAlignment = NSTextAlignmentCenter;
    videoLabel.text = @"Key Sloving Skill";
    videoLabel.font = [UIFont systemFontOfSize:15];
    [bgView addSubview:videoLabel];
    
    
    UIImageView *videoCoverImg = [[UIImageView alloc] initWithFrame:  CGRectMake(20, videoLabel.top - 80, MainScreenSize_W/2 - 40, 75)];
    videoCoverImg.userInteractionEnabled = YES;
    if (_type == 0) {
        [videoCoverImg setImageWithURL:[NSURL URLWithString:[_skillListModel.mainVideoCoverUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"video"]];
    }else if (_type == 1){
       [videoCoverImg setImageWithURL:[NSURL URLWithString:[_qListModel.qVideoCoverUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"video"]];
        tryAgainBtn.hidden = YES;
    }
    
    [bgView addSubview:videoCoverImg];
    
    UIImageView *videoCoverImg2 = [[UIImageView alloc] initWithFrame:  CGRectMake(videoCoverImg.width/2 - 15, videoCoverImg.height/2 - 15, 30, 30)];
    videoCoverImg2.userInteractionEnabled = YES;
    videoCoverImg2.image = [UIImage imageNamed:@"PLAY"];
    [videoCoverImg addSubview:videoCoverImg2];
    
    UIButton *videoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    videoBtn.frame = CGRectMake(20, videoLabel.top - 80, MainScreenSize_W/2 - 40, 75);
    [videoBtn addTarget:self action:@selector(clickTheBtnWithPlayVideo:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:videoBtn];
    
    
    
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
    
    
    [bgView setBackgroundColor:RgbColor(173, 159, 110)];
    bgView.frame = CGRectMake(0, lineLabel.bottom, MainScreenSize_W, temp + 20);
    
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
        alert.tag = 101;
        [alert show];
    }
}

- (void)clickTheBtnWithPlayVideo:(UIButton *)btn
{
    PLog(@"播放视频");
    _videoTitle = @"重点解题技巧视频";
    if (_type == 0) {
        _videoId = _skillListModel.mainVideoCCId;
        _imgUrlstring = _skillListModel.mainVideoCoverUrl;
        _videoURL = _skillListModel.mainVideoUrl;
        
        [self isReachable];
        
    }else if (_type == 1){
        
        _videoId = _qListModel.qVideoCCId;
        _imgUrlstring = _qListModel.qVideoCoverUrl;
        _videoURL = _qListModel.qVideoUrl;
        
        [self isReachable];
    }

}

#pragma mark - 视频播放（传参）
- (void)playMP4WithVideoId:(NSString *)videoId videoTitle:(NSString *)videoTitle imgUrlstring:(NSString *)imgUrlstring videoURL:(NSString *)videoURL
{
    DWCustomPlayerViewController *player = [[DWCustomPlayerViewController alloc] init];
    player.videoId = videoId;
    player.videoTitle = videoTitle;
    player.imgUrlstring = imgUrlstring;
    player.videoURL = videoURL;
    player.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:player animated:NO];

}

#pragma mark - 判断网络状态
- (void)isReachable
{
    Reachability* reach = [Reachability reachabilityWithHostname:@"www.apple.com"];
    // 判断网络状态
    if (reach.isReachableViaWiFi) { // 有wifi
        NSLog(@"有wifi");
        
        [self playVideo];
        
    } else if (reach.isReachableViaWWAN) { // 没有使用wifi, 使用手机自带网络进行上网
        NSLog(@"使用手机自带网络进行上网");
        [[SoundTools sharedSoundTools] playSoundWithName:@"ui_warning"];

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"友情提示"
                                                        message:@"当前为非Wifi环境，是否继续使用流量播放？使用流量，可能会产生额外费用"
                                                       delegate:nil
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确定", nil];
        alert.delegate = self;
        [alert show];
        
    } else { // 没有网络
        NSLog(@"没有网络");
        [[SoundTools sharedSoundTools] playSoundWithName:@"ui_warning"];

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"友情提示"
                                                        message:@"当前没有网络,请检查您的网络状态！"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        if (alertView.tag == 101) {
            [self tryagain];
        }else if (alertView.tag == 102) {
            //1.4.36 视频播放&再次训练 付费控制
            LearningPlanRequest * request = [[LearningPlanRequest alloc]init];
            [request userPayCCWithVideoId:_videoId source:@"0" success:^(id obj)
             {
                 InfoResult *infoResult = (InfoResult *)obj;
                 if ([infoResult.code isEqualToString:@"0"]) {
                     UserLoginModel *loginModel = [[UserLoginModel alloc] init];
                     loginModel = (UserLoginModel *)[infoResult extraObj];
                     
                     [UserDefaultsUtils saveValue:loginModel.ccAmount forKey:USER_CCAMOUNT];
                     
                     [self playMP4WithVideoId:_videoId videoTitle:_videoTitle imgUrlstring:_imgUrlstring videoURL:_videoURL];
                 }
             } failed:^(id obj) {
                 
             }];
        }else{
            [self playVideo];
        }
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

- (void)playVideo
{
    if ([[UserDefaultsUtils valueWithKey:USER_VIPSTATUS] isEqualToString:@"1"]){
        [self playMP4WithVideoId:_videoId videoTitle:_videoTitle imgUrlstring:_imgUrlstring videoURL:_videoURL];
    }else{
        LearningPlanRequest * request = [[LearningPlanRequest alloc]init];
        [request userqueryVCCNumWithVideoId:_videoId success:^(id obj) {
            InfoResult *infoResult = (InfoResult *)obj;
            if ([infoResult.code isEqualToString:@"0"]) {
                UserLoginModel *model = [[UserLoginModel alloc] init];
                model = (UserLoginModel *)[infoResult extraObj];
                
                if ([model.vCCNum isEqualToString:@"0"]) {
                    [self playMP4WithVideoId:_videoId videoTitle:_videoTitle imgUrlstring:_imgUrlstring videoURL:_videoURL];
                }else{
                    [[SoundTools sharedSoundTools] playSoundWithName:@"ui_warning"];

                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"友情提示" message:[NSString stringWithFormat:@"播放此视频需要消耗%@CC币\n确定播放吗?",model.vCCNum] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                    alert.tag = 102;
                    [alert show];
                }
                
            }
        } failed:^(id obj) {
            
        }];
    }
}

- (void)tapViewGestureRecognizer:(UITapGestureRecognizer *)tap
{
    PLog(@"tag====%ld",tap.view.tag);
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
