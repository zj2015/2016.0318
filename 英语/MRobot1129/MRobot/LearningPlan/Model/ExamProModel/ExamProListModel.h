//
//  ExamProListModel.h
//  MRobot
//
//  Created by mac on 15/8/20.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "BaseEntity.h"
/**
 *  学习进度Model
 */
@interface ExamProListModel : BaseEntity

@property (copy, nonatomic) NSString * weekId;//周编号

@property (copy, nonatomic) NSString * weekDesc;//周描述信息

@property (copy, nonatomic) NSString * teachContent;//The course credits

@property (copy, nonatomic) NSString * thisWeek;//是否是当前周   0：否 1：是

@property (copy, nonatomic) NSString * hasBookLearn;//是否有教材强化   0：否 1：是

@property (copy, nonatomic) NSString * hasTrain;//是否有综合训练   0：否 1：是

@property (copy, nonatomic) NSString * viewedInCWeek;//本周是否学习过   0：否 1：是

@property (copy, nonatomic) NSString * classCatagory;//班类

@end
