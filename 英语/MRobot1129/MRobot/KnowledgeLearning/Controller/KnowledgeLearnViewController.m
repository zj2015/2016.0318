//
//  KnowledgeLearnViewController.m
//  MRobot
//
//  Created by mac on 15/8/19.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "KnowledgeLearnViewController.h"
#import "KnowledgeTableViewCell.h"
#import "TopLevelKnowModel.h"
#import "TopLevelListModel.h"

@interface KnowledgeLearnViewController ()

@end

@implementation KnowledgeLearnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self base_changeNavigationTitleWithString:@"知识点选择"];
}

- (void)_prepareUI
{
    CGRect rect = CGRectMake(MainSreenOrigin_X,MainSreenOrigin_Y,MainScreenSize_W,MainScreenSize_H);
    _myTableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.rowHeight = KnowledgeCellHeight;
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_myTableView];
    
    selectRow = -1;
    
    // 改变 tableView的背景色
    _myTableView.backgroundView = [aCommon tableViewsBackGroundView];
    
    //去掉多余的分割线
    _myTableView.tableFooterView = [aCommon tableViewsFooterView];
    
    kNameArr = [[NSMutableArray alloc] initWithCapacity:0];
    
}

- (void)_prepareData
{
    LearningPlanRequest *levelKRequest = [[LearningPlanRequest alloc] init];
    [levelKRequest userTopLevelKnowledgeSuccess:^(id obj) {
        InfoResult *infoResult = (InfoResult *)obj;
        if ([infoResult.code isEqualToString:@"0"]) {
            TopLevelKnowModel *topLevelKModel = [[TopLevelKnowModel alloc]init];
            topLevelKModel = (TopLevelKnowModel *)[infoResult extraObj];
            kDataArr = topLevelKModel.resultArray;
            
            for (int i = 0; i < [kDataArr count]; i++) {
                TopLevelListModel *topLevelModel = [kDataArr objectAtIndex:i];
                [kNameArr addObject:topLevelModel.kName];
            }
            
            [_myTableView reloadData];
        }else{
            [aCommon iToast:@"加载失败!"];
        }
    } failed:^(id obj) {
        [aCommon iToast:@"系统未知错误!"];
    }];
}

#pragma mark ------
#pragma mark ---UITableViewDataSource---

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [kDataArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"identifier";
    KnowledgeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[KnowledgeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;//取消选中
    }
    if (indexPath.row == selectRow) {
        cell.knowledgeNameLab.textColor = RgbColor(0, 179, 138);
        cell.signImgView.image = [UIImage imageNamed:@"arrowRight"];
    }else{
        cell.knowledgeNameLab.textColor = [UIColor blackColor];
        cell.signImgView.image = [UIImage imageNamed:@"grayHide"];
    }
    cell.knowledgeNameLab.text = [NSString stringWithFormat:@"  %@",kNameArr[indexPath.row]];
   
    return cell;
}

#pragma mark ------
#pragma mark ---UITableViewDelegate---
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        
    [[SoundTools sharedSoundTools] playSoundWithName:@"ui_click_in"];

    TopLevelListModel *topLevelModel = [kDataArr objectAtIndex:indexPath.row];
    
    KnowledgeSelectViewController *knolwdgeSelectVC = [[KnowledgeSelectViewController alloc] init];
    knolwdgeSelectVC.delegate = self;
    knolwdgeSelectVC.kNameArr = kNameArr;
    knolwdgeSelectVC.kId = topLevelModel.kId;
    knolwdgeSelectVC.selIndexPath = indexPath;
    [self.navigationController pushViewController:knolwdgeSelectVC animated:YES];
}

-(void)passSelectIndexPath:(NSIndexPath *)indexPath
{
    selectRow = indexPath.row;
    [_myTableView reloadData];
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
