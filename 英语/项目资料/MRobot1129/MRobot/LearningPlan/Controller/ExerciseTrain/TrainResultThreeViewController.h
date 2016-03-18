//
//  TrainResultThreeViewController.h
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
@interface TrainResultThreeViewController : BaseViewController<UIAlertViewDelegate>

@property (strong, nonatomic) SubmitBySkillModel *skillModel;

@property (strong, nonatomic) QuestionDataModel *questionModel;

@property (strong, nonatomic) NSArray *answerArray;

@property (strong, nonatomic) NSMutableArray *answerArr;// 0 没写， 1正确   2错误

@property (assign, nonatomic) BOOL isAgain;//区分是否有再次训练

@property (strong, nonatomic) SkillListModel *skillListModel;

@property (copy, nonatomic) NSString *sId;

@property (copy, nonatomic) NSString *sType;

@end
