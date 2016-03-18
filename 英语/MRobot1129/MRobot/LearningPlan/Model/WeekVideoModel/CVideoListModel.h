//
//  CVideoListModel.h
//  MRobot
//
//  Created by mac on 15/8/20.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "BaseEntity.h"
/**
 *  Videos
 */
@interface CVideoListModel : BaseEntity

@property (copy, nonatomic) NSString * cVideoCoverUrl; //经典视频封面地址

@property (copy, nonatomic) NSString * cVideoCCId;//经典视频CC ID

@property (copy, nonatomic) NSString * cVideoUrl;//视频地址
@end
