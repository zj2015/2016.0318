//
//  SubmitQuestionModel.h
//  ERobot
//
//  Created by mac on 15/7/13.
//  Copyright (c) 2015年 BaiYu. All rights reserved.
//

#import "BaseEntity.h"

@interface SubmitQuestionModel : BaseEntity

@property (copy, nonatomic) NSString *score;

@property (copy, nonatomic) NSString *highestScore;

@property (copy, nonatomic) NSString *beatPercent;

@property (strong, nonatomic) NSMutableArray *well;

@property (strong, nonatomic) NSMutableArray *bad;

@property (strong, nonatomic) NSMutableArray *wrongQIdList;

@end
