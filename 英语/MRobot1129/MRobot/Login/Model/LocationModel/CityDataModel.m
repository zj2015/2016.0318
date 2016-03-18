//
//  CityDataModel.m
//  ERobot
//
//  Created by mac on 15/7/21.
//  Copyright (c) 2015年 BaiYu. All rights reserved.
//

#import "CityDataModel.h"

@implementation CityDataModel

@synthesize cId;
@synthesize city;
@synthesize districtList;

- (instancetype)init
{
    self = [super init];
    if (self) {
        districtList = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return self;
}

@end
