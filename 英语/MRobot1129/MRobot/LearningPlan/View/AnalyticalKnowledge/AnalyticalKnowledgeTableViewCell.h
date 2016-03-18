//
//  AnalyticalKnowledgeTableViewCell.h
//  ERobot
//
//  Created by 郭东丽 on 15/7/1.
//  Copyright (c) 2015年 BaiYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnalyticalKnowledgeTableViewCell : UITableViewCell

@property (nonatomic,retain)UILabel * kNameLab;//知识点名称
@property (nonatomic,retain)UILabel * kContentLab;//知识点内容
@property (nonatomic,retain)UIButton * videoBtn;//视频按钮
@property (nonatomic,retain)UIView *messageBackView;//背景色
@end
