//
//  SubmitBySkillModel.m
//  MRobot
//
//  Created by mac on 15/8/20.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "SubmitBySkillModel.h"

@implementation SubmitBySkillModel

@synthesize resultList;

- (instancetype)init
{
    self = [super init];
    if (self) {
        resultList = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return self;
}

@end
