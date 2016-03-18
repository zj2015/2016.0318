//
//  ErrorKnowledgeHeadView.h
//  MRobot
//
//  Created by mac on 15/10/21.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ErrorKnowledgeHeadViewBlock)(NSInteger tag);

@interface ErrorKnowledgeHeadView : UITableViewHeaderFooterView

{
    ErrorKnowledgeHeadViewBlock _block;
}

@property (nonatomic, strong) UILabel *knowledgeLab;//知识点描述
@property (nonatomic, strong) UILabel *errorLab;//错误率描述
@property (nonatomic, strong) UIImageView *signImgView;//单元格右边箭头
@property (nonatomic, strong) UILabel *errorPercentLab;

+ (instancetype)headViewWithTableView:(UITableView *)tableView withBlock:(ErrorKnowledgeHeadViewBlock)block;

@end
