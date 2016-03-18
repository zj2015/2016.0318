//
//  TopicHeadView.h
//  MRobot
//
//  Created by mac on 15/8/26.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TopicHeadViewBlock)(NSInteger tag);

@interface TopicHeadView : UITableViewHeaderFooterView

{
    TopicHeadViewBlock _block;
}

@property(nonatomic,strong)UILabel *topicNameLab;//技巧名称
@property(nonatomic,strong)UIImageView *signImgView;//单元格右边箭头

+ (instancetype)headViewWithTableView:(UITableView *)tableView withBlock:(TopicHeadViewBlock)block;

@end
