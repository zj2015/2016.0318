//
//  TeachContentCell.m
//  ERobot
//
//  Created by 郭东丽 on 15/7/2.
//  Copyright (c) 2015年 BaiYu. All rights reserved.
//

#import "TeachContentCell.h"

@implementation TeachContentCell

- (void)awakeFromNib {
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 63, 35*SIZE_TIMES)];
//        _leftLabel.backgroundColor = PView_RedColor;
        _leftLabel.font = [UIFont systemFontOfSize:15.0];
        _leftLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:_leftLabel];
        
        _teachContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 5, MainScreenSize_W - 90, 35*SIZE_TIMES)];
//        _teachContentLabel.backgroundColor = [UIColor yellowColor];
        _teachContentLabel.font = [UIFont systemFontOfSize:15.0];
        _teachContentLabel.numberOfLines = 0;
        [self addSubview:_teachContentLabel];
        
        _lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 50*SIZE_TIMES - 1, MainScreenSize_W, 0.5)];
        _lineLab.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_lineLab];
    }
    
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
