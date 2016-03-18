//
//  QuestionDataModel.m
//  ERobot
//
//  Created by mac on 15/7/2.
//  Copyright (c) 2015年 BaiYu. All rights reserved.
//

#import "QuestionDataModel.h"

@implementation QuestionDataModel

@synthesize qAmount;
@synthesize totalTime;
@synthesize dxt;
@synthesize tkt;
@synthesize ydljt;
@synthesize tlt;

-(id)init{
    if (self = [super init]) {
        dxt = [[NSMutableArray alloc] initWithCapacity:0];
        tkt = [[NSMutableArray alloc] initWithCapacity:0];
        ydljt = [[NSMutableArray alloc] initWithCapacity:0];
        tlt = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}
@end
