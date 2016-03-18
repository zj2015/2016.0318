//
//  TrainResultViewController.m
//  MRobot
//
//  Created by mac on 15/8/22.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "TrainResultViewController.h"
#import "TrainShareViewController.h"
#import "SubmitTableViewCell.h"
#import "SubmitWellTableViewCell.h"
#import "SubmitBadTableViewCell.h"
#import "SubmitBadViewController.h"
#import "LearnPlanViewController.h"

#import "SubmitWrongViewController.h"
#import "SubmitWrongTViewController.h"
#import "KVideoViewController.h"
@interface TrainResultViewController ()<SubmitWellTableViewCellDelegate>

@end

@implementation TrainResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self base_changeNavigationTitleWithString:@"Result"];
    
    NSString* date;
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    date = [formatter stringFromDate:[NSDate date]];
    
#if TARGET_VERSION_LITE ==1
    
    if ([UserDefaultsUtils boolValueWithKey:ISINNER]) {
        //target（中考校内版）需要执行的代码
        _arr = [[NSArray alloc]initWithObjects:@"Score:",@"Student’s name:",@"Class:",@"date:",nil];
        _arrRight = [[NSArray alloc]initWithObjects:[NSString stringWithFormat:@"%@",_weekModel.score],[UserDefaultsUtils valueWithKey:USER_NAME],[NSString stringWithFormat:@"%@%@",[UserDefaultsUtils valueWithKey:USER_CAMPUS],[UserDefaultsUtils valueWithKey:USER_CLASS]],date,nil];
    }else{
        //target（中考校外版）需要执行的代码
        _arr = [[NSArray alloc]initWithObjects:@"Score:",@"Student’s name:",@"date:",nil];
        _arrRight = [[NSArray alloc]initWithObjects:[NSString stringWithFormat:@"%@",_weekModel.score],[UserDefaultsUtils valueWithKey:USER_NAME],date,nil];
    }
    
#elif TARGET_VERSION_LITE ==2
    //target（中考校外版）需要执行的代码
    _arr = [[NSArray alloc]initWithObjects:@"Score:",@"Student’s name:",@"date:",nil];
    _arrRight = [[NSArray alloc]initWithObjects:[NSString stringWithFormat:@"%@",_weekModel.score],[UserDefaultsUtils valueWithKey:USER_NAME],date,nil];
    
#elif TARGET_VERSION_LITE ==3
    if ([UserDefaultsUtils boolValueWithKey:ISINNER]) {
        //target（高考校内版）需要执行的代码
        _arr = [[NSArray alloc]initWithObjects:@"Score:",@"Student’s name:",@"Class:",@"date:",nil];
        _arrRight = [[NSArray alloc]initWithObjects:[NSString stringWithFormat:@"%@",_weekModel.score],[UserDefaultsUtils valueWithKey:USER_NAME],[NSString stringWithFormat:@"%@%@",[UserDefaultsUtils valueWithKey:USER_CAMPUS],[UserDefaultsUtils valueWithKey:USER_CLASS]],date,nil];
    }else{
        //target（高考校外版）需要执行的代码
        _arr = [[NSArray alloc]initWithObjects:@"Score:",@"Student’s name:",@"date:",nil];
        _arrRight = [[NSArray alloc]initWithObjects:[NSString stringWithFormat:@"%@",_weekModel.score],[UserDefaultsUtils valueWithKey:USER_NAME],date,nil];
    }
    
#elif TARGET_VERSION_LITE ==4
    //target（高考校外版）需要执行的代码
    _arr = [[NSArray alloc]initWithObjects:@"Score:",@"Student’s name:",@"date:",nil];
    _arrRight = [[NSArray alloc]initWithObjects:[NSString stringWithFormat:@"%@",_weekModel.score],[UserDefaultsUtils valueWithKey:USER_NAME],date,nil];
    
#endif

    _badArray = [[NSArray alloc]initWithArray:_weekModel.resultArr];
}

-(void)base_navigation_LeftBarButtonPressed
{
    for (UIViewController *vcHome in self.navigationController.viewControllers) {
        if ([vcHome isKindOfClass:[LearnPlanViewController class]]) {
            [self.navigationController popToViewController:vcHome animated:YES];
        }
    }
}

-(void)_prepareUI
{
    
    CGRect rect = CGRectMake(0.0f,0.0f,MainScreenSize_W,MainScreenSize_H);
    _myTableView = [[UIFolderTableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.folderDelegate = self;
    _myTableView.backgroundColor = PView_BGColor;
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_myTableView];
    
    [aCommon tableViewsFooterView];
    [aCommon tableViewsBackGroundView];
}

#pragma mark  ---UITableViewDelegate--

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else {
        return _badArray.count;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (section == 0) {
        UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenSize_W, 10)];
        headView.backgroundColor = PView_BGColor;
        return headView;
    }else{
        UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenSize_W, 50)];
        headView.backgroundColor = PView_BGColor;
        UILabel * headLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, MainScreenSize_W - 40, 40)];
        headLabel.font = [UIFont systemFontOfSize:20];
        headLabel.text = @"Credits";
        headLabel.textAlignment = 1 ;
        [headLabel setTextColor:[UIColor colorWithRed:244/255.0f green:77/255.0f blue:22/255.0f alpha:1]];
        [headView addSubview:headLabel];
        return headView;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    }else{
        return 50;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        NSString *identifier = @"identifier6";
        SubmitTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            // 重写了cell 的init 方法
            cell = [[SubmitTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        }
//        [cell addCellData:_arrRight[indexPath.row] andTitle:_arr[indexPath.row]];
        [cell addCellDataNew:_arrRight andTitle:_arr];

        if (indexPath.row == 0) {
            cell.rightLabel.textColor = PView_RedColor;
            cell.rightLabel.font = [UIFont boldSystemFontOfSize:16];
        }
    
        return cell;
        
    }else{
    
        NSString *identifier = @"identifier2";
        SubmitWellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            // 重写了cell 的init 方法
            cell = [[SubmitWellTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        }
        ResultListModel *listModel = _badArray[indexPath.row];
        cell.bgView.tag = indexPath.row;
        cell.delegate = self;
        [cell addCellData:[NSString stringWithFormat:@"%ld.  %@",indexPath.row + 1,listModel.kName] andArray:listModel.wrongQIdList];
        if (indexPath.row%2==0) {
            
            cell.contentView.backgroundColor = [UIColor lightGrayColor];
            
        }
        return cell;
    }
}

#pragma mark   ---UITableViewDataSource---

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        ResultListModel *listModel = _badArray[indexPath.row];
        return [SubmitWellTableViewCell heightForCell:listModel.wrongQIdList];
    }else{
        return 300;
    }
    
}

- (void)chooseBadQuestion:(UITapGestureRecognizer *)tap
{
    UILabel *label = (UILabel *)tap.view;
    label.backgroundColor = [UIColor lightGrayColor];
    
    ResultListModel *listModel = _badArray[selectRow];
    
    SubmitWrongTViewController *submitWrongVC = [[SubmitWrongTViewController alloc]init];
    submitWrongVC.wrongId = [listModel.wrongQIdList objectAtIndex:tap.view.tag];
    submitWrongVC.questionModel = _questionModel;
    submitWrongVC.optionsArr = _answerArray;
    [self.navigationController pushViewController:submitWrongVC animated:YES];
    [[SoundTools sharedSoundTools] playSoundWithName:@"ui_click_in"];

    
}

#pragma mark ---SubmitWellTableViewCellDelegate---

- (void)chooseWhichQuestion:(UITapGestureRecognizer *)index andTag:(NSInteger)indexPath
{
    [[SoundTools sharedSoundTools] playSoundWithName:@"ui_click_in"];

    
    UILabel *label = (UILabel *)index.view;
    label.backgroundColor = [UIColor lightGrayColor];
    ResultListModel *listModel = _badArray[indexPath];
    SubmitWrongTViewController *submitWrongVC = [[SubmitWrongTViewController alloc]init];
    submitWrongVC.wrongId = [listModel.wrongQIdList objectAtIndex:index.view.tag];
    submitWrongVC.questionModel = _questionModel;
    submitWrongVC.optionsArr = _answerArray;
    submitWrongVC.answerArr = _answerArr;
    NSMutableArray *count = [NSMutableArray array];
    for (NSString * str in listModel.wrongQIdList) {
        [count addObject:str];
        if ([submitWrongVC.wrongId isEqualToString:str]) {
            submitWrongVC.location = (int)count.count;
        }
    }
    submitWrongVC.errorIdArray = count;
    [self.navigationController pushViewController:submitWrongVC animated:YES];

}

- (void)choosePlayVoice:(NSInteger)indexpath
{
    [[SoundTools sharedSoundTools] playSoundWithName:@"ui_click_in"];

    
    ResultListModel *listModel = _badArray[indexpath];
    KVideoViewController *knowledgeVC = [[KVideoViewController alloc]init];
    knowledgeVC.kId = listModel.kId;
    knowledgeVC.kName = listModel.kName;
    [self.navigationController pushViewController:knowledgeVC animated:YES];

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
