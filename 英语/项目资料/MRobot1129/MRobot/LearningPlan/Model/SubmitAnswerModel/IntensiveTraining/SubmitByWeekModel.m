//
//  SubmitByWeekModel.m
//  MRobot
//
//  Created by mac on 15/8/20.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "SubmitByWeekModel.h"

@implementation SubmitByWeekModel

@synthesize score;
@synthesize resultArr;

- (instancetype)init
{
    self = [super init];
    if (self) {
        resultArr = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return self;
}

@end
