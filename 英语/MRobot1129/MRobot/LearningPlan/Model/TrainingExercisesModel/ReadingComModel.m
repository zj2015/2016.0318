//
//  ReadingComModel.m
//  ERobot
//
//  Created by mac on 15/7/3.
//  Copyright (c) 2015年 BaiYu. All rights reserved.
//

#import "ReadingComModel.h"

@implementation ReadingComModel

@synthesize qTitle;
@synthesize qTitlePicUrl;
@synthesize questionType;
@synthesize qTitleMediaUrl;
@synthesize childQuestions;
@synthesize childQuestionsObj;

-(id)init{
    if (self = [super init]) {
        childQuestions = [[NSMutableDictionary alloc] initWithCapacity:0];
        
    }
    return self;
}

@end
