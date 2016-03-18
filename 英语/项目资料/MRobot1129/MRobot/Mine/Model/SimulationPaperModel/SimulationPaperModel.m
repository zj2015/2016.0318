//
//  SimulationPaperModel.m
//  MRobot
//
//  Created by mac on 15/8/20.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "SimulationPaperModel.h"

@implementation SimulationPaperModel

@synthesize simulationPaperList;

- (instancetype)init
{
    self = [super init];
    if (self) {
        simulationPaperList = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

@end
