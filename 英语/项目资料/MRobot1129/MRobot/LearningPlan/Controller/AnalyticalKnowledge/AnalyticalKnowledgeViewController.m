//
//  AnalyticalKnowledgeViewController.m
//  ERobot
//
//  Created by BaiYu on 15/6/30.
//  Copyright (c) 2015年 BaiYu. All rights reserved.
//

#import "AnalyticalKnowledgeViewController.h"
#import "AnalyticalKnowledgeTableViewCell.h"
#import "KVideoViewController.h"
#import "AnalyticalKnowledgeModel.h"
#import "KnowledgeModel.h"

@interface AnalyticalKnowledgeViewController ()

@end

@implementation AnalyticalKnowledgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self base_changeNavigationTitleWithString:@"知识点解析"];
    
//    self.view.backgroundColor = [UIColor colorWithRed: 0.9 green:0.9 blue:0.9 alpha:1];
    
}

-(void)_prepareUI
{
    analyticalTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, MainScreenSize_W, MainScreenSize_H) style:UITableViewStylePlain];
    analyticalTableView.delegate = self;
    analyticalTableView.dataSource = self;
    analyticalTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    analyticalTableView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    [self.view addSubview:analyticalTableView];
}


-(void)_prepareData
{
    if (self.fromType == 0) {
        //1.4.3 知识点解析
        [self showAlertHUD:@"正在加载..."];
        LearningPlanRequest *analyticalRequest = [[LearningPlanRequest alloc] init];
        [analyticalRequest userKnowledgeAnalysisListWithWeekId:self.weekId success:^(id obj) {
            InfoResult *infoResult = (InfoResult *)obj;
            if ([infoResult.code isEqualToString:@"0"]) {
                AnalyticalKnowledgeModel *analyticalKnowledgeModel = [[AnalyticalKnowledgeModel alloc] init];
                analyticalKnowledgeModel = (AnalyticalKnowledgeModel *)[infoResult extraObj];
                kDataArr = analyticalKnowledgeModel.analyticalKnowledgeArr;
                
                [analyticalTableView reloadData];
            }else{
                [aCommon iToast:@"加载失败!"];
            }
        } failed:^(id obj) {
            [aCommon iToast:@"系统未知错误!"];
        }];
    }
}

#pragma make -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.fromType == 0) {
        return [kDataArr count];
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIndentifier = @"analyticalCell";
    AnalyticalKnowledgeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[AnalyticalKnowledgeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    if (self.fromType == 0) {
        if (kDataArr) {
            
            KnowledgeModel *kModel = [kDataArr objectAtIndex:indexPath.row];
            CGFloat rowHeight = [BaseAPIManager base_getHeightByContent:kModel.KContent andFontSize:15 andFixedWidth:MainScreenSize_W-10]  + 10;
            
            cell.kNameLab.text = kModel.kName;
            cell.kContentLab.text = kModel.KContent;
            CGRect contentLabFrame = cell.kContentLab.frame;
            contentLabFrame.size.height = rowHeight;
            cell.kContentLab.frame = contentLabFrame;
            CGRect messageFrame = cell.messageBackView.frame;
            messageFrame.size.height = rowHeight;
            cell.messageBackView.frame = messageFrame;
            cell.videoBtn.tag = indexPath.row;
            [cell.videoBtn addTarget:self action:@selector(showSmallVideo:) forControlEvents:UIControlEventTouchUpInside];
            
            
        }
    }else{
        
        CGFloat rowHeight = [BaseAPIManager base_getHeightByContent:self.kContent andFontSize:15 andFixedWidth:MainScreenSize_W-10]  + 10;
        
        cell.kNameLab.text = self.kName;
        cell.kContentLab.text = self.kContent;
        CGRect contentLabFrame = cell.kContentLab.frame;
        contentLabFrame.size.height = rowHeight;
        cell.kContentLab.frame = contentLabFrame;
        CGRect messageFrame = cell.messageBackView.frame;
        messageFrame.size.height = rowHeight;
        cell.messageBackView.frame = messageFrame;
        cell.videoBtn.tag = indexPath.row;
        [cell.videoBtn addTarget:self action:@selector(showSmallVideo:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    [cell setNeedsDisplay];
    return cell;
}

#pragma make -UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat rowHeight = 0;
    if (self.fromType == 0) {
        KnowledgeModel *kModel = [kDataArr objectAtIndex:indexPath.row];
        
        rowHeight = [BaseAPIManager base_getHeightByContent:kModel.KContent andFontSize:15 andFixedWidth:MainScreenSize_W-10] + 10;
    }else{
        rowHeight = [BaseAPIManager base_getHeightByContent:self.kContent andFontSize:15 andFixedWidth:MainScreenSize_W-10]  + 10;
    }
    
    return rowHeight + 40*SIZE_TIMES + 6;
}

#pragma make -展示知识点视频
- (void)showSmallVideo:(UIButton *)btn
{
    
    [[SoundTools sharedSoundTools] playSoundWithName:@"ui_click_in"];

    KVideoViewController *kVideoVC = [[KVideoViewController alloc] init];
    if (self.fromType == 0) {
        KnowledgeModel *kModel = [kDataArr objectAtIndex:btn.tag];
        kVideoVC.kId = kModel.kId;
        kVideoVC.kName = kModel.kName;
    }else{
        kVideoVC.kId = self.kId;
        kVideoVC.kName = self.kName;
    }
    

    [self.navigationController pushViewController:kVideoVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
