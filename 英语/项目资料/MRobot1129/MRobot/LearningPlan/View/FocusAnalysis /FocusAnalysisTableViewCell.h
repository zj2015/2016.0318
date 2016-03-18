//
//  FocusAnalysisTableViewCell.h
//  MRobot
//
//  Created by BaiYu on 15/8/24.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FocusAnalysisTableViewCell : UITableViewCell

@property (nonatomic,retain)UILabel * sNameLab;//技巧名称
@property (nonatomic,retain)UIButton * videoBtn;//Answer to the key question video
@property (nonatomic,retain)UILabel *videoNameLab;//视频名称
@property (nonatomic,retain)UIImageView *videoCoverImg;//视频封面
@end
