//
//  TypeQuestionListModel.m
//  MRobot
//
//  Created by mac on 15/8/21.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "TypeQuestionListModel.h"

@implementation TypeQuestionListModel

@synthesize tVideoCCId;
@synthesize tVideoCoverUrl;
@synthesize tVideoUrl;
@synthesize hasMoreVideo;
@synthesize questionListArray;

- (instancetype)init
{
    self = [super init];
    if (self) {
        questionListArray = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return self;
}

@end
