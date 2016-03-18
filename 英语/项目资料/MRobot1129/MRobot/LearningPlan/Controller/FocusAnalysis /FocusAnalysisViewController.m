//
//  FocusAnalysisViewController.m
//  MRobot
//
//  Created by BaiYu on 15/8/24.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "FocusAnalysisViewController.h"
#import "FocusAnalysisTableViewCell.h"
#import "DWCustomPlayerViewController.h"
#import "ImportantAnalysiModel.h"
#import "ImportantListModel.h"
#import "UserLoginModel.h"

@interface FocusAnalysisViewController ()
@property (strong, nonatomic)ImportantListModel *importantModel;

@end

@implementation FocusAnalysisViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self base_changeNavigationTitleWithString:@"本周技巧训练内容"];
    self.view.backgroundColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1];
}

-(void)_prepareUI
{
    analysisTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MainScreenSize_W, MainScreenSize_H) style:UITableViewStylePlain];
    analysisTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    analysisTable.delegate = self;
    analysisTable.dataSource = self;
    analysisTable.rowHeight = 135 * SIZE_TIMES;
    analysisTable.backgroundColor = PView_BGColor;
    [self.view addSubview:analysisTable];    
}

-(void)_prepareData
{
    //1.4.11 重点解析-综合训练
    [self showAlertHUD:@"正在加载..."];
    LearningPlanRequest *focusRequest = [[LearningPlanRequest alloc] init];
    [focusRequest userImportantAnalysiWithWeekId:self.weekId success:^(id obj)
    {
        InfoResult *infoResult = (InfoResult *)obj;
        if ([infoResult.code isEqualToString:@"0"]) {
            ImportantAnalysiModel *importModel = [[ImportantAnalysiModel alloc] init];
            importModel = (ImportantAnalysiModel *)[infoResult extraObj];

            skillsArr = importModel.skillListArray;
            
            [analysisTable reloadData];
        }else{
            [aCommon iToast:@"加载失败!"];
        }
    } failed:^(id obj) {
        [aCommon iToast:@"系统未知错误!"];
    }];
}

#pragma mark- UITableViewDataSourcer
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [skillsArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"FocusAnalysisTableViewCell";
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    FocusAnalysisTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[FocusAnalysisTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (skillsArr) {
        _importantModel = [skillsArr objectAtIndex:indexPath.row];

        cell.sNameLab.text = [NSString stringWithFormat:@" %ld. %@",(long)indexPath.row + 1,_importantModel.sName];
        cell.videoNameLab.text = _importantModel.videoName;
        [cell.videoCoverImg setImageWithURL:[NSURL URLWithString:[_importantModel.videoCoverUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"video"]];
        cell.videoBtn.tag = indexPath.row;
        [cell.videoBtn addTarget:self action:@selector(playVideoClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    

    return cell;
}

-(void)playVideoClick:(UIButton *)btn
{
    PLog(@"%ld重点解析视频按钮被点击",(long)btn.tag);
    
    _importantModel = [skillsArr objectAtIndex:btn.tag];
    
    Reachability* reach = [Reachability reachabilityWithHostname:@"www.apple.com"];
    // 判断网络状态
    if (reach.isReachableViaWiFi) { // 有wifi
        NSLog(@"有wifi");
        
        [self playVideo:_importantModel];
        
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

#pragma mark - 视频播放（传参）
- (void)playMP4WithImportantListModel:(ImportantListModel *)model
{
    
    [[SoundTools sharedSoundTools] playSoundWithName:@"ui_click_in"];

    
    DWCustomPlayerViewController *player = [[DWCustomPlayerViewController alloc] init];
    player.videoId = model.videoCCId;
    player.videoTitle = model.videoName;
    player.imgUrlstring = model.videoCoverUrl;
    player.videoURL = model.videoUrl;
    player.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:player animated:NO];
    
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        if (alertView.tag == 102) {
            //1.4.36 视频播放&再次训练 付费控制
            LearningPlanRequest * request = [[LearningPlanRequest alloc]init];
            [request userPayCCWithVideoId:_importantModel.videoCCId source:@"0" success:^(id obj)
             {
                 InfoResult *infoResult = (InfoResult *)obj;
                 if ([infoResult.code isEqualToString:@"0"]) {
                     
                     UserLoginModel *loginModel = [[UserLoginModel alloc] init];
                     loginModel = (UserLoginModel *)[infoResult extraObj];
                     
                     [UserDefaultsUtils saveValue:loginModel.ccAmount forKey:USER_CCAMOUNT];
                     
                     [self playMP4WithImportantListModel:_importantModel];
                 }
             } failed:^(id obj) {
                 
             }];
        }else{
            [self playVideo:_importantModel];
        }
    }
}

- (void)playVideo:(ImportantListModel *)importantModel
{
    if ([[UserDefaultsUtils valueWithKey:USER_VIPSTATUS] isEqualToString:@"1"]){
        [self playMP4WithImportantListModel:importantModel];
    }else{
        LearningPlanRequest * request = [[LearningPlanRequest alloc]init];
        [request userqueryVCCNumWithVideoId:importantModel.videoCCId success:^(id obj) {
            InfoResult *infoResult = (InfoResult *)obj;
            if ([infoResult.code isEqualToString:@"0"]) {
                UserLoginModel *model = [[UserLoginModel alloc] init];
                model = (UserLoginModel *)[infoResult extraObj];
                
                if ([model.vCCNum isEqualToString:@"0"]) {
                    [self playMP4WithImportantListModel:importantModel];
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
