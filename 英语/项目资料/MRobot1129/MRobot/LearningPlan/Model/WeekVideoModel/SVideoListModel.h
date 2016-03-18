//
//  SVideoListModel.h
//  MRobot
//
//  Created by mac on 15/8/20.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "BaseEntity.h"
/**
 *  Videos
 */
@interface SVideoListModel : BaseEntity

@property (copy, nonatomic) NSString * sId; //技巧Id

@property (copy, nonatomic) NSString * sName; //技巧名称

@property (copy, nonatomic) NSString * sVideoCoverUrl; //技巧视频封面地址

@property (copy, nonatomic) NSString * sVideoCCId; //技巧视频CC ID

@property (copy, nonatomic) NSString * sVideoUrl; //视频地址
@end
