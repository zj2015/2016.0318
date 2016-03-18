//
//  DateListModel.h
//  ERobot
//
//  Created by BaiYu on 15/7/8.
//  Copyright (c) 2015年 BaiYu. All rights reserved.
//

#import "BaseEntity.h"
/**
 *  错题库(按月份返回最新的三个错题)
 */
@interface DateListModel : BaseEntity

@property (nonatomic, strong) NSMutableArray *dateListArr;//错题库月份列表

@end
