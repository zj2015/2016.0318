//
//  KnowledgeTableViewCell.h
//  MRobot
//
//  Created by mac on 15/8/26.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import <UIKit/UIKit.h>

#define KnowledgeCellHeight 40*SIZE_TIMES

@interface KnowledgeTableViewCell : UITableViewCell

@property(nonatomic,strong)UILabel *knowledgeNameLab;//知识点名称
@property(nonatomic,strong)UIImageView *signImgView;//单元格右边箭头

@end
