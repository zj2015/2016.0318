//
//  TypeQuestionListModel.h
//  MRobot
//
//  Created by mac on 15/8/21.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "BaseEntity.h"
/**
 *  题型题目列表
 */
@interface TypeQuestionListModel : BaseEntity

/**
 *  Video – answer to the common questions 
Repeat封面地址
 */
@property (copy, nonatomic) NSString * tVideoCoverUrl;

/**
 *  通用解析技巧视频CC ID
 */
@property (copy, nonatomic) NSString * tVideoCCId;

/**
 *  更多视频的个数
 */
@property (copy, nonatomic) NSString * hasMoreVideo;

/**
 *  视频地址
 */
@property (copy, nonatomic) NSString * tVideoUrl;

@property (strong, nonatomic) NSMutableArray *questionListArray;

@end
