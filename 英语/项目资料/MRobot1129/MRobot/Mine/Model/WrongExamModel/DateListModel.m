//
//  DateListModel.m
//  ERobot
//
//  Created by BaiYu on 15/7/8.
//  Copyright (c) 2015年 BaiYu. All rights reserved.
//

#import "DateListModel.h"

@implementation DateListModel

@synthesize dateListArr;

-(id)init
{
    self = [super init];
    if (self) {
        dateListArr = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}
@end
