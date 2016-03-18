//
//  SubmitQuestionModel.m
//  ERobot
//
//  Created by mac on 15/7/13.
//  Copyright (c) 2015年 BaiYu. All rights reserved.
//

#import "SubmitQuestionModel.h"

@implementation SubmitQuestionModel
@synthesize score;
@synthesize highestScore;
@synthesize beatPercent;
@synthesize well;
@synthesize bad;
@synthesize wrongQIdList;

-(id)init{
    if (self = [super init]) {
        well = [[NSMutableArray alloc]initWithCapacity:0];
        bad = [[NSMutableArray alloc]initWithCapacity:0];
        wrongQIdList = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return self;
}

@end
