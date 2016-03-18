//
//  SkillResultListModel.h
//  MRobot
//
//  Created by mac on 15/8/20.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "BaseEntity.h"
/**
 *  提交答案-综合训练技巧训练
 *  提交答案-题型选择
 */
@interface SkillResultListModel : BaseEntity

@property (copy, nonatomic) NSString * qId; //题目Id

@property (copy, nonatomic) NSString * isRight; //是否正确

@property (copy, nonatomic) NSString * sId; //技巧Id

@property (copy, nonatomic) NSString * sName; //技巧名称

@end
