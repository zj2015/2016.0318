//
//  TrainResultTwoViewController.m
//  MRobot
//
//  Created by mac on 15/8/22.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "TrainResultTwoViewController.h"
#import "ExerciseTrainViewController.h"
#import "SubmitTableViewCell.h"
#import "SubmitWellTableViewCell.h"
#import "SubmitBadTableViewCell.h"
#import "SubmitWrongTViewController.h"
#import "TrainShareViewController.h"
#import "KVideoViewController.h"

#import "KnowledgeSelectViewController.h"
#import "ErrorKnowledgeViewController.h"
@interface TrainResultTwoViewController ()<SubmitBadTableViewCellDelegate>

@end

@implementation TrainResultTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self base_changeNavigationTitleWithString:@"Result"];
    
//    [self base_createRightNavigationBarButtonWithFrontImage:@"share" andSelectedImageName:nil andBackGroundImageName:@"share" andTitle:nil andSize:CGSizeMake(30, 30)];
    
    NSString* date;
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    date = [formatter stringFromDate:[NSDate date]];
    _arr = [[NSArray alloc]initWithObjects:@"训练成绩:",@"学       生:",@"知 识 点:",@"训练时间:" ,nil];
    _arrRight = [[NSArray alloc]initWithObjects:[NSString stringWithFormat:@"%@",_submitModel.score],[UserDefaultsUtils valueWithKey:USER_NAME],_kName,date,nil];
    
     _badArray = [[NSArray alloc]initWithArray:_submitModel.wrongQIdList];
}

-(void)base_navigation_LeftBarButtonPressed
{
//    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    if (_fromType == 0) {
        for (UIViewController *vcHome in self.navigationController.viewControllers) {
            if ([vcHome isKindOfClass:[KnowledgeSelectViewController class]]) {
                [self.navigationController popToViewController:vcHome animated:YES];
            }
        }
    }else if (_fromType == 1) {
        for (UIViewController *vcHome in self.navigationController.viewControllers) {
            if ([vcHome isKindOfClass:[ErrorKnowledgeViewController class]]) {
                [self.navigationController popToViewController:vcHome animated:YES];
            }
        }
    }
    
}

-(void)_prepareUI
{
    
    CGRect rect = CGRectMake(0.0f,0.0f,MainScreenSize_W,MainScreenSize_H);
    _myTableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.backgroundColor = [UIColor clearColor];
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_myTableView];
    
    [aCommon tableViewsFooterView];
    [aCommon tableViewsBackGroundView];

}

#pragma mark ---UITableViewDataSource---

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_badArray.count != 0){
        return 2;
    }else{
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_badArray.count != 0) {
        if (section == 0) {
            return _arr.count;
        }else{
            return 1;
        }
    }else{
        return _arr.count;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (_badArray.count != 0) {
        if (section == 0) {
            UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenSize_W, 10)];
            headView.backgroundColor = PView_BGColor;
            return headView;
        }else{
            UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenSize_W, 50)];
            headView.backgroundColor = PView_BGColor;
            
            UILabel * headLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, MainScreenSize_W - 90, 40)];
            headLabel.font = [UIFont systemFontOfSize:16];
            headLabel.text = @"我的错题:";
            [headView addSubview:headLabel];
            
            UIButton *playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            playBtn.frame = CGRectMake(headLabel.right, 0, 45, 45);
            [playBtn setImage:[UIImage imageNamed:@"video-1"] forState:UIControlStateNormal];
            [playBtn addTarget:self action:@selector(clickPlayButtonWIthVideo:) forControlEvents:UIControlEventTouchUpInside];
            [headView addSubview:playBtn];
            
            return headView;
        }
    }else{
        UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenSize_W, 10)];
        headView.backgroundColor = PView_BGColor;
        return headView;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_badArray.count != 0) {
        if (section == 0) {
            return 10;
        }else{
            return 50;
        }
    }else{
        return 10;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_badArray.count != 0) {
        if (indexPath.section == 1) {
            if (_badArray.count%8) {
                return (_badArray.count/8+1)*30*SIZE_TIMES+(_badArray.count/8+2)*10;
            }else{
                return (_badArray.count/8)*30*SIZE_TIMES+(_badArray.count/8+1)*10;
            }
        }else{
            return 44;
        }
    }else{
        return 44;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_badArray.count != 0) {
        if (indexPath.section == 0) {
            NSString *identifier = @"identifier1";
            SubmitTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                // 重写了cell 的init 方法
                cell = [[SubmitTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
            }
            [cell addCellData:_arrRight[indexPath.row] andTitle:_arr[indexPath.row]];
            if (indexPath.row == 0) {
                cell.rightLabel.textColor = PView_RedColor;
                cell.rightLabel.font = [UIFont boldSystemFontOfSize:16];
            }
            return cell;
        }else{
            
            NSString *identifier = @"identifier3";
            SubmitBadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                // 重写了cell 的init 方法
                cell = [[SubmitBadTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
            }
            cell.bgView.tag = indexPath.row/2;
            cell.delegate = self;
            [cell addCellData:_badArray];
            return cell;
            
        }
    }else{
        
        NSString *identifier = @"identifier3";
        SubmitTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            // 重写了cell 的init 方法
            cell = [[SubmitTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        }
        [cell addCellData:_arrRight[indexPath.row] andTitle:_arr[indexPath.row]];
        if (indexPath.row == 0) {
            cell.rightLabel.textColor = PView_RedColor;
            cell.rightLabel.font = [UIFont boldSystemFontOfSize:16];
        }
        return cell;
    }
    return nil;
    
}


#pragma mark   ---UITableViewDataSource---

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark   ---SubmitBadTableViewCellDelegate---

- (void)submitBadTableViewCellDelegateWithTap:(UIView *)tapView withIndexRow:(int)row withWrongID:(NSString *)wrongId
{
    [[SoundTools sharedSoundTools] playSoundWithName:@"ui_click_in"];

    
    SubmitWrongTViewController * submitWrongVC = [[SubmitWrongTViewController alloc]init];
    submitWrongVC.wrongId = wrongId;
    submitWrongVC.questionModel = _questionModel;
    submitWrongVC.optionsArr = _answerArray;
    NSMutableArray *count = [NSMutableArray array];
    for (NSString *str in _submitModel.wrongQIdList) {
        [count addObject:str];
        if ([str isEqualToString:submitWrongVC.wrongId]) {
            submitWrongVC.location = (int)count.count;
        }
    }
    submitWrongVC.errorIdArray = count;
    [self.navigationController pushViewController:submitWrongVC animated:YES];
}

- (void)clickPlayButtonWIthVideo:(UIButton *)btn
{
    PLog(@"知识点重新训练按钮====播放视频");
    KVideoViewController *knowledgeVC = [[KVideoViewController alloc]init];
    knowledgeVC.kId = _kId;
    knowledgeVC.kName = _kName;
    [self.navigationController pushViewController:knowledgeVC animated:YES];
    [[SoundTools sharedSoundTools] playSoundWithName:@"ui_click_in"];

}

- (void)base_navigation_RightBarButtonPressed
{
    
    [[SoundTools sharedSoundTools] playSoundWithName:@"ui_click_in"];

    TrainShareViewController *shareVC = [[TrainShareViewController alloc] init];
    shareVC.score = _submitModel.score;
    shareVC.highScore = _submitModel.highestScore;
    shareVC.beatPercent = _submitModel.beatPercent;
    [self.navigationController pushViewController:shareVC animated:YES];

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
