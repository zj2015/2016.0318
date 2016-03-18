//
//  AnalyticalKnowledgeModel.m
//  MRobot
//
//  Created by mac on 15/8/20.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "AnalyticalKnowledgeModel.h"

@implementation AnalyticalKnowledgeModel

@synthesize analyticalKnowledgeArr;

-(id)init
{
    self = [super init];
    if (self) {
        analyticalKnowledgeArr = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

@end
