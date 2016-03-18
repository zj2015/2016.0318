//
//  WrongKnowledgeListModel.m
//  ERobot
//
//  Created by BaiYu on 15/7/2.
//  Copyright (c) 2015年 BaiYu. All rights reserved.
//

#import "WrongKnowledgeListModel.h"

@implementation WrongKnowledgeListModel

@synthesize wrongListArr;

-(id)init
{
    self = [super init];
    if (self) {
        wrongListArr = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}
@end
