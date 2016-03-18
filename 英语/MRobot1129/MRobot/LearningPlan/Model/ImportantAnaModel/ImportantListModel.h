//
//  ImportantListModel.h
//  MRobot
//
//  Created by mac on 15/8/20.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "BaseEntity.h"
/**
 *  重点解析-综合训练
 */
@interface ImportantListModel : BaseEntity

@property (copy, nonatomic) NSString * sId; //技巧ID

@property (copy, nonatomic) NSString * sName; //技巧名称

@property (copy, nonatomic) NSString * videoCoverUrl; //视频封面地址

@property (copy, nonatomic) NSString * videoCCId; //视频CC ID

@property (copy, nonatomic) NSString * videoName; //视频名称

@property (copy, nonatomic) NSString * videoUrl; //视频地址
@end
