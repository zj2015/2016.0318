//
//  ImportantAnalysiModel.m
//  MRobot
//
//  Created by mac on 15/8/20.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "ImportantAnalysiModel.h"

@implementation ImportantAnalysiModel

@synthesize skillListArray;

- (instancetype)init
{
    self = [super init];
    if (self) {
        skillListArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

@end
