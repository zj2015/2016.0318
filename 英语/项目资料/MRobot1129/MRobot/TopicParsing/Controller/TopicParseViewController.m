//
//  TopicParseViewController.m
//  MRobot
//
//  Created by mac on 15/8/19.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "TopicParseViewController.h"
#import "TopicHeadView.h"
#import "TopicParseTableViewCell.h"
#import "TopQTypeListModel.h"
#import "TopicVideoViewController.h"
#import "TopQTypeResultModel.h"
#import "TopQTypeChildModel.h"

@interface TopicParseViewController ()

@end

@implementation TopicParseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self base_changeNavigationTitleWithString:@"题型选择"];
    
}

- (void)_prepareData
{
    [self showAlertHUD:@"正在加载..."];
    LearningPlanRequest *topQListRequest = [[LearningPlanRequest alloc] init];
    [topQListRequest userTopQTypeListSuccess:^(id obj) {
        InfoResult *infoResult = (InfoResult *)obj;
        if ([infoResult.code isEqualToString:@"0"]) {
            TopQTypeListModel *topQTypeListModel = [[TopQTypeListModel alloc]init];
            topQTypeListModel = (TopQTypeListModel *)[infoResult extraObj];
            
            resultArr = topQTypeListModel.resultArray;
    
            openedInSectionArr = [NSMutableArray array];
            for (int i=0; i< [resultArr count]; i++) {
                if (i == 0) {
                    [openedInSectionArr addObject:@"1"];
                }else{
                    [openedInSectionArr addObject:@"0"];
                }
            }
            preHeaderIndex = 0;
            [_myTableView reloadData];
            
        }else{
            [aCommon iToast:@"加载失败!"];
        }
    } failed:^(id obj) {
        [aCommon iToast:@"系统未知错误!"];
    }];
}

- (void)_prepareUI
{
    CGRect rect = CGRectMake(0,0,MainScreenSize_W,MainScreenSize_H);
    _myTableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.rowHeight = TopicParseCellHeight;
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _myTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_myTableView];
    
    // 改变 tableView的背景色
    _myTableView.backgroundView = [aCommon tableViewsBackImageView];
    
    //去掉多余的分割线
    _myTableView.tableFooterView = [aCommon tableViewsFooterView];
}

#pragma mark ------
#pragma mark ---UITableViewDataSource---

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([resultArr count]) {
        _myTableView.backgroundView = [aCommon tableViewsBackGroundView];
        return [resultArr count];
    }else{
        return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([[openedInSectionArr objectAtIndex:section] intValue] == 1) {
        if ([resultArr count] != 0) {
            TopQTypeResultModel *topQTypeResultModel = resultArr[section];
            return [topQTypeResultModel.childTypeArray count];
        }else{
            return 0;
        }
    }else{
        return 0;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *identifier = @"identifier";
    TopicParseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[TopicParseTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;//取消选中
    }
    
    if (resultArr) {
        TopQTypeResultModel *topQTypeResultModel = resultArr[indexPath.section];
        TopQTypeChildModel *topQTypeChildModel = topQTypeResultModel.childTypeArray [indexPath.row];
        cell.topicNameLab.text = topQTypeChildModel.tName;
        
    }
    cell.signImgView.image = [UIImage imageNamed:@"jxVideo"];
    
    return cell;
}

#pragma mark ------
#pragma mark ---UITableViewDelegate---

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    
    TopicHeadView *headView = [TopicHeadView headViewWithTableView:tableView withBlock:^(NSInteger tag) {
        
        if ([[openedInSectionArr objectAtIndex:tag] intValue] == 0) {
            
            [[SoundTools sharedSoundTools] playSoundWithName:@"ui_on"];

            
            [openedInSectionArr replaceObjectAtIndex:preHeaderIndex withObject:@"0"];//将上一个被点击的区置为闭合状态
            [openedInSectionArr replaceObjectAtIndex:tag withObject:@"1"];
            
            preHeaderIndex = tag;
            
            
        }
        else
        {
            
            [[SoundTools sharedSoundTools] playSoundWithName:@"ui_off"];
            
            [openedInSectionArr replaceObjectAtIndex:tag withObject:@"0"];
        }
        [_myTableView reloadData];
    }];
    headView.contentView.tag = section;
    
    TopQTypeResultModel *topQTypeResultModel = resultArr[section];
    headView.topicNameLab.text = [NSString stringWithFormat:@"%@",topQTypeResultModel.tName];
//    [headView.topicNameLab setTextColor:[UIColor grayColor]];
    
    if ([[openedInSectionArr objectAtIndex:section] intValue] == 1){
        headView.signImgView.image = [UIImage imageNamed:@"greenShow"];
//        headView.topicNameLab.textColor = RgbColor(0, 179, 138);
        [headView.signImgView setFrame:CGRectMake(headView.signImgView.frame.origin.x,headView.signImgView.frame.origin.y,17*SIZE_TIMES, 17*SIZE_TIMES/2)];
        headView.topicNameLab.textColor = [UIColor redColor];
        
    }else{
        
        headView.signImgView.image = [UIImage imageNamed:@"grayHide"];
        [headView.signImgView setFrame:CGRectMake(headView.signImgView.frame.origin.x,headView.signImgView.frame.origin.y,17*SIZE_TIMES/2, 17*SIZE_TIMES)];
        headView.topicNameLab.textColor = [UIColor grayColor];
        
    }
    
    if (section%2==1) {
        [headView.contentView setBackgroundColor:[UIColor lightGrayColor]];
    }
   
    return headView;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    [[SoundTools sharedSoundTools] playSoundWithName:@"ui_click_in"];
    
    TopicVideoViewController *topicVideoVC = [[TopicVideoViewController alloc] init];
    TopQTypeResultModel *topQTypeResultModel = resultArr[indexPath.section];
    TopQTypeChildModel *topQTypeChildModel = topQTypeResultModel.childTypeArray [indexPath.row];
    topicVideoVC.tId = topQTypeChildModel.tId;
    topicVideoVC.tName = topQTypeChildModel.tName;
    [self.navigationController pushViewController:topicVideoVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TopicParseCellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return TopicParseCellHeight;
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
