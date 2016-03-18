//
//  TopicVideoViewController.m
//  MRobot
//
//  Created by BaiYu on 15/9/6.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "TopicVideoViewController.h"
#import "TypeQListModel.h"
#import "DWCustomPlayerViewController.h"
#import "ExerciseTrainViewController.h"
#import "UserLoginModel.h"
#import "TopicKVideoViewController.h"

@interface TopicVideoViewController ()

@end

@implementation TopicVideoViewController

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self base_changeNavigationTitleWithString:self.tName];
    
}

- (void)loadUIWithqListCount:(NSInteger)qlistCount coverImgStr:(NSString *)coverImgStr
{
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, MainScreenSize_W, MainScreenSize_H)];
    [self.view addSubview:scrollView];
    
    UIImageView *tVideoCoverImg = [[UIImageView alloc] initWithFrame: CGRectMake((MainScreenSize_W - 200*SIZE_TIMES)/2, 15, 200*SIZE_TIMES, 120*SIZE_TIMES)];
    tVideoCoverImg.userInteractionEnabled = YES;
    [tVideoCoverImg setImageWithURL:[NSURL URLWithString:[coverImgStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"video"]];
    [scrollView addSubview:tVideoCoverImg];
    
    UIButton *tVideoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tVideoBtn.frame = CGRectMake((tVideoCoverImg.size.width - 40*SIZE_TIMES)/2 , (tVideoCoverImg.size.height - 40*SIZE_TIMES)/2, 40*SIZE_TIMES, 40*SIZE_TIMES);
    tVideoBtn.tag = 0;
    [tVideoBtn setBackgroundImage:[UIImage imageNamed:@"PLAY"] forState:UIControlStateNormal];
    [tVideoBtn addTarget:self action:@selector(videoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [tVideoCoverImg addSubview:tVideoBtn];
    
    UILabel * kNameLab = [[UILabel alloc]initWithFrame:CGRectMake((MainScreenSize_W - 180*SIZE_TIMES)/2, 25 + 120*SIZE_TIMES, 180*SIZE_TIMES, 30*SIZE_TIMES)];
    kNameLab.font = [UIFont systemFontOfSize:15];
    kNameLab.textAlignment = NSTextAlignmentCenter;
    kNameLab.numberOfLines = 0;
    kNameLab.text = @"通用解题技巧";
    [scrollView addSubview:kNameLab];
    
    
    if ([typeQListModel.hasMoreVideo integerValue] > 1) {
        UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        moreBtn.frame = CGRectMake(kNameLab.right - 15*SIZE_TIMES+15, 30 + 120*SIZE_TIMES, 65*SIZE_TIMES, 25*SIZE_TIMES);
        [moreBtn setTitle:[NSString stringWithFormat:@"More(%@)",typeQListModel.hasMoreVideo] forState:UIControlStateNormal];
        [moreBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        moreBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        moreBtn.layer.masksToBounds = YES;
        moreBtn.layer.cornerRadius = 5;
        [moreBtn setBackgroundColor:[UIColor colorWithRed:231/255.0 green:170/255.0 blue:17/255.0 alpha:1]];
        [moreBtn addTarget:self action:@selector(moreVideoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:moreBtn];
    }
    
    
    for (int i = 0; i < qlistCount; i ++) {
        
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 35 + 150*SIZE_TIMES + 101*SIZE_TIMES*i, MainScreenSize_W/2+3, 100*SIZE_TIMES)];
       
        if (i%2==0) {
            leftView.backgroundColor = [UIColor lightGrayColor];
            
        }else
        {
            leftView.backgroundColor = [UIColor whiteColor];
            
        }        [scrollView addSubview:leftView];
        
        
        UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(MainScreenSize_W/2 + 1, 35 + 150*SIZE_TIMES + 101*SIZE_TIMES*i, MainScreenSize_W/2 - 1, 100*SIZE_TIMES)];
        if (i%2==0) {
            rightView.backgroundColor = [UIColor lightGrayColor];

        }else
        {
            rightView.backgroundColor = [UIColor whiteColor];

        }
        [scrollView addSubview:rightView];
        
        UIButton *focusTitleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        focusTitleBtn.frame = CGRectMake((MainScreenSize_W/2 - 100*SIZE_TIMES)/2, (100-30*SIZE_TIMES)/2, 100*SIZE_TIMES, 30*SIZE_TIMES);
        focusTitleBtn.tag = i;
        [focusTitleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [focusTitleBtn setTitle:[NSString stringWithFormat:@"重点例题 %d",i + 1] forState:UIControlStateNormal];
        focusTitleBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        focusTitleBtn.layer.masksToBounds = YES;
        focusTitleBtn.layer.cornerRadius = 5;
        [focusTitleBtn setBackgroundColor:[UIColor colorWithRed:231/255.0 green:170/255.0 blue:17/255.0 alpha:1]];
        [focusTitleBtn addTarget:self action:@selector(focusTitleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [leftView addSubview:focusTitleBtn];
        
        UIImageView *qVideoCoverImg = [[UIImageView alloc] initWithFrame: CGRectMake((MainScreenSize_W/2 - 120*SIZE_TIMES)/2, 5, 120*SIZE_TIMES, 72*SIZE_TIMES)];
        qVideoCoverImg.userInteractionEnabled = YES;
        
        TypeQListModel *qListModel = [qListArr objectAtIndex:i];
        [qVideoCoverImg setImageWithURL:[NSURL URLWithString:[qListModel.qVideoCoverUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"video"]];
        [rightView addSubview:qVideoCoverImg];
        
        UIButton *qVideoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        qVideoBtn.frame = CGRectMake((qVideoCoverImg.size.width - 30*SIZE_TIMES)/2 , (qVideoCoverImg.size.height - 30*SIZE_TIMES)/2, 30*SIZE_TIMES, 30*SIZE_TIMES);
        qVideoBtn.tag = i+1;
        [qVideoBtn setBackgroundImage:[UIImage imageNamed:@"PLAY"] forState:UIControlStateNormal];
        [qVideoBtn addTarget:self action:@selector(videoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [qVideoCoverImg addSubview:qVideoBtn];
        
        UILabel * sNameLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 5 + 72*SIZE_TIMES, MainScreenSize_W/2-1, 20*SIZE_TIMES)];
        sNameLab.font = [UIFont systemFontOfSize:15];
        sNameLab.textAlignment = NSTextAlignmentCenter;
        sNameLab.text = @"重点解题技巧";
        [rightView addSubview:sNameLab];
    }
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 35 + 150*SIZE_TIMES + 101*SIZE_TIMES*qlistCount, MainScreenSize_W, 50*SIZE_TIMES)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:bottomView];
    
    UIButton *skillTrainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    skillTrainBtn.frame = CGRectMake(10, 15/2*SIZE_TIMES, MainScreenSize_W - 20, 35*SIZE_TIMES);
    [skillTrainBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [skillTrainBtn setTitle:@"技巧训练" forState:UIControlStateNormal];
    skillTrainBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    skillTrainBtn.clipsToBounds = YES;
    skillTrainBtn.layer.cornerRadius = 8;
//    [skillTrainBtn setBackgroundColor:[UIColor colorWithRed:231/255.0 green:170/255.0 blue:17/255.0 alpha:1]];
    [skillTrainBtn setBackgroundColor:[UIColor colorWithRed:234/255.0 green:103/255.0 blue:43/255.0 alpha:1]];
    [skillTrainBtn addTarget:self action:@selector(skillTrainBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:skillTrainBtn];

    [scrollView setContentSize:CGSizeMake(MainScreenSize_W, 110+150*SIZE_TIMES+101*SIZE_TIMES*qlistCount+50*SIZE_TIMES)];
    
    scrollView.backgroundColor = PView_BGColor;

}

- (void)_prepareData
{
    
//    1.4.30 题型题目列表
    [self showAlertHUD:@"正在加载..."];
    LearningPlanRequest *topQListRequest = [[LearningPlanRequest alloc] init];
    [topQListRequest userTypeQuestionListWithTId:self.tId success:^(id obj) {
        InfoResult *infoResult = (InfoResult *)obj;
        if ([infoResult.code isEqualToString:@"0"]) {
            typeQListModel = [[TypeQuestionListModel alloc]init];
            typeQListModel = (TypeQuestionListModel *)[infoResult extraObj];

            qListArr = typeQListModel.questionListArray;
            
            [self loadUIWithqListCount:qListArr.count coverImgStr:typeQListModel.tVideoCoverUrl];
            
        }else{
            [aCommon iToast:@"加载失败!"];
        }
    } failed:^(id obj) {
        [aCommon iToast:@"系统未知错误!"];
    }];
}

#pragma mark --更多Lecture on answer to question Repeat

- (void)moreVideoBtnClick:(UIButton *)btn
{
    [[SoundTools sharedSoundTools] playSoundWithName:@"ui_click_in"];

    TopicKVideoViewController *topicKVideo = [[TopicKVideoViewController alloc]init];
    topicKVideo.tId = _tId;
    [self.navigationController pushViewController:topicKVideo animated:YES];
}

#pragma mark- 视频按钮被点击
- (void)videoBtnClick:(UIButton *)btn
{
    if (btn.tag == 0) {//最上方大视频
        
        _videoId = typeQListModel.tVideoCCId;
        _videoTitle = @"通用解题技巧视频";
        _imgUrlstring = typeQListModel.tVideoCoverUrl;
        _videoURL = typeQListModel.tVideoUrl;
        
        [self isReachable];
        
    }else{
        TypeQListModel *qListModel = [qListArr objectAtIndex:btn.tag - 1];
        
        _videoId = qListModel.qVideoCCId;
        _videoTitle = @"重点解题技巧视频";
        _imgUrlstring = qListModel.qVideoCoverUrl;
        _videoURL = qListModel.qVideoUrl;
        
        [self isReachable];
    }

}

#pragma mark - 视频播放（传参）
- (void)playMP4WithVideoId:(NSString *)videoId videoTitle:(NSString *)videoTitle imgUrlstring:(NSString *)imgUrlstring videoURL:(NSString *)videoURL
{
    [[SoundTools sharedSoundTools] playSoundWithName:@"ui_click_in"];

    
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
    if (reach.isReachableViaWiFi) {// 有wifi
        NSLog(@"有wifi");
        
        [self playVideo];
        
    } else if (reach.isReachableViaWWAN) {// 没有使用wifi, 使用手机自带网络进行上网
        [[SoundTools sharedSoundTools] playSoundWithName:@"ui_warning"];

        NSLog(@"使用手机自带网络进行上网");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"友情提示"
                                                        message:@"当前为非Wifi环境，是否继续使用流量播放？使用流量，可能会产生额外费用"
                                                       delegate:nil
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确定", nil];
        alert.delegate = self;
        [alert show];
        
    } else { // 没有网络
        [[SoundTools sharedSoundTools] playSoundWithName:@"ui_warning"];

        NSLog(@"没有网络");
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
        if (alertView.tag == 102) {
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

#pragma mark- 重点例题按钮被点击
- (void)focusTitleBtnClick:(UIButton *)btn
{
    
    [[SoundTools sharedSoundTools] playSoundWithName:@"ui_click_in"];

    TypeQListModel *qListModel = [qListArr objectAtIndex:btn.tag];
    //1.4.31 查询大题
    ExerciseTrainViewController *exerciseVC = [[ExerciseTrainViewController alloc]init];
    exerciseVC.qId = qListModel.qId;
    exerciseVC.sId = _tId;
    exerciseVC.setType = 4;
    exerciseVC.qListModel = qListModel;
    [UserDefaultsUtils saveValue:self.tName forKey:SKILLNAME];
    [self.navigationController pushViewController:exerciseVC animated:YES];
}

#pragma mark- 技巧训练按钮被点击
- (void)skillTrainBtnClick:(UIButton *)btn
{
    
    [[SoundTools sharedSoundTools] playSoundWithName:@"ui_click_in"];

    //1.4.6 题目列表-技巧训练
    ExerciseTrainViewController *exerciseVC = [[ExerciseTrainViewController alloc]init];
    exerciseVC.sId = _tId;
    exerciseVC.setType = 1;
    exerciseVC.sType = @"2";
    [UserDefaultsUtils saveValue:self.tName forKey:SKILLNAME];
    [self.navigationController pushViewController:exerciseVC animated:YES];
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
