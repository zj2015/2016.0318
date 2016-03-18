//
//  VolumeTestTableViewCell.h
//  MRobot
//
//  Created by mac on 15/9/8.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import <UIKit/UIKit.h>
#define VolumeCellHeight 40*SIZE_TIMES

@interface VolumeTestTableViewCell : UITableViewCell

@property (strong, nonatomic) UIView * bgView;

@property (strong, nonatomic) UILabel * leftLabel;

@property (strong, nonatomic) UIImageView * rightImageView;

@end
