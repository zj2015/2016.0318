//
//  MineTableViewCell.m
//  MRobot
//
//  Created by mac on 15/8/27.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "MineTableViewCell.h"

@implementation MineTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, MineCellHeight)];
        _rightLabel.backgroundColor = [UIColor clearColor];
        _rightLabel.font = [UIFont systemFontOfSize:15.0];
        [self.contentView addSubview:_rightLabel];
        
        _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(MainScreenSize_W - 30, MineCellHeight/2 - 17*SIZE_TIMES/2, 17*SIZE_TIMES/2, 17*SIZE_TIMES)];
        _leftImageView.image = [UIImage imageNamed:@"grayHide"];
        [self.contentView addSubview:_leftImageView];
        
        
        UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, MineCellHeight - 0.5, MainScreenSize_W, 0.5)];
        lineLab.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:lineLab];
        
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
