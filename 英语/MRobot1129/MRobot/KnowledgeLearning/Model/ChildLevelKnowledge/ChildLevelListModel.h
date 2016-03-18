//
//  ChildLevelListModel.h
//  MRobot
//
//  Created by mac on 15/8/21.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "BaseEntity.h"
/**
 *  子级知识点列表
 */
@interface ChildLevelListModel : BaseEntity
/**
 *  知识点Id
 */
@property (copy, nonatomic) NSString * kId;

/**
 *  知识点名称
 */
@property (copy, nonatomic) NSString * kName;

/**
 *  知识点内容
 */
@property (copy, nonatomic) NSString * kContent;

///**
// *  本周是否已经学过 当前是4级知识点时：  0：未学   1：已学
// */
//@property (copy, nonatomic) NSString * hasViewed;
//
///**
// *  本周剩余可学习数量  当前是4级知识点时，返回该数量，客户端需要根据该字段以及hasViewed判断是否可进入“知识点解析”、“习题训练”
// */
//@property (copy, nonatomic) NSString * remainAmount;

@end
