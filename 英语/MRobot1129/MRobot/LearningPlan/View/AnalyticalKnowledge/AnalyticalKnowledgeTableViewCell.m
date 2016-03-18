//
//  AnalyticalKnowledgeTableViewCell.m
//  ERobot
//
//  Created by 郭东丽 on 15/7/1.
//  Copyright (c) 2015年 BaiYu. All rights reserved.
//

#import "AnalyticalKnowledgeTableViewCell.h"

@implementation AnalyticalKnowledgeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView *topBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenSize_W, 5 + 40*SIZE_TIMES + 1)];
        topBackView.backgroundColor = RgbColor(201, 202, 203);
        [self addSubview:topBackView];
        
        _kNameLab = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, MainScreenSize_W-55, 40*SIZE_TIMES)];
        [self addSubview:_kNameLab];
        
        CGFloat btnWidth = 12*SIZE_TIMES;
        CGSize btnSize = CGSizeMake(btnWidth, btnWidth*2);
        _videoBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _videoBtn.frame = CGRectMake(MainScreenSize_W - btnSize.width - 10 , (topBackView.frame.size.height - btnSize.height)/2.0, btnSize.width,btnSize.height );
        [_videoBtn setBackgroundImage:[UIImage imageNamed:@"video-1"] forState:UIControlStateNormal];
        [self addSubview:_videoBtn];
        
        _messageBackView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(topBackView.frame), MainScreenSize_W, 125*SIZE_TIMES)];
        _messageBackView.backgroundColor = RgbColor(170, 159, 111);
        [self addSubview:_messageBackView];
        
        _kContentLab = [[UILabel alloc] init];
        _kContentLab.frame = CGRectMake(5, CGRectGetMaxY(topBackView.frame), MainScreenSize_W-10,125*SIZE_TIMES);
        _kContentLab.numberOfLines = 0;
        _kContentLab.backgroundColor = RgbColor(170, 159, 111);
        _kContentLab.textColor = RgbColor(238, 223, 200);
        _kContentLab.font = [UIFont systemFontOfSize:15];
        [self addSubview:_kContentLab];
        
        
        
    }
    return self;
 }

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
