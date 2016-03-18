//
//  FocusAnalysisTableViewCell.m
//  MRobot
//
//  Created by BaiYu on 15/8/24.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "FocusAnalysisTableViewCell.h"

@implementation FocusAnalysisTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorWithRed:186/255.0 green:175/255.0 blue:129/255.0 alpha:1];
        
        _sNameLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MainScreenSize_W, 40*SIZE_TIMES)];
        _sNameLab.backgroundColor = [UIColor whiteColor];
        [self addSubview:_sNameLab];
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 40*SIZE_TIMES, MainScreenSize_W, 90*SIZE_TIMES)];
        bgView.backgroundColor = [UIColor colorWithRed:186/255.0 green:175/255.0 blue:129/255.0 alpha:1];
        [self.contentView addSubview:bgView];
        
//        UILabel * line = [[UILabel alloc] initWithFrame:CGRectMake(MainScreenSize_W/2, 0, 1, 90*SIZE_TIMES)];
//        line.backgroundColor =[UIColor colorWithRed:186/255.0 green:175/255.0 blue:129/255.0 alpha:1];
//        [bgView addSubview:line];
        
        _videoNameLab = [[UILabel alloc] init];
        _videoNameLab.frame = CGRectMake(10, 25, MainScreenSize_W/2-20,40*SIZE_TIMES);
        _videoNameLab.numberOfLines = 0;
        _videoNameLab.textAlignment = NSTextAlignmentCenter;
        _videoNameLab.font = [UIFont systemFontOfSize:15];
        [_videoNameLab setBackgroundColor:[UIColor clearColor]];
        [bgView addSubview:_videoNameLab];
        
        _videoCoverImg = [[UIImageView alloc] initWithFrame:CGRectMake(MainScreenSize_W/2 + (MainScreenSize_W/2-120)/2, 9, 120*SIZE_TIMES, 72*SIZE_TIMES)];
        _videoCoverImg.userInteractionEnabled = YES;
        [bgView addSubview:_videoCoverImg];
        
        _videoBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _videoBtn.frame = CGRectMake((_videoCoverImg.size.width - 30*SIZE_TIMES)/2 , (_videoCoverImg.size.height - 30*SIZE_TIMES)/2, 30*SIZE_TIMES, 30*SIZE_TIMES);
        [_videoBtn setBackgroundImage:[UIImage imageNamed:@"PLAY"] forState:UIControlStateNormal];
        [_videoCoverImg addSubview:_videoBtn];
        
        self.contentView.backgroundColor = [UIColor colorWithRed:186/255.0 green:175/255.0 blue:129/255.0 alpha:1];
        
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
