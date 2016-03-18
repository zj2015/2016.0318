//
//  QuestionDataModel.h
//  ERobot
//
//  Created by mac on 15/7/2.
//  Copyright (c) 2015年 BaiYu. All rights reserved.
//

#import "BaseEntity.h"
/**
 *  题目列表Model
 */
@interface QuestionDataModel : BaseEntity

@property (copy, nonatomic) NSString *qAmount;//题目总数量

@property (copy, nonatomic) NSString *totalTime;//考试限时

@property (copy, nonatomic) NSMutableArray *dxt;//选择题

@property (copy, nonatomic) NSMutableArray *tkt;//填空题

@property (copy, nonatomic) NSMutableArray *ydljt;//阅读理解

@property (copy, nonatomic) NSMutableArray *tlt;//听力题

@end
