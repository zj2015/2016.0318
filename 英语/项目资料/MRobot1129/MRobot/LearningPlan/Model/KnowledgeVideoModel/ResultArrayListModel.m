//
//  ResultArrayListModel.m
//  MRobot
//
//  Created by mac on 15/8/20.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "ResultArrayListModel.h"

@implementation ResultArrayListModel

@synthesize kVideoCCId;
@synthesize kVideoCoverUrl;
@synthesize kVideoUrl;
@synthesize cVideoList;

- (instancetype)init
{
    self = [super init];
    if (self) {
        cVideoList = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

@end
