//
//  SkillTrainingViewController.m
//  MRobot
//
//  Created by BaiYu on 15/8/25.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "SkillTrainingViewController.h"
#import "ExerciseTrainViewController.h"
#import "DWCustomPlayerViewController.h"
#import "UserLoginModel.h"

@interface SkillTrainingViewController ()

@end

@implementation SkillTrainingViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self base_changeNavigationTitleWithString:@"技巧训练" andSmallTitle:@"本周技巧训练内容"];
    
    openedInSectionArr = [NSMutableArray array];
    for (int i=0; i< 1; i++) {
        if (i == 0) {
            [openedInSectionArr addObject:@"1"];
        }else{
            [openedInSectionArr addObject:@"0"];
        }
    }
}

-(void)loadUI
{
    skillTrainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, MainScreenSize_W, MainScreenSize_H) style:UITableViewStylePlain];
    skillTrainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    skillTrainTable.delegate = self;
    skillTrainTable.dataSource = self;
    skillTrainTable.rowHeight = 40 * SIZE_TIMES;
    [self.view addSubview:skillTrainTable];
}

-(void)_prepareData
{
    if (self.fromVC == 0) {
        //    1.4.10 技巧训练-综合训练
        [self showAlertHUD:@"正在加载..."];
        LearningPlanRequest *skillListRequest = [[LearningPlanRequest alloc] init];
        [skillListRequest userSkillListWithWeekId:self.weekId success:^(id obj) {
            InfoResult *infoResult = (InfoResult *)obj;
            if ([infoResult.code isEqualToString:@"0"]) {
                [self loadUI];
                
                SkillDataModel *skillDataModel = [[SkillDataModel alloc]init];
                skillDataModel = (SkillDataModel *)[infoResult extraObj];
                skillArr = skillDataModel.skillListArr;
                
                if (openedInSectionArr.count != 0) {
                    [openedInSectionArr removeAllObjects];
                }
                for (int i=0; i< [skillArr count]; i++) {
                    if (i == 0) {
                        [openedInSectionArr addObject:@"1"];
                    }else{
                        [openedInSectionArr addObject:@"0"];
                    }
                }
                preHeaderIndex = 0;
                [skillTrainTable reloadData];
            }else{
                [aCommon iToast:@"加载失败!"];
            }
        } failed:^(id obj) {
            [aCommon iToast:@"系统未知错误!"];
        }];
    }else{
        //    1.4.5 技巧训练-综合训练（Lecture on answer to question Repeat）
        [self showAlertHUD:@"正在加载..."];
        NSLog(@"%@",self.sId);
        LearningPlanRequest *skillListRequest = [[LearningPlanRequest alloc] init];
        [skillListRequest userSkillInfoWithSId:self.sId success:^(id obj) {
            InfoResult *infoResult = (InfoResult *)obj;
            if ([infoResult.code isEqualToString:@"0"]) {
                
                [self loadUI];
                
                skillInfoModel = (SkillListModel *)[infoResult extraObj];
                
                [skillTrainTable reloadData];
            }else{
                [aCommon iToast:@"加载失败!"];
            }
        } failed:^(id obj) {
            [aCommon iToast:@"系统未知错误!"];
        }];
    }
}

#pragma mark- UITableViewDataSourcer
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.fromVC == 0) {
        return [skillArr count];
    }else{
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([[openedInSectionArr objectAtIndex:section] intValue] == 1) {
        return 1;
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
    
    UILabel *skillNameLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 20*SIZE_TIMES)];
    skillNameLab.backgroundColor = [UIColor clearColor];
    skillNameLab.font = [UIFont systemFontOfSize:15.0];
    [headerView addSubview:skillNameLab];
    
    if (self.fromVC == 0) {
        if (skillArr) {
            SkillListModel *skillDataModel = [skillArr objectAtIndex:section];
            skillNameLab.text = [NSString stringWithFormat:@"%ld. %@",(long)section + 1,skillDataModel.sName];
        }
    }else{
        skillNameLab.text = [NSString stringWithFormat:@"%ld. %@",(long)section + 1,skillInfoModel.sName];
    }
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(MainScreenSize_W - 30, 15, 17*SIZE_TIMES/2, 17*SIZE_TIMES)];
    imageView.image = [UIImage imageNamed:@"grayHide"];
    [headerView addSubview:imageView];
    
    if ([[openedInSectionArr objectAtIndex:section] intValue] == 1   && section == preHeaderIndex) {
        [[SoundTools sharedSoundTools] playSoundWithName:@"ui_on"];
        imageView.image = [UIImage imageNamed:@"greenShow"];
        [imageView setFrame:CGRectMake(MainScreenSize_W - 30, 15, 17*SIZE_TIMES, 17*SIZE_TIMES/2)];
        
    }else{
        
        [[SoundTools sharedSoundTools] playSoundWithName:@"ui_off"];

        imageView.image = [UIImage imageNamed:@"grayHide"];
        [imageView setFrame:CGRectMake(MainScreenSize_W - 30, 15, 17*SIZE_TIMES/2, 17*SIZE_TIMES)];

    }
    
    UILabel * line = [[UILabel alloc] initWithFrame:CGRectMake(0, 39*SIZE_TIMES, MainScreenSize_W, 0.5)];
    line.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    [headerView addSubview:line];
    
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifier = @"SkillTrainingTableViewCell";
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (self.fromVC == 0) {
        SkillListModel *skillDataModel = [skillArr objectAtIndex:indexPath.section];
        
        SkillTrainView *skillTrainView = [[SkillTrainView alloc] initWithFrame:CGRectMake(0, 0, MainScreenSize_W, SIZE_TIMES*250) sectionIndex:indexPath.section coverImgStr:skillDataModel.mainVideoCoverUrl];
        skillTrainView.delegate = self;
        [cell addSubview:skillTrainView];
    }else{

        SkillTrainView *skillTrainView = [[SkillTrainView alloc] initWithFrame:CGRectMake(0, 0, MainScreenSize_W, SIZE_TIMES*250) sectionIndex:indexPath.section coverImgStr:skillInfoModel.mainVideoCoverUrl];
        skillTrainView.delegate = self;
        [cell addSubview:skillTrainView];
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
    return 250 * SIZE_TIMES;
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
    [skillTrainTable reloadData];
}

#pragma mark - 技巧视频按钮被点击
-(void)skillVideoTag:(NSInteger)btnTag
{
    PLog(@"%ld技巧视频按钮被点击",btnTag);
    
    [self showAlert:btnTag];
    
}

#pragma mark - 训练技巧按钮被点击
-(void)skillTrainTag:(NSInteger)btnTag
{
    PLog(@"%ld训练技巧按钮被点击",(long)btnTag);
    isOtherClick = NO;
    [self skillTrain:btnTag];
}

#pragma mark - (其他)训练技巧按钮被点击
-(void)otherSkillTrainTag:(NSInteger)btnTag
{
    PLog(@"%ld（其他）训练技巧按钮被点击",(long)btnTag);
    isOtherClick = YES;
    [self skillTrain:btnTag];
}

#pragma mark - 自定义Alert
-(void)showAlert:(NSInteger)btnTag
{
    alertBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainScreenSize_W, MainScreenSize_H)];
    alertBgView.backgroundColor = [UIColor grayColor];
    alertBgView.alpha = 0.5;
    [self.view addSubview:alertBgView];
    
    customAlertView = [[CustomAlertView alloc] initWithFrame:CGRectMake((MainScreenSize_W-260)/2, MainScreenSize_H/2-100, 260, 150)];
    customAlertView.backgroundColor = [UIColor whiteColor];
    customAlertView.clipsToBounds = YES;
    customAlertView.layer.cornerRadius = 5;
    [self.view addSubview:customAlertView];
    
    customAlertView.continueBtn.tag = btnTag + 1;
    [customAlertView.continueBtn addTarget:self action:@selector(chooseContinueTrain:) forControlEvents:UIControlEventTouchUpInside];
    [customAlertView.cancleBtn addTarget:self action:@selector(chooseContinueTrain:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 是否继续进行技巧训练
-(void)chooseContinueTrain:(UIButton *)btn
{
    if (btn.tag == 0) {//点击了取消按钮
        
        [alertBgView removeFromSuperview];
        [customAlertView removeFromSuperview];
        
    }else{
        PLog(@"%ld继续进行技巧训练",btn.tag);
        [alertBgView removeFromSuperview];
        [customAlertView removeFromSuperview];
        
        if (self.fromVC == 0) {
            SkillListModel *skillListModel = [skillArr objectAtIndex:btn.tag-1];
    
            _videoId = skillListModel.mainVideoCCId;
            _videoTitle = @"重点解题技巧试题";
            _imgUrlstring = skillListModel.mainVideoCoverUrl;
            _videoURL = skillListModel.mainVideoUrl;
            
            [self isReachable];
        }else{
            
            _videoId = skillInfoModel.mainVideoCCId;
            _videoTitle = @"重点解题技巧试题";
            _imgUrlstring = skillInfoModel.mainVideoCoverUrl;
            _videoURL = skillInfoModel.mainVideoUrl;
            
            [self isReachable];
        }
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
    if (reach.isReachableViaWiFi) { // 有wifi
        NSLog(@"有wifi");
        
        [self playVideo];
        
    } else if (reach.isReachableViaWWAN) { // 没有使用wifi, 使用手机自带网络进行上网
        
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

#pragma mark - 技巧训练按钮点击事件
- (void)skillTrain:(NSInteger)btnTag
{
    
    
    [[SoundTools sharedSoundTools] playSoundWithName:@"ui_click_in"];

    
    ExerciseTrainViewController *exerciseVC = [[ExerciseTrainViewController alloc]init];
    if (self.fromVC == 0) {
        SkillListModel *skillListModel = [skillArr objectAtIndex:btnTag];
        exerciseVC.sId = skillListModel.sId;
        exerciseVC.skillModel = skillListModel;
        [UserDefaultsUtils saveValue:skillListModel.sName forKey:SKILLNAME];
    }else{
        exerciseVC.sId = skillInfoModel.sId;
        exerciseVC.skillModel = skillInfoModel;
        if (isOtherClick == YES) {
           
        }else{
             [UserDefaultsUtils saveValue:skillInfoModel.sName forKey:SKILLNAME];
        }
    }
    exerciseVC.setType = 1;
    
    if (isOtherClick == YES) {
        exerciseVC.sType = @"1";
        
    }else{
        exerciseVC.sType = @"0";
    }
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
