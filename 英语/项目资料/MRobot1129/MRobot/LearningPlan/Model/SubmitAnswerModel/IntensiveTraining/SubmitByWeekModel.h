//
//  SubmitByWeekModel.h
//  MRobot
//
//  Created by mac on 15/8/20.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "BaseEntity.h"
/**
 *  提交答案-教材强化习题训练
 */
@interface SubmitByWeekModel : BaseEntity

@property (copy, nonatomic) NSString * score;//得分

@property (strong, nonatomic) NSMutableArray * resultArr;


@end
