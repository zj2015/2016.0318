//
//  TopQTypeResultModel.h
//  MRobot
//
//  Created by mac on 15/8/21.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "BaseEntity.h"
/**
 *  题型列表
 */
@interface TopQTypeResultModel : BaseEntity

/**
 *  题型Id
 */
@property (copy, nonatomic) NSString * tId;

/**
 *  题型名称
 */
@property (copy, nonatomic) NSString * tName;

@property (strong, nonatomic) NSMutableArray *childTypeArray;

@end
