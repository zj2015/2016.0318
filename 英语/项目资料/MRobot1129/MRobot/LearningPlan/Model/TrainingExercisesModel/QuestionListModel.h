//
//  QuestionListModel.h
//  ERobot
//
//  Created by mac on 15/7/2.
//  Copyright (c) 2015年 BaiYu. All rights reserved.
//

#import "BaseEntity.h"

@interface QuestionListModel : BaseEntity

@property (copy, nonatomic) NSString *qId;//题目编号

@property (copy, nonatomic) NSString *qContent;//题目内容

@property (copy, nonatomic) NSString *qContentPicUrl;//题目图片

@property (copy, nonatomic) NSString *answerAnalysis;//答案解析

@property (copy, nonatomic) NSString *answerVideoAnalysis;//视频解析

@property (copy, nonatomic) NSString *myOptionId;//选择题用户选择的选项id  知识点错题集

@property (copy, nonatomic) NSMutableArray *options;

@end
