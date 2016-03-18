//
//  UserLoginModel.m
//  MRobot
//
//  Created by mac on 15/8/20.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "UserLoginModel.h"

@implementation UserLoginModel

@synthesize uId;
@synthesize uAvatar;
@synthesize uName;
@synthesize uCampus;
@synthesize uClass;
@synthesize token;
@synthesize level;
@synthesize expiresIn;
@synthesize schoolID;
@synthesize classID;
@synthesize sTime;
@synthesize ccAmount;
@synthesize vipEndDate;
@synthesize vipStatus;
@synthesize aCCNum;
@synthesize vCCNum;

-(void)initWithJson:(NSDictionary *)resultDic
{
    if ([self init]) {
        
        self.uId = [self objectOrNilForKey:@"uId" fromDictionary:resultDic];
        self.uName = [self objectOrNilForKey:@"uName" fromDictionary:resultDic];
        self.uCampus = [self objectOrNilForKey:@"uCampus" fromDictionary:resultDic];
        self.uClass = [self objectOrNilForKey:@"uClass" fromDictionary:resultDic];
        self.uAvatar = [self objectOrNilForKey:@"uAvatar" fromDictionary:resultDic];
        self.token = [self objectOrNilForKey:@"token" fromDictionary:resultDic];
        self.expiresIn = [self objectOrNilForKey:@"expiresIn" fromDictionary:resultDic];
        self.schoolID = [self objectOrNilForKey:@"schoolID" fromDictionary:resultDic];
        self.classID = [self objectOrNilForKey:@"classID" fromDictionary:resultDic];
        self.sTime = [self objectOrNilForKey:@"sTime" fromDictionary:resultDic];
        self.ccAmount = [self objectOrNilForKey:@"ccAmount" fromDictionary:resultDic];
        self.vipStatus = [self objectOrNilForKey:@"vipStatus" fromDictionary:resultDic];
        self.vipEndDate = [self objectOrNilForKey:@"vipEndDate" fromDictionary:resultDic];
        self.level = [self objectOrNilForKey:@"level" fromDictionary:resultDic];
        self.aCCNum = [self objectOrNilForKey:@"aCCNum" fromDictionary:resultDic];
        
    }
}

@end
