//
//  OpinionListModel.m
//  MRobot
//
//  Created by mac on 15/8/20.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "OpinionListModel.h"

@implementation OpinionListModel

@synthesize resultArray;

- (instancetype)init
{
    self = [super init];
    if (self) {
        resultArray = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return self;
}

@end
