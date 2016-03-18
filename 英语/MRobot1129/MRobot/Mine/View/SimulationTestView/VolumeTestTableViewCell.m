   //
//  VolumeTestTableViewCell.m
//  MRobot
//
//  Created by mac on 15/9/8.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "VolumeTestTableViewCell.h"

@implementation VolumeTestTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = PView_BGColor;
        
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, MainScreenSize_W - 20, VolumeCellHeight)];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _bgView.layer.borderWidth = 0.5;
        [self addSubview:_bgView];
        
        _leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, _bgView.width - 60, VolumeCellHeight)];
        _leftLabel.font = [UIFont systemFontOfSize:17];
        [_bgView addSubview:_leftLabel];
        
        _rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(_bgView.right - 40, VolumeCellHeight/2-10, 20, 20)];
        _rightImageView.image = [UIImage imageNamed:@"default-mine"];
        [_bgView addSubview:_rightImageView];
        
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
}

@end
