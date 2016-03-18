//
//  ProvinceListModel.m
//  ERobot
//
//  Created by mac on 15/7/21.
//  Copyright (c) 2015年 BaiYu. All rights reserved.
//

#import "ProvinceListModel.h"

@implementation ProvinceListModel

@synthesize provinceList;


- (instancetype)init
{
    self = [super init];
    if (self) {
        provinceList = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return self;
}

@end
