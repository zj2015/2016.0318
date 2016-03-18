//
//  TeachContentViewController.m
//  ERobot
//
//  Created by BaiYu on 15/6/30.
//  Copyright (c) 2015年 BaiYu. All rights reserved.
//

#import "TeachContentViewController.h"
#import "TeachContentCell.h"

@interface TeachContentViewController ()

@end

@implementation TeachContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self base_changeNavigationTitleWithString:@"教学内容"];
    self.view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    
}

-(void)_prepareUI
{
    teachContentTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MainScreenSize_W, MainScreenSize_H) style:UITableViewStylePlain];
    teachContentTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    teachContentTable.delegate = self;
    teachContentTable.dataSource = self;
    [self.view addSubview:teachContentTable];
}

//请求的数据结果
- (void)_prepareData
{
//    1.4.2 The course credits
    [self showAlertHUD:@"正在加载..."];
    
    contentLeftArr = [[NSMutableArray alloc]initWithCapacity:0];
    contentArr = [[NSMutableArray alloc]initWithCapacity:0];
    LearningPlanRequest * teachContent = [[LearningPlanRequest alloc] init];
    [teachContent userCourseContentWithWeekId:self.weekId andCType:[NSString stringWithFormat:@"%ld",(long)self.cType] andClassCatagory:self.classCatagory success:^(id obj) {
        InfoResult *infoResult = (InfoResult *)obj;
        if ([infoResult.code isEqualToString:@"0"]) {
            
            TeachContentDataModel *teachContentModel = [[TeachContentDataModel alloc] init];
            teachContentModel = (TeachContentDataModel *)[infoResult extraObj];
            
            NSArray * contentLeftArray = [[NSArray alloc] initWithObjects:@"上课日期",@"教学进度",@"教学内容",@"今日还课",@"笔头作业",@"预习作业",@"提示内容",@"教辅内容",@"备      注", nil];
            NSArray * contentArray = [[NSArray alloc] initWithObjects:teachContentModel.schoolTime,teachContentModel.teachSchedule,teachContentModel.teachingContent,teachContentModel.returnContent,teachContentModel.writingHomework,teachContentModel.previewHomework,teachContentModel.promptContent,teachContentModel.result,teachContentModel.remark, nil];
            for (int i = 0; i < contentArray.count; i ++) {
                NSString * content = contentArray[i];
                if (content.length != 0) {
                    [contentLeftArr addObject:contentLeftArray[i]];
                    [contentArr addObject:contentArray[i]];
                }
            }

            [teachContentTable reloadData];
        }else{
            [aCommon iToast:@"加载失败!"];
        }
    } failed:^(id obj) {
       [aCommon iToast:@"系统未知错误!"];
    }];
}

#pragma mark- UITableViewDataSourcer
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return contentLeftArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIndentifier = @"TeachContentCell";
    TeachContentCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[TeachContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.leftLabel.text = [contentLeftArr objectAtIndex:indexPath.row];
    cell.leftLabel.numberOfLines = 3;
    cell.leftLabel.lineBreakMode = NSLineBreakByClipping;
    [cell.leftLabel sizeToFit];
    cell.leftLabel.adjustsFontSizeToFitWidth =YES;
    
    
    NSString *teachContentStr = contentArr[indexPath.row];
    CGSize contentSize = [NSString getTextHeight:teachContentStr maxWidth:MainScreenSize_W - 90];
    if (![teachContentStr isEqualToString:@""]){
        if ([teachContentStr rangeOfString:@"\n"].location != NSNotFound) {
            NSArray *array = [teachContentStr componentsSeparatedByString:@"\n"];
            cell.teachContentLabel.frame = CGRectMake(85, 5, MainScreenSize_W - 80, (contentSize.height + 10*([array count]-1)) * SIZE_TIMES);
        }else{
            if (contentSize.height < 35) {
                cell.teachContentLabel.frame = CGRectMake(85, 5, MainScreenSize_W - 80, 35 * SIZE_TIMES);
            }else{
                cell.teachContentLabel.frame = CGRectMake(85, 5, MainScreenSize_W - 80, contentSize.height * SIZE_TIMES);
            }
        }
        cell.lineLab.frame = CGRectMake(0, cell.teachContentLabel.origin.y + cell.teachContentLabel.size.height + 10, MainScreenSize_W, 0.0);
    }else{
        cell.teachContentLabel.frame = CGRectMake(85, 5, MainScreenSize_W - 80, 35*SIZE_TIMES);
        cell.lineLab.frame = CGRectMake(0, 50*SIZE_TIMES-1, MainScreenSize_W, 0.0);
    }
    cell.teachContentLabel.text = teachContentStr;

    [cell.teachContentLabel sizeToFit];
    if (indexPath.row%2==0) {
        cell.contentView.backgroundColor = [UIColor colorWithRed:222.0f/255.0f green:222.0f/255.0f blue:222.0f/255.0f alpha:1.0f];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *teachContentStr = contentArr[indexPath.row];
    
    CGSize contentSize = [NSString getTextHeight:teachContentStr maxWidth:MainScreenSize_W - 90];
    
    if ([teachContentStr isEqualToString:@""]) {
        tableView.rowHeight = 50 *SIZE_TIMES;
    }else{
        if ([teachContentStr rangeOfString:@"\n"].location != NSNotFound) {
            NSArray *array = [teachContentStr componentsSeparatedByString:@"\n"];
            tableView.rowHeight = (contentSize.height + 10*([array count]-1) + 10) * SIZE_TIMES;
        }else{
            if (contentSize.height < 35) {
                tableView.rowHeight = 50 *SIZE_TIMES;
            }else{
                tableView.rowHeight = (contentSize.height + 20) *SIZE_TIMES;
            }
        }
    }
    
    return tableView.rowHeight;
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
