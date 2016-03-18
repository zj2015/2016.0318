//
//  MineHeadView.h
//  MRobot
//
//  Created by mac on 15/8/27.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlagView.h"

#define HeadViewCellHeight 8*MainScreenSize_W/22.5 + 45*SIZE_TIMES

@interface MineHeadView : UIView

@property (strong, nonatomic) UIImageView *headBGImageView;

@property (strong, nonatomic) UILabel *nameLabel;

@property (strong, nonatomic) FlagView *flagView1;

@property (strong, nonatomic) FlagView *flagView2;

@property (strong, nonatomic) FlagView *flagView3;

@end
