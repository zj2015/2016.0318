//
//  FeedbackTableViewCell.m
//  MRobot
//
//  Created by mac on 15/9/2.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "FeedbackTableViewCell.h"
#define CellWidth  MainScreenSize_W-56
@implementation FeedbackTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, MainScreenSize_W - 80, 44*SIZE_TIMES-0.5)];
        _leftLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:_leftLabel];
        
        _rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(MainScreenSize_W - 35, 44*SIZE_TIMES/2-20/2, 20, 20)];
//        _rightImageView.backgroundColor = [UIColor lightGrayColor];
        _rightImageView.image = [UIImage imageNamed:@"checkbox"];
        [self.contentView addSubview:_rightImageView];
        
        _lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 44*SIZE_TIMES - 0.5, MainScreenSize_W , 0.5)];
        _lineLabel.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_lineLabel];
        
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
//        _rightImageView.backgroundColor = PView_GreenColor;
//    }else{
//        _rightImageView.backgroundColor = [UIColor lightGrayColor];
//    }
}

@end
