//
//  SimulationListModel.h
//  MRobot
//
//  Created by mac on 15/8/20.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "BaseEntity.h"
/**
 *  模拟试卷列表Model
 */
@interface SimulationListModel : BaseEntity

@property (copy, nonatomic) NSString * paperId; // 试卷Id

@property (copy, nonatomic) NSString * paperName; // 试卷名称

@property (copy, nonatomic) NSString * thisWeek; //是否是当前周  0：否   1：是

@end
