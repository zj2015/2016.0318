//
//  TeachContentDataModel.m
//  MRobot
//
//  Created by mac on 15/8/20.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "TeachContentDataModel.h"

@implementation TeachContentDataModel

- (void)initWithJson:(NSDictionary *)resultDic
{
    if ([self init]) {
//        [self setSchoolTime:[resultDic objectForKey:@"schoolTime"]];
//        [self setTeachSchedule:[resultDic objectForKey:@"teachSchedule"]];
//        [self setTeachingContent:[resultDic objectForKey:@"teachingContent"]];
//        [self setReturnContent:[resultDic objectForKey:@"returnContent"]];
//        [self setWritingHomework:[resultDic objectForKey:@"writingHomework"]];
//        [self setPreviewHomework:[resultDic objectForKey:@"previewHomework"]];
//        [self setPromptContent:[resultDic objectForKey:@"promptContent"]];
//        [self setResult:[resultDic objectForKey:@"result"]];
//        [self setRemark:[resultDic objectForKey:@"remark"]];
        
        self.schoolTime = [self objectOrNilForKey:@"schoolTime" fromDictionary:resultDic];
        self.teachSchedule = [self objectOrNilForKey:@"teachSchedule" fromDictionary:resultDic];
        self.teachingContent = [self objectOrNilForKey:@"teachingContent" fromDictionary:resultDic];
        self.returnContent = [self objectOrNilForKey:@"returnContent" fromDictionary:resultDic];
        self.writingHomework = [self objectOrNilForKey:@"writingHomework" fromDictionary:resultDic];
        self.previewHomework = [self objectOrNilForKey:@"previewHomework" fromDictionary:resultDic];
        self.promptContent = [self objectOrNilForKey:@"promptContent" fromDictionary:resultDic];
        self.result = [self objectOrNilForKey:@"result" fromDictionary:resultDic];
        self.remark = [self objectOrNilForKey:@"remark" fromDictionary:resultDic];
        
    }
}


@end
