//
//  ResultListModel.m
//  MRobot
//
//  Created by mac on 15/8/20.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "ResultListModel.h"

@implementation ResultListModel

@synthesize kId;
@synthesize kName;
@synthesize kContent;
@synthesize wrongQIdList;

- (instancetype)init
{
    self = [super init];
    if (self) {
        wrongQIdList = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}


@end
