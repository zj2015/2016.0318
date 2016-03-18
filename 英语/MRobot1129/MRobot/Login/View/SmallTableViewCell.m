//
//  SmallTableViewCell.m
//  MRobot
//
//  Created by mac on 15/8/28.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "SmallTableViewCell.h"
#define CellWidth  MainScreenSize_W-56
@implementation SmallTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, CellWidth, 35)];
        _leftLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_leftLabel];
        
        _rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CellWidth - 40, 35/2-20/2, 20, 20)];
        _rightImageView.image = [UIImage imageNamed:@"radio"];
        [self.contentView addSubview:_rightImageView];
        
        UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(5, 35 - 0.5, CellWidth - 10 , 0.5)];
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
    
//    if (selected) {
//        _rightImageView.image = [UIImage imageNamed:@"radioChecked"];
//    }else{
//        _rightImageView.image = [UIImage imageNamed:@"radio"];
//    }
    
}

@end
