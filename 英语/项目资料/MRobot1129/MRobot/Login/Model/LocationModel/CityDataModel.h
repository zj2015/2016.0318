//
//  CityDataModel.h
//  ERobot
//
//  Created by mac on 15/7/21.
//  Copyright (c) 2015年 BaiYu. All rights reserved.
//

#import "BaseEntity.h"
/**
 *  查询省市区Model
 */
@interface CityDataModel : BaseEntity

@property (copy, nonatomic) NSString * cId;//城市编号

@property (copy, nonatomic) NSString * city;//城市

@property (strong, nonatomic) NSMutableArray *districtList;

@end
