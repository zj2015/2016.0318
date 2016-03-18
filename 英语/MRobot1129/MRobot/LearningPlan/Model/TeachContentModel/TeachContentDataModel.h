//
//  TeachContentDataModel.h
//  MRobot
//
//  Created by mac on 15/8/20.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "BaseEntity.h"
/**
 *  The course creditsModel
 */
@interface TeachContentDataModel : BaseEntity

@property (copy, nonatomic) NSString * schoolTime;//上课时间
@property (copy, nonatomic) NSString * teachSchedule;//Teaching progress
@property (copy, nonatomic) NSString * teachingContent;//The course credits
@property (copy, nonatomic) NSString * returnContent;//还课内容
@property (copy, nonatomic) NSString * writingHomework;//笔头作业
@property (copy, nonatomic) NSString * previewHomework;//预习作业
@property (copy, nonatomic) NSString * promptContent;//提示内容
@property (copy, nonatomic) NSString * result;//教辅内容
@property (copy, nonatomic) NSString * remark;//备注

@end
