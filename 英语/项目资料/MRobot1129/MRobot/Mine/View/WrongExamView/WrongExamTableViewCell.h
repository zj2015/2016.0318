//
//  WrongExamTableViewCell.h
//  ERobot
//
//  Created by 郭东丽 on 15/7/2.
//  Copyright (c) 2015年 BaiYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WrongExamTableViewCell : UITableViewCell

@property(nonatomic,strong)UILabel *contentLab;//题目内容
@property(nonatomic,strong)UILabel *leftSignLab;//题目类型
@property(nonatomic,strong)UIImageView *rightImageView;
@property(nonatomic,strong)UIView *rowView;
@property(nonatomic,strong)UIButton *moreBtn;
@end
