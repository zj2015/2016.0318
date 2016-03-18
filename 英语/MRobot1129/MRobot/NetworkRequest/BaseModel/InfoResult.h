//
//  InfoResult.h
//  CCTeam
//
//  Created by BaiYu on 14-9-29.
//  Copyright (c) 2014年 SPLD. All rights reserved.
//

#import "BaseEntity.h"

@interface InfoResult : BaseEntity

@property(nonatomic, copy) NSString *code;
@property(nonatomic, copy) NSString *desc;
@property(nonatomic, strong) NSObject *extraObj;

@end
