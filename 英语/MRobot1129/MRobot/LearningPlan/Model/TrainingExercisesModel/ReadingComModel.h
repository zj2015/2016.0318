//
//  ReadingComModel.h
//  ERobot
//
//  Created by mac on 15/7/3.
//  Copyright (c) 2015年 BaiYu. All rights reserved.
//

#import "BaseEntity.h"

@interface ReadingComModel : BaseEntity

@property (copy, nonatomic) NSString *qTitle;//题干

@property (copy, nonatomic) NSString *qTitlePicUrl;//题干图片

@property (copy, nonatomic) NSString * questionType;// 阅读理解类型  0:套题  1:普通需要上拉

@property (copy, nonatomic) NSString *qTitleMediaUrl;//提干声音

@property (copy, nonatomic) NSMutableDictionary *childQuestions;

@property (copy, nonatomic) NSObject *childQuestionsObj;
@end
