//
//  OpinionResultModel.h
//  MRobot
//
//  Created by mac on 15/8/20.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "BaseEntity.h"
/**
 *  系统意见列表Model
 */
@interface OpinionResultModel : BaseEntity

@property (copy, nonatomic) NSString *oId; //意见Id

@property (copy, nonatomic) NSString *oContent; //意见内容

@end
