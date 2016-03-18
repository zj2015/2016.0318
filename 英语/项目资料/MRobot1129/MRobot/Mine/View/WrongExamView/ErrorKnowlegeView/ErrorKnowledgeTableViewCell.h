//
//  ErrorKnowledgeTableViewCell.h
//  ERobot
//
//  Created by BaiYu on 15/7/1.
//  Copyright (c) 2015年 BaiYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ErrorKnowledgeTableViewCell : UITableViewCell

@property(nonatomic,strong)UILabel *knowledgeLab;//知识点描述
@property(nonatomic,strong)UILabel *errorLab;//错误率描述
@property(nonatomic,strong)UIImageView *signImgView;//单元格右边箭头
@end
