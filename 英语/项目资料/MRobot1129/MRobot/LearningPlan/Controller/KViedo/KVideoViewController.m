//
//  KVideoViewController.m
//  MRobot
//
//  Created by BaiYu on 15/8/26.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "KVideoViewController.h"
#import "DWCustomPlayerViewController.h"
#import "ResultArrayListModel.h"
#import "KnowledgeVideoModel.h"
#import "KnowledgeCVideoModel.h"
#import "UserLoginModel.h"
#define ROWHEIGHT 100

@interface KVideoViewController ()

@end

@implementation KVideoViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self base_changeNavigationTitleWithString:@"Video"];

}

-(void)_prepareUI
{
    UILabel * kNameLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, MainScreenSize_W, 40*SIZE_TIMES)];
    kNameLab.font = [UIFont systemFontOfSize:15];
    kNameLab.backgroundColor = [UIColor whiteColor];
    kNameLab.text = [NSString stringWithFormat:@"  %@",self.kName];
    [self.view addSubview:kNameLab];
}

-(void)_prepareData
{
    //1.4.4 知识点视频列表
    [self showAlertHUD:@"正在加载..."];
    LearningPlanRequest *kVideoRequest = [[LearningPlanRequest alloc] init];
    [kVideoRequest userKnowledgeVideoListWithKId:self.kId success:^(id obj) {
        InfoResult *infoResult = (InfoResult *)obj;
        if ([infoResult.code isEqualToString:@"0"]) {
            KnowledgeVideoModel *kVideoListModel = [[KnowledgeVideoModel alloc] init];
            kVideoListModel = (KnowledgeVideoModel *)[infoResult extraObj];

            kVideosArr = kVideoListModel.resultArray;
            
            [self loadVideoUI];
        }else{
            [aCommon iToast:@"加载失败!"];
        }
    } failed:^(id obj) {
        [aCommon iToast:@"系统未知错误!"];
    }];
}

-(void)loadVideoUI
{
    if (kVideosArr != 0) {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64 + 40*SIZE_TIMES, MainScreenSize_W, MainScreenSize_H - 40*SIZE_TIMES)];
        [self.view addSubview:scrollView];
    
        for (int a = 0; a < [kVideosArr count]; a++) {
            ResultArrayListModel *kVideoModel = [kVideosArr objectAtIndex:a];
            
            KVideoView *kVideoView = [[KVideoView alloc] initWithFrame:CGRectMake(0, SIZE_TIMES*ROWHEIGHT*a, MainScreenSize_W, SIZE_TIMES*ROWHEIGHT) listIndex:a smallVideoCount:kVideoModel.cVideoList.count coverImgStr:kVideoModel.kVideoCoverUrl];
            kVideoView.delegate = self;
            [scrollView addSubview:kVideoView];
            
        }
        
        scrollView.contentSize = CGSizeMake(MainScreenSize_W, 64 + [kVideosArr count] *ROWHEIGHT*SIZE_TIMES);
    }
}

#pragma mark - PassBtnTagDelegate 知识点视频按钮点击事件
-(void)passKVideoTag:(NSInteger)btnTag
{
    PLog(@"%ld知识点视频按钮被点击",(long)btnTag);
    ResultArrayListModel *kVideoModel = [kVideosArr objectAtIndex:btnTag];
    
    _videoId = kVideoModel.kVideoCCId;
    _videoTitle = @"Video";
    _imgUrlstring = kVideoModel.kVideoCoverUrl;
    _videoURL = kVideoModel.kVideoUrl;
    
    [self isReachable];
}

#pragma mark - PassBtnTagDelegate 经典例题视频按钮点击事件
-(void)passSmallVideoTag:(NSInteger)btnTag
{
    PLog(@"%ld经典例题视频按钮被点击",(long)btnTag);
    ResultArrayListModel *kVideoModel = [kVideosArr objectAtIndex:btnTag/10000];
    KnowledgeCVideoModel *kCVideoModel = [kVideoModel.cVideoList objectAtIndex:btnTag%10000];
    
    _videoId = kCVideoModel.cVideoCCId;
    _videoTitle = @"The simple present tense";
    _imgUrlstring = kCVideoModel.cVideoCoverUrl;
    _videoURL = kCVideoModel.cVideoUrl;
    
    [self isReachable];
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
