//
//  WeekVideoModel.m
//  MRobot
//
//  Created by mac on 15/8/20.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "WeekVideoModel.h"

@implementation WeekVideoModel

@synthesize kVideoListArr;
@synthesize sVideoListArr;

- (instancetype)init
{
    self = [super init];
    if (self) {
        kVideoListArr = [[NSMutableArray alloc] initWithCapacity:0];
        sVideoListArr = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

@end
