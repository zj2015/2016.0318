//
//  VideoExplanationViewController.m
//  MRobot
//
//  Created by BaiYu on 15/8/22.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "VideoExplanationViewController.h"
#import "ExerciseTrainViewController.h"
#import "MainViewController.h"
#import "DWCustomPlayerViewController.h"
#import "SkillTrainingViewController.h"
#import "KnowledgeVideoModel.h"
#import "ResultArrayListModel.h"
#import "KnowledgeCVideoModel.h"
#import "WeekVideoModel.h"
#import "KVideoListModel.h"
#import "VideoListModel.h"
#import "CVideoListModel.h"
#import "SVideoListModel.h"
#import "CommonSkillModel.h"
#import "CommonListModel.h"
#import "UserLoginModel.h"
@interface VideoExplanationViewController ()

@end

@implementation VideoExplanationViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.fromVC == 0) {
        [self base_changeNavigationTitleWithString:@"讲解视频"];
    }else if (self.fromVC == 1) {
        [self base_changeNavigationTitleWithString:@"通用解题技巧讲解"];
    }
    
    self.view.backgroundColor = PView_BGColor;
    openedInSectionArr = [NSMutableArray array];
    dataCount = 0;
}

-(void)_prepareUI
{
    if (self.fromVC == 0) {//代表Videos
        knowledgeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        knowledgeBtn.frame = CGRectMake(0, 64, MainScreenSize_W/2, 35*SIZE_TIMES);
        knowledgeBtn.tag = 1;
        [knowledgeBtn setTitle:@"知识点" forState:UIControlStateNormal];
        knowledgeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        knowledgeBtn.backgroundColor = [UIColor colorWithRed:234/255.0 green:103/255.0 blue:43/255.0 alpha:1];
        [knowledgeBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:knowledgeBtn];
        
        solveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        solveBtn.frame = CGRectMake(MainScreenSize_W/2, 64, MainScreenSize_W/2, 35*SIZE_TIMES);
        solveBtn.tag = 2;
        [solveBtn setTitle:@"解题技巧" forState:UIControlStateNormal];
        solveBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [solveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        solveBtn.backgroundColor = [UIColor colorWithRed:238/255.0 green:230/255.0 blue:225/255.0 alpha:1];
        [solveBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:solveBtn];
        
        videoTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 68 + 35*SIZE_TIMES, MainScreenSize_W, MainScreenSize_H - 68 - 35*SIZE_TIMES) style:UITableViewStylePlain];
        videoTable.tag = 1;
        
    }else if (self.fromVC == 1){// 代表Lecture on answer to question Repeat
        videoTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MainScreenSize_W, MainScreenSize_H) style:UITableViewStylePlain];
        videoTable.tag = 2;
    }
    
    videoTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    videoTable.delegate = self;
    videoTable.dataSource = self;
    videoTable.backgroundColor = PView_BGColor;
    [self.view addSubview:videoTable];
}

-(void)_prepareData
{
    if (self.fromVC == 0) {//Videos
        //1.4.8 Videos
        [self showAlertHUD:@"正在加载..."];
        LearningPlanRequest *videoListRequest = [[LearningPlanRequest alloc] init];
        [videoListRequest userWeekVideoListWithWeekId:self.weekId success:^(id obj) {
            InfoResult *infoResult = (InfoResult *)obj;
            if ([infoResult.code isEqualToString:@"0"]) {
                WeekVideoModel *weekVideoModel = [[WeekVideoModel alloc] init];
                weekVideoModel = (WeekVideoModel *)[infoResult extraObj];

                kVideosArr = weekVideoModel.kVideoListArr;
                sVideosArr = weekVideoModel.sVideoListArr;
                if (videoTable.tag == 1) {
                    dataCount = [kVideosArr count];
                }else{
                    dataCount = [sVideosArr count];
                }
                preHeaderIndex = 0;
                if ([openedInSectionArr count] != 0) {
                    [openedInSectionArr removeAllObjects];
                }
                for (int i=0; i< dataCount; i++) {
                    if (i == 0) {
                        [openedInSectionArr addObject:@"1"];
                    }else{
                        [openedInSectionArr addObject:@"0"];
                    }
                }
    
                [videoTable reloadData];
            }else{
                [aCommon iToast:@"加载失败!"];
            }
            
        } failed:^(id obj) {
            [aCommon iToast:@"系统未知错误!"];
        }];
    }else if (self.fromVC == 1){//Lecture on answer to question Repeat
        //1.4.9 Lecture on answer to questio Repeat
        [self showAlertHUD:@"正在加载..."];
        LearningPlanRequest *skillListRequest = [[LearningPlanRequest alloc] init];
        [skillListRequest userCommonSkillListWithWeekId:self.weekId success:^(id obj) {
            InfoResult *infoResult = (InfoResult *)obj;
            if ([infoResult.code isEqualToString:@"0"]) {
                CommonSkillModel *commonSkillModel = [[CommonSkillModel alloc] init];
                commonSkillModel = (CommonSkillModel *)[infoResult extraObj];
    
                sVideosArr = commonSkillModel.commonSkillListArr;
                
                dataCount = [sVideosArr count];
                preHeaderIndex = 0;
                if ([openedInSectionArr count] != 0) {
                    [openedInSectionArr removeAllObjects];
                }
                for (int i=0; i< dataCount; i++) {
                    if (i == 0) {
                        [openedInSectionArr addObject:@"1"];
                    }else{
                        [openedInSectionArr addObject:@"0"];
                    }
                }
                
                [videoTable reloadData];
                
            }else{
                [aCommon iToast:@"加载失败!"];
            }
            
        } failed:^(id obj) {
            [aCommon iToast:@"系统未知错误!"];
        }];
    }
}

-(void)selectBtnClick:(UIButton *)sender
{
    
    
    if (sender.tag == 1) {
        //知识点
        knowledgeBtn.backgroundColor = [UIColor colorWithRed:234/255.0 green:103/255.0 blue:43/255.0 alpha:1];
  

        [knowledgeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        solveBtn.backgroundColor = [UIColor colorWithRed:238/255.0 green:230/255.0 blue:225/255.0 alpha:1];
        [solveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        videoTable.tag = 1;
        preHeaderIndex = 0;
        if ([openedInSectionArr count] != 0) {
            [openedInSectionArr removeAllObjects];
        }
        for (int i=0; i< [kVideosArr count]; i++) {
            if (i == 0) {
                [openedInSectionArr addObject:@"1"];
            }else{
                [openedInSectionArr addObject:@"0"];
            }
        }
        
        [videoTable reloadData];
        
    }else{
        //Videos
        knowledgeBtn.backgroundColor = [UIColor colorWithRed:238/255.0 green:230/255.0 blue:225/255.0 alpha:1];
        [knowledgeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        solveBtn.backgroundColor = [UIColor colorWithRed:234/255.0 green:103/255.0 blue:43/255.0 alpha:1];
        [solveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        videoTable.tag = 2;
        preHeaderIndex = 0;
        if ([openedInSectionArr count] != 0) {
            [openedInSectionArr removeAllObjects];
        }
        for (int i=0; i< [sVideosArr count]; i++) {
            if (i == 0) {
                [openedInSectionArr addObject:@"1"];
            }else{
                [openedInSectionArr addObject:@"0"];
            }
        }
        
        [videoTable reloadData];
        
    }
}

#pragma mark- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag == 1) {
        return [kVideosArr count];
    }else{
        return [sVideosArr count];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([[openedInSectionArr objectAtIndex:section] intValue] == 1) {
        if (tableView.tag == 1) {
            KVideoListModel *kVideoListModel = [[KVideoListModel alloc] init];
            kVideoListModel = [kVideosArr objectAtIndex:section];
            
            return [kVideoListModel.videoList count];
        }else{
            return 1;
        }
    }else{
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenSize_W, 40*SIZE_TIMES)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UIButton * heightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    heightButton.frame = CGRectMake(0, 0, MainScreenSize_W, 40*SIZE_TIMES);
    heightButton.tag = section;
    [heightButton addTarget:self action:@selector(headerClick:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:heightButton];
    
    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, MainScreenSize_W - 40, 40*SIZE_TIMES - 10)];
    if (tableView.tag == 1) {//知识点视频
        KVideoListModel *kVideoListModel = [[KVideoListModel alloc] init];
        kVideoListModel = [kVideosArr objectAtIndex:section];
        
        nameLab.text = [NSString stringWithFormat:@"%ld. %@",(long)section + 1,kVideoListModel.kName];
    }else{//解题技巧
        if (self.fromVC == 0) {
            //Videos中的解题技巧
            SVideoListModel *sVideoListModel = [[SVideoListModel alloc] init];
            sVideoListModel = [sVideosArr objectAtIndex:section];
            nameLab.text = [NSString stringWithFormat:@"%ld. %@",(long)section + 1,sVideoListModel.sName];
            
        }else{
            //Lecture on answer to question Repeat
            CommonListModel *commonListModel = [[CommonListModel alloc] init];
            commonListModel = [sVideosArr objectAtIndex:section];
            nameLab.text = [NSString stringWithFormat:@"%ld. %@",(long)section + 1,commonListModel.sName];
        }
        
    }
    [headerView addSubview:nameLab];
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(MainScreenSize_W - 30, 15, 15*SIZE_TIMES, 15*SIZE_TIMES/2)];
    imageView.image = [UIImage imageNamed:@"hide"];
    [headerView addSubview:imageView];
    
    if ([[openedInSectionArr objectAtIndex:section] intValue] == 1   && section == preHeaderIndex) {
        
        imageView.image = [UIImage imageNamed:@"greenShow"];
        [[SoundTools sharedSoundTools] playSoundWithName:@"ui_on"];

    }else{
        [[SoundTools sharedSoundTools] playSoundWithName:@"ui_off"];

        imageView.image = [UIImage imageNamed:@"grayHide"];
        
    }
    
    UILabel * line = [[UILabel alloc] initWithFrame:CGRectMake(0, 39*SIZE_TIMES, MainScreenSize_W, 0.5)];
    line.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    [headerView addSubview:line];
    
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"VideoConnectTableViewCell";
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    for (UIView *view in [cell.contentView subviews]) {
        [view removeFromSuperview];
    }

    if (tableView.tag == 1) {
        
        KVideoListModel *kVideoListModel = [[KVideoListModel alloc] init];
        kVideoListModel = [kVideosArr objectAtIndex:indexPath.section];
        
        VideoListModel *videoListModel = [kVideoListModel.videoList objectAtIndex:indexPath.row];
        
        KVideoView *kVideoView = [[KVideoView alloc] initWithFrame:CGRectMake(0, 0, MainScreenSize_W, SIZE_TIMES*100) listIndex:indexPath.row smallVideoCount:[videoListModel.cVideoList count] coverImgStr:videoListModel.kVideoCoverUrl];
        kVideoView.delegate = self;
        [cell.contentView addSubview:kVideoView];
        
    }else{
        SVideoListModel *sVideoListModel = [sVideosArr objectAtIndex:indexPath.section];
        
        SVideoView *sVideoView = [[SVideoView alloc] initWithFrame:CGRectMake(0, 0, MainScreenSize_W, SIZE_TIMES*115) listIndex:indexPath.row coverImgStr:sVideoListModel.sVideoCoverUrl videoName:@"通用解题技巧视频" trainBtnTitle:@"进入训练技巧"];
        sVideoView.delegate = self;
        [cell.contentView addSubview:sVideoView];
    }
    
    return cell;
}

#pragma mark- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40 * SIZE_TIMES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 1) {
        return 100 * SIZE_TIMES;
    }else{
        return 115 * SIZE_TIMES;
    }
}

#pragma mark - 区头点击方法
- (void)headerClick:(UIButton *)btn
{
    if ([[openedInSectionArr objectAtIndex:btn.tag] intValue] == 0) {
        [openedInSectionArr replaceObjectAtIndex:preHeaderIndex withObject:@"0"];//将上一个被点击的区置为闭合状态
        [openedInSectionArr replaceObjectAtIndex:btn.tag withObject:@"1"];
    }
    else
    {
        [openedInSectionArr replaceObjectAtIndex:btn.tag withObject:@"0"];
    }
    preHeaderIndex = btn.tag;
    [videoTable reloadData];
}

#pragma mark - PassBtnTagDelegate 知识点视频按钮点击事件
-(void)passKVideoTag:(NSInteger)btnTag
{
    PLog(@"%ld知识点视频按钮被点击",(long)btnTag);
    PLog(@"当前展开的区%ld",(long)preHeaderIndex);
    KVideoListModel *kVideoListModel = [[KVideoListModel alloc] init];
    kVideoListModel = [kVideosArr objectAtIndex:preHeaderIndex];
    
    VideoListModel *videoListModel = [kVideoListModel.videoList objectAtIndex:btnTag];
    _videoId = videoListModel.kVideoCCId;
    _videoTitle = @"Videos";
    _imgUrlstring = videoListModel.kVideoCoverUrl;
    _videoURL = videoListModel.kVideoUrl;
    
    [self isReachable];
    
}

#pragma mark - PassBtnTagDelegate 经典例题视频按钮点击事件
-(void)passSmallVideoTag:(NSInteger)btnTag
{
    PLog(@"%ld经典例题视频按钮被点击",(long)btnTag);
    PLog(@"当前展开的区%ld",(long)preHeaderIndex);
    
    KVideoListModel *kVideoListModel = [[KVideoListModel alloc] init];
    kVideoListModel = [kVideosArr objectAtIndex:preHeaderIndex];
    
    VideoListModel *videoListModel = [kVideoListModel.videoList objectAtIndex:btnTag/10000];
    
    CVideoListModel *cVideoModel = [videoListModel.cVideoList objectAtIndex:btnTag%10000];
    _videoId = cVideoModel.cVideoCCId;
    _videoTitle = @"经典例题视频";
    _imgUrlstring = cVideoModel.cVideoCoverUrl;
    _videoURL = cVideoModel.cVideoUrl;
    
    [self isReachable];
    
}

#pragma mark - PassSkillBtnTagDelegate 技巧视频按钮点击事件
-(void)passSVideoTag:(NSInteger)btnTag
{
    PLog(@"%ld技巧视频按钮被点击",(long)btnTag);
    PLog(@"当前展开的区%ld",(long)preHeaderIndex);
    
    if (self.fromVC == 0) {
        //视频讲解
        SVideoListModel *sVideoListModel = [sVideosArr objectAtIndex:preHeaderIndex];
        
        _videoId = sVideoListModel.sVideoCCId;
        _videoTitle = @"Video – answer to the common questions Repeat";
        _imgUrlstring = sVideoListModel.sVideoCoverUrl;
        _videoURL = sVideoListModel.sVideoUrl;
        
        [self isReachable];
        
    }else{
        //Lecture on answer to question Repeat
        CommonListModel *commonListModel = [sVideosArr objectAtIndex:preHeaderIndex];
        _videoId = commonListModel.sVideoCCId;
        _videoTitle = @"Video – answer to the common questions Repeat";
        _imgUrlstring = commonListModel.sVideoCoverUrl;
        _videoURL = commonListModel.sVideoUrl;
        
        [self isReachable];
    }

}

#pragma mark - PassSkillBtnTagDelegate 进入技巧训练按钮点击事件
-(void)passSkillTrainTag:(NSInteger)btnTag
{
    PLog(@"%ld技巧训练按钮被点击",(long)btnTag);
    PLog(@"当前展开的区%ld",(long)preHeaderIndex);
    SkillTrainingViewController *skillTrainVC = [[SkillTrainingViewController alloc] init];
    skillTrainVC.fromVC = 1;
    if (self.fromVC == 0) {
        //视频讲解
        SVideoListModel *sVideoListModel = [sVideosArr objectAtIndex:preHeaderIndex];
        skillTrainVC.sId = sVideoListModel.sId;
        [UserDefaultsUtils saveValue:sVideoListModel.sName forKey:SKILLNAME];
    }else{
        //Lecture on answer to question Repeat
        CommonListModel *commonListModel = [sVideosArr objectAtIndex:preHeaderIndex];
        skillTrainVC.sId = commonListModel.sId;
        [UserDefaultsUtils saveValue:commonListModel.sName forKey:SKILLNAME];
    }
    [self.navigationController pushViewController:skillTrainVC animated:YES];
    [[SoundTools sharedSoundTools] playSoundWithName:@"ui_click_in"];

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
