//
//  TrainResultFourViewController.h
//  MRobot
//
//  Created by mac on 15/8/22.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "BaseViewController.h"
#import "SubmitBySkillModel.h"
#import "SkillResultListModel.h"
#import "QuestionDataModel.h"
#import "SkillListModel.h"
#import "TypeQListModel.h"
#import "DWCustomPlayerViewController.h"
@interface TrainResultFourViewController : BaseViewController<UIAlertViewDelegate>
{
    NSString *_videoId;//视频Id
    NSString *_videoTitle;//视频名称
    NSString *_imgUrlstring;//视频封面地址
    NSString *_videoURL;//视频分享地址
}
@property (strong, nonatomic) SubmitBySkillModel *skillModel;

@property (strong, nonatomic) QuestionDataModel *questionModel;

@property (strong, nonatomic) NSArray *answerArray;

@property (strong, nonatomic) NSMutableArray *answerArr;// 0 没写， 1正确   2错误

@property (strong, nonatomic) SkillListModel *skillListModel;

@property (strong, nonatomic) TypeQListModel *qListModel;

@property (assign, nonatomic) int type; // 0:技巧训练-综合训练    1:题型题目列表

@property (copy, nonatomic) NSString *sId;

@property (copy, nonatomic) NSString *sType;


@end
