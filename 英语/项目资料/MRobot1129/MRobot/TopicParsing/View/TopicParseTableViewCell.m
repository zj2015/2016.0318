//
//  TopicParseTableViewCell.m
//  MRobot
//
//  Created by mac on 15/8/26.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "TopicParseTableViewCell.h"

@implementation TopicParseTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor colorWithRed:187/255.0f green:175/255.0f blue:129/255.0f alpha:1];
        
        
        _topicNameLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, TopicParseCellHeight)];
        _topicNameLab.backgroundColor = [UIColor clearColor];
        _topicNameLab.textColor = [UIColor whiteColor];
        _topicNameLab.font = [UIFont systemFontOfSize:15.0];
        [self.contentView addSubview:_topicNameLab];
        
        
        _signImgView = [[UIImageView alloc] initWithFrame:CGRectMake(MainScreenSize_W - 30, TopicParseCellHeight/2 - 17*SIZE_TIMES/2, 17*SIZE_TIMES/2, 17*SIZE_TIMES)];
        [self.contentView addSubview:_signImgView];
        
//        UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, TopicParseCellHeight-0.5 , MainScreenSize_W, 0.5)];
//        lineLab.backgroundColor = [UIColor lightGrayColor];
////        [lineLab setTextColor:[UIColor grayColor]];
//        [self.contentView addSubview:lineLab];
        
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
