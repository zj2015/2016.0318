//
//  ExamProListModel.m
//  MRobot
//
//  Created by mac on 15/8/20.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "ExamProListModel.h"

@implementation ExamProListModel


-(void)initWithJson:(NSDictionary *)resultDic
{
    if ([self init]) {
        self.weekId = [self objectOrNilForKey:@"weekId" fromDictionary:resultDic];
        self.weekDesc = [self objectOrNilForKey:@"weekDesc" fromDictionary:resultDic];
        self.teachContent = [self objectOrNilForKey:@"teachContent" fromDictionary:resultDic];
        self.thisWeek = [self objectOrNilForKey:@"thisWeek" fromDictionary:resultDic];
        self.hasBookLearn = [self objectOrNilForKey:@"hasBookLearn" fromDictionary:resultDic];
        self.hasTrain = [self objectOrNilForKey:@"hasTrain" fromDictionary:resultDic];
        self.viewedInCWeek = [self objectOrNilForKey:@"viewedInCWeek" fromDictionary:resultDic];
        self.classCatagory = [self objectOrNilForKey:@"classCatagory" fromDictionary:resultDic];
    }
}

@end
