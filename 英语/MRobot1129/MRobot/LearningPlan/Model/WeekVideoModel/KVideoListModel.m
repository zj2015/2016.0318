//
//  KVideoListModel.m
//  MRobot
//
//  Created by mac on 15/8/20.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "KVideoListModel.h"

@implementation KVideoListModel

@synthesize kName;
@synthesize videoList;

- (instancetype)init
{
    self = [super init];
    if (self) {
        videoList = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return self;
}

@end
