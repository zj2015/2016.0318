//
//  KVideoListModel.h
//  MRobot
//
//  Created by mac on 15/8/20.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "BaseEntity.h"
/**
 *  Videos
 */
@interface KVideoListModel : BaseEntity

@property (copy, nonatomic) NSString * kName;// 知识点名称

@property (strong, nonatomic) NSMutableArray * videoList;

@end
