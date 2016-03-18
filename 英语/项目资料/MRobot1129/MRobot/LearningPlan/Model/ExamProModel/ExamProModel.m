//
//  ExamProModel.m
//  MRobot
//
//  Created by mac on 15/8/20.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "ExamProModel.h"
#import "ExamProListModel.h"
@implementation ExamProModel

-(void)initWithJson:(NSDictionary *)resultDic
{
    if ([self init]) {
        self.examProListArr = [self objectOrNilForKey:@"ExamProgressList" fromDictionary:resultDic];
        NSMutableArray *listArray = [NSMutableArray array];
        for (NSDictionary *dicts in self.examProListArr) {
            ExamProListModel *listModel = [[ExamProListModel alloc]init];
            [listModel initWithJson:dicts];
            [listArray addObject:listModel];
        }
        _examProListArr = listArray;
    }
}


@end
