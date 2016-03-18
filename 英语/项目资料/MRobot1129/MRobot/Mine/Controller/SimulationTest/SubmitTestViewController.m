//
//  SubmitTestViewController.m
//  MRobot
//
//  Created by mac on 15/10/19.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "SubmitTestViewController.h"
#import "PICircularProgressView.h"
#import "SubmitTestViewCell.h"
#import "SubmitWrongViewController.h"
@interface SubmitTestViewController ()<SubmitTestViewCellDelegate>

@end

@implementation SubmitTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self base_changeNavigationTitleWithString:@"模拟测试成绩"];
}

- (void)base_navigation_LeftBarButtonPressed
{
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}

- (UIView *)createHeadView
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenSize_W, 270)];
    
    UIImageView *logoImgView = [[UIImageView alloc] initWithFrame:CGRectMake((MainScreenSize_W - 195)/2, 10, 195, 59)];
    logoImgView.image = [UIImage imageNamed:@"LOGO"];
    [headView addSubview:logoImgView];
    
    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake((MainScreenSize_W - 200)/2, 80, 200, 20)];
    nameLab.text = [NSString stringWithFormat:@"%@  %@",[UserDefaultsUtils valueWithKey:USER_CAMPUS],[UserDefaultsUtils valueWithKey:USER_NAME]];
    nameLab.textColor = [UIColor colorWithRed:138/255.0 green:4/255.0 blue:16/255.0 alpha:1];
    nameLab.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:nameLab];
    
    UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 105, MainScreenSize_W-20, 1)];
    lineLab.backgroundColor = [UIColor colorWithRed:221/255.0 green:220/255.0 blue:221/255.0 alpha:1];
    [headView addSubview:lineLab];
    
    PICircularProgressView *progressView = [[PICircularProgressView alloc] initWithFrame:CGRectMake((MainScreenSize_W - 65)/2, 115.0f, 65.0f, 65.0f)];
    progressView.progressFillColor = [UIColor colorWithRed:170/255.0 green:22/255.0 blue:24/255.0 alpha:1];
    progressView.innerBackgroundColor = [UIColor colorWithRed:251/255.0 green:157/255.0 blue:160/255.0 alpha:0.5];
    progressView.outerBackgroundColor = [UIColor whiteColor];
    progressView.textColor = [UIColor colorWithRed:170/255.0 green:22/255.0 blue:24/255.0 alpha:1];
    progressView.progress = ([self.score floatValue])/100;
    progressView.text = self.score;
    [headView addSubview:progressView];
    
    UILabel *scoreLab = [[UILabel alloc] initWithFrame:CGRectMake((MainScreenSize_W - 65)/2 + 50, 150, 15, 15)];
    scoreLab.text = @"分";
    scoreLab.textColor = [UIColor grayColor];
    scoreLab.font = [UIFont systemFontOfSize:11];
    [headView addSubview:scoreLab];
    
    UILabel *examLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 185, MainScreenSize_W, 20)];
    examLabel.text = _submitTitle;
    examLabel.textAlignment = NSTextAlignmentCenter;
    examLabel.font = [UIFont systemFontOfSize:16];
    [headView addSubview:examLabel];
    
    UILabel *beatLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 210, MainScreenSize_W, 20)];
    beatLab.text = [NSString stringWithFormat:@"本次得分: %@分",self.score];
    beatLab.textAlignment = NSTextAlignmentCenter;
    beatLab.font = [UIFont systemFontOfSize:15];
    [headView addSubview:beatLab];
    
    UIImageView * flagView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 240, 160, 25)];
    flagView.image = [UIImage imageNamed:@"submittest"];
    [headView addSubview:flagView];

    return headView;
}

- (void)_prepareUI
{
    CGRect rect = CGRectMake(MainSreenOrigin_X,MainSreenOrigin_Y,MainScreenSize_W,MainScreenSize_H);
    _myTableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.tableHeaderView = [self createHeadView];
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_myTableView];
    
    // 改变 tableView的背景色
    UIView * backColorView = [[UIView alloc] init];
    backColorView.backgroundColor = [UIColor whiteColor];
    _myTableView.backgroundView = backColorView;
    
    //去掉多余的分割线
    _myTableView.tableFooterView = [aCommon tableViewsFooterView];
}

#pragma mark ------
#pragma mark ---UITableViewDataSource---

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _questionArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"identifier";
    SubmitTestViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        // 重写了cell 的init 方法
        cell = [[SubmitTestViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    cell.bgView.tag = indexPath.row;
    cell.delegate = self;
    [cell addCellData:_questionArr andArray:_answerTrueArr andLastCount:indexPath.row];
    return cell;
}

#pragma mark ------
#pragma mark ---UITableViewDelegate---
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = _questionArr[indexPath.row];
    return [SubmitTestViewCell heightForCell:dict[@"1"]];
}


#pragma mark ---SubmitTestViewCellDelegate---

- (void)chooseWhichQuestion:(UITapGestureRecognizer *)index andTag:(NSInteger)indexPath
{
    
    [[SoundTools sharedSoundTools] playSoundWithName:@"ui_click_in"];

    SubmitWrongViewController *submitWrongVC = [[SubmitWrongViewController alloc]init];
    submitWrongVC.questionModel = _questionModel;
    submitWrongVC.optionsArr = _answerArr;
    submitWrongVC.page = (int)index.view.tag;
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
