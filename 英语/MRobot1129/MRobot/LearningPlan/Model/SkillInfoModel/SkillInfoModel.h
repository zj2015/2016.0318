//
//  SkillInfoModel.h
//  MRobot
//
//  Created by mac on 15/8/20.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "BaseEntity.h"
/**
 *  技巧训练-知识点Model
 */
@interface SkillInfoModel : BaseEntity

@property (copy, nonatomic) NSString * sId; //技巧ID

@property (copy, nonatomic) NSString * sName; //技巧名称

@property (copy, nonatomic) NSString * mainVideoCoverUrl; //Answer to the key question video

@property (copy, nonatomic) NSString * mainVideoCCId; //Answer to the key question video

@property (copy, nonatomic) NSString * mainVideoUrl; //视频地址
@end
