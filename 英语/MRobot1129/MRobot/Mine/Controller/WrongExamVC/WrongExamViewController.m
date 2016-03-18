//
//  WrongExamViewController.m
//  ERobot
//
//  Created by BaiYu on 15/7/1.
//  Copyright (c) 2015年 BaiYu. All rights reserved.
//

#import "WrongExamViewController.h"
#import "WrongExamTableViewCell.h"
#import "DateListModel.h"
#import "WrongQueListModel.h"
#import "WrongQueDataModel.h"
//#import "WrongQuestionViewController.h"
#import "ErrorTopicSetViewController.h"
@interface WrongExamViewController ()

@end

@implementation WrongExamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self base_changeNavigationTitleWithString:@"我的错题库"];
    
    pageIndex = 0;
    _moreDataArr = [[NSMutableArray alloc] initWithCapacity:0];
    
    wrongExamTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MainScreenSize_W, MainScreenSize_H) style:UITableViewStylePlain];
    wrongExamTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    wrongExamTableView.rowHeight = 50*SIZE_TIMES;
    wrongExamTableView.dataSource = self;
    wrongExamTableView.delegate = self;
    [self.view addSubview:wrongExamTableView];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //8.错题库(按月份返回最新的三个错题)
    LearningPlanRequest *wrongLibRequest = [[LearningPlanRequest alloc] init];
    [wrongLibRequest userWrongLibraySuccess:^(id obj) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        InfoResult *infoResult = (InfoResult *)obj;
        if ([infoResult.code isEqualToString:@"0"]) {
            DateListModel *dateListModel = [[DateListModel alloc] init];
            dateListModel = (DateListModel *)[infoResult extraObj];
            
            sectionArr = dateListModel.dateListArr;
            
            //默认存储0 闭合状态
            openedInSectionArr = [NSMutableArray array];
            for (int i=0; i< [sectionArr count]; i++) {
                if (i == 0) {
                    [openedInSectionArr addObject:@"1"];
                }else{
                    [openedInSectionArr addObject:@"0"];
                }
            }
        }
        
        [wrongExamTableView reloadData];
        
    } failed:^(id obj) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}
#pragma make -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([[openedInSectionArr objectAtIndex:section] intValue] == 1 && section == headerBtnTag) {
        WrongQueListModel *wrongListModel = [sectionArr objectAtIndex:section];
        _dataArr = wrongListModel.wrongQueListArr;
        
        if (isShowMore) {
            WrongQueListModel *wrongListModel = [[WrongQueListModel alloc] init];
            wrongListModel = [sectionArr objectAtIndex:section];
            
            if ([_moreDataArr count] == [wrongListModel.wrongAmount integerValue]) {
                return [_moreDataArr count];
            }
            return [_moreDataArr count] +1;
        }
        if ([_dataArr count] != 0) {
            NSInteger wrongAmount = [wrongListModel.wrongAmount integerValue];
            if (self.dataArr.count >= wrongAmount) {
                return [self.dataArr count];
            }else{
                return [self.dataArr count] +1;
            }
            
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellIndentifier = @"WrongExamCell";
    WrongExamTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[WrongExamTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (isShowMore == YES) {//显示更多
        if (indexPath.section == moreBtnTag) {//当前所点的区
            WrongQueListModel *wrongListModel = [[WrongQueListModel alloc] init];
            wrongListModel = [sectionArr objectAtIndex:indexPath.section];
            
            if ([_moreDataArr count] == [wrongListModel.wrongAmount integerValue]) {//当前显示的更多数据数量等于错题总数量时 显示更多按钮隐藏
                cell.rowView.hidden = NO;
                cell.moreBtn.hidden = YES;
                
                WrongQueDataModel *wrongDataModel = [[WrongQueDataModel alloc] init];
                wrongDataModel = _moreDataArr[indexPath.row];
                cell.contentLab.text = [NSString filterHTML:wrongDataModel.qContent];
                if (wrongDataModel.qContentPicUrl) {
                    cell.contentLab.frame = CGRectMake(20+30*SIZE_TIMES, 10*SIZE_TIMES, MainScreenSize_W - 40 - 60*SIZE_TIMES, 30*SIZE_TIMES);
                    [cell.rightImageView setImageWithURL:[NSURL URLWithString:[wrongDataModel.qContentPicUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:nil];
                }else{
                    if (wrongDataModel.qContentPicUrl) {
                        cell.contentLab.frame = CGRectMake(20+30*SIZE_TIMES, 10*SIZE_TIMES, MainScreenSize_W - 20 - 30*SIZE_TIMES, 30*SIZE_TIMES);
                    }
                }
                if (wrongDataModel.qType == 0) {
                    cell.leftSignLab.text = @"选";
                }else if (wrongDataModel.qType == 1){
                    cell.leftSignLab.text = @"填";
                }else if (wrongDataModel.qType == 2){
                    cell.leftSignLab.text = @"阅";
                }else{
                    cell.leftSignLab.text = @"听";
                }
            }else{
                if (indexPath.row == [_moreDataArr count]) {//更多数据没有加载完时 显示更多按钮不隐藏
                    cell.rowView.hidden = YES;
                    cell.moreBtn.hidden = NO;
                    cell.moreBtn.tag = indexPath.section;
                    moreBtnTag = cell.moreBtn.tag;
                    [cell.moreBtn addTarget:self action:@selector(showMoreQuestion:) forControlEvents:UIControlEventTouchUpInside];
                    
                }else{
                    cell.rowView.hidden = NO;
                    cell.moreBtn.hidden = YES;
                    
                    WrongQueDataModel *wrongDataModel = [[WrongQueDataModel alloc] init];
                    wrongDataModel = _moreDataArr[indexPath.row];
                    cell.contentLab.text = [NSString filterHTML:wrongDataModel.qContent];
                    if (wrongDataModel.qContentPicUrl) {
                        cell.contentLab.frame = CGRectMake(20+30*SIZE_TIMES, 10*SIZE_TIMES, MainScreenSize_W - 40 - 60*SIZE_TIMES, 30*SIZE_TIMES);
                        [cell.rightImageView setImageWithURL:[NSURL URLWithString:[wrongDataModel.qContentPicUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:nil];
                    }else{
                        if (wrongDataModel.qContentPicUrl) {
                            cell.contentLab.frame = CGRectMake(20+30*SIZE_TIMES, 10*SIZE_TIMES, MainScreenSize_W - 20 - 30*SIZE_TIMES, 30*SIZE_TIMES);
                        }
                    }
                    if (wrongDataModel.qType == 0) {
                        cell.leftSignLab.text = @"选";
                    }else if (wrongDataModel.qType == 1){
                        cell.leftSignLab.text = @"填";
                    }else if (wrongDataModel.qType == 2){
                        cell.leftSignLab.text = @"阅";
                    }else{
                        cell.leftSignLab.text = @"听";
                    }
                }
            }
        }
    }else{
        if (indexPath.row == [_dataArr count]) {
            cell.rowView.hidden = YES;
            cell.moreBtn.hidden = NO;
            cell.moreBtn.tag = indexPath.section;
            moreBtnTag = cell.moreBtn.tag;
            [cell.moreBtn addTarget:self action:@selector(showMoreQuestion:) forControlEvents:UIControlEventTouchUpInside];
        }else{
            cell.rowView.hidden = NO;
            cell.moreBtn.hidden = YES;
            
            WrongQueDataModel *wrongDataModel = [[WrongQueDataModel alloc] init];
            wrongDataModel = _dataArr[indexPath.row];
            cell.contentLab.text = [NSString filterHTML:wrongDataModel.qContent];
            if (wrongDataModel.qContentPicUrl) {
                cell.contentLab.frame = CGRectMake(20+30*SIZE_TIMES, 10*SIZE_TIMES, MainScreenSize_W - 40 - 60*SIZE_TIMES, 30*SIZE_TIMES);
                [cell.rightImageView setImageWithURL:[NSURL URLWithString:[wrongDataModel.qContentPicUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:nil];
            }else{
                if (wrongDataModel.qContentPicUrl) {
                    cell.contentLab.frame = CGRectMake(20+30*SIZE_TIMES, 10*SIZE_TIMES, MainScreenSize_W - 20 - 30*SIZE_TIMES, 30*SIZE_TIMES);
                }
            }
            if (wrongDataModel.qType == 0) {
                cell.leftSignLab.text = @"选";
            }else if (wrongDataModel.qType == 1){
                cell.leftSignLab.text = @"填";
            }else if (wrongDataModel.qType == 2){
                cell.leftSignLab.text = @"阅";
            }else{
                cell.leftSignLab.text = @"听";
            }
        }
    }
    return cell;
}
#pragma make -UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return sectionArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50*SIZE_TIMES;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainScreenSize_W, 50*SIZE_TIMES)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UIButton * heightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    heightButton.frame = CGRectMake(0, 0, MainScreenSize_W, 50*SIZE_TIMES);
    heightButton.tag = section;
    [heightButton addTarget:self action:@selector(headerClick:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:heightButton];
    
    WrongQueListModel *wrongListModel = [[WrongQueListModel alloc] init];
    wrongListModel = [sectionArr objectAtIndex:section];
    
    UILabel *dateLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 50*SIZE_TIMES)];
    NSArray *dateArr = [[NSString makeTimeWithYear:wrongListModel.monthTimeStamp] componentsSeparatedByString:@"-"];
    dateLab.text = [NSString stringWithFormat:@"%@年%@月",dateArr[0],dateArr[1]];
    [headerView addSubview:dateLab];
 
    UILabel * radius = [[UILabel alloc] initWithFrame:CGRectMake(MainScreenSize_W - 75, 10*SIZE_TIMES, 30*SIZE_TIMES , 30*SIZE_TIMES)];
    radius.backgroundColor = [UIColor colorWithRed:145/255.0 green:0 blue:4/255.0 alpha:1.0];
    radius.layer.cornerRadius = 15*SIZE_TIMES;
    radius.clipsToBounds = YES;
    radius.text = wrongListModel.wrongAmount;
    radius.textColor = [UIColor whiteColor];
    radius.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:radius];
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(MainScreenSize_W-30, 15*SIZE_TIMES, 20*SIZE_TIMES, 20*SIZE_TIMES)];
    imageView.image = [UIImage imageNamed:@"hide"];
    [headerView addSubview:imageView];
    
    if ([[openedInSectionArr objectAtIndex:section] intValue] == 1  && section == headerBtnTag) {
        imageView.image = [UIImage imageNamed:@"greenShow"];
        [imageView setFrame:CGRectMake(MainScreenSize_W-30, 15*SIZE_TIMES, 20*SIZE_TIMES, 20*SIZE_TIMES/2.0f)];
    }else{
        imageView.image = [UIImage imageNamed:@"grayHide"];
        [imageView setFrame:CGRectMake(MainScreenSize_W-30, 15*SIZE_TIMES, 20*SIZE_TIMES/2.0f, 20*SIZE_TIMES)];

    }
    
    UILabel * line = [[UILabel alloc] initWithFrame:CGRectMake(0, 49*SIZE_TIMES, MainScreenSize_W, 1*SIZE_TIMES)];
    line.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    [headerView addSubview:line];
    
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    [[SoundTools sharedSoundTools] playSoundWithName:@"ui_click_in"];

    PLog(@"%ld",indexPath.row);
    
    WrongQueListModel *wrongListModel = [sectionArr objectAtIndex:indexPath.section];
    _dataArr = wrongListModel.wrongQueListArr;
    
    if (isShowMore) {
        
        if (_moreDataArr.count <= indexPath.row) {
            
        }else{
            WrongQueListModel *wrongListModel = [[WrongQueListModel alloc] init];
            wrongListModel = [sectionArr objectAtIndex:indexPath.section];
            
            if ([_moreDataArr count] == [wrongListModel.wrongAmount integerValue]) {
                WrongQueDataModel *wrongDataModel = [[WrongQueDataModel alloc] init];
                wrongDataModel = _moreDataArr[indexPath.row];
                
                ErrorTopicSetViewController *errorTopic = [[ErrorTopicSetViewController alloc]init];
                errorTopic.qId = wrongDataModel.qId;
                errorTopic.witchVC = @"我的错题库";
                errorTopic.monthTimeStamp = wrongListModel.monthTimeStamp;
                [self.navigationController pushViewController:errorTopic animated:YES];
                return ;
            }
            WrongQueDataModel *wrongDataModel = [[WrongQueDataModel alloc] init];
            wrongDataModel = _moreDataArr[indexPath.row];
            
            ErrorTopicSetViewController *errorTopic = [[ErrorTopicSetViewController alloc]init];
            errorTopic.qId = wrongDataModel.qId;
            errorTopic.witchVC = @"我的错题库";
            errorTopic.monthTimeStamp = wrongListModel.monthTimeStamp;
            [self.navigationController pushViewController:errorTopic animated:YES];
            
        }
        return ;
    }else if ([_dataArr count] != 0) {
        if (_dataArr.count <= indexPath.row) {
            
        }else{
            WrongQueDataModel *wrongDataModel = [[WrongQueDataModel alloc] init];
            wrongDataModel = _dataArr[indexPath.row];
            
            ErrorTopicSetViewController *errorTopic = [[ErrorTopicSetViewController alloc]init];
            errorTopic.qId = wrongDataModel.qId;
            errorTopic.witchVC = @"我的错题库";
            errorTopic.monthTimeStamp = wrongListModel.monthTimeStamp;
            [self.navigationController pushViewController:errorTopic animated:YES];
        }
        return ;
    }
}

- (void)headerClick:(UIButton *)headerClick
{
    if (headerClick.tag != headerBtnTag) {
        
        [_moreDataArr removeAllObjects];//点击不同的区时 将之前的数据清0
        pageIndex = 0;
    
        if (isShowMore == YES) {
            isShowMore = NO;//刷新过区之后将“是否显示更多”置为否
        }
    }
    
    if ([[openedInSectionArr objectAtIndex:headerClick.tag] intValue] == 0) {
        [openedInSectionArr replaceObjectAtIndex:headerBtnTag withObject:@"0"];//将上一个被点击的区置为闭合状态
        [openedInSectionArr replaceObjectAtIndex:headerClick.tag withObject:@"1"];
    }
    else
    {
        [openedInSectionArr replaceObjectAtIndex:headerClick.tag withObject:@"0"];
    }
    headerBtnTag = headerClick.tag;
    [wrongExamTableView reloadData];
}

-(void)showMoreQuestion:(UIButton *)btn
{
    isShowMore = YES;
    
    WrongQueListModel *wrongListModel = [sectionArr objectAtIndex:btn.tag];

//    //10.根据月份查询错题库
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    LearningPlanRequest *request = [[LearningPlanRequest alloc]init];

    [request userMonthWrongLibrayWithMonthTimeStamp:wrongListModel.monthTimeStamp andPageIndex:[NSString stringWithFormat:@"%ld",(long)pageIndex] andPageSize:@"10" success:^(id obj) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        InfoResult *infoResult = (InfoResult *)obj;
        if ([infoResult.code isEqualToString:@"0"]) {
            WrongQueListModel *wrongQueListModel = [[WrongQueListModel alloc] init];
            wrongQueListModel = (WrongQueListModel *)[infoResult extraObj];
            
            for (int i = 0; i < [wrongQueListModel.wrongQueListArr count]; i++) {
                WrongQueDataModel *wrongDataModel = [[WrongQueDataModel alloc] init];
                wrongDataModel = [wrongQueListModel.wrongQueListArr objectAtIndex:i];
                [_moreDataArr addObject:wrongDataModel];
            }
        }
        
        pageIndex ++;
        NSIndexSet * indexSet = [NSIndexSet indexSetWithIndex:btn.tag];
        [wrongExamTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];

    } failed:^(id obj) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    }];
}

-(void)leftBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
