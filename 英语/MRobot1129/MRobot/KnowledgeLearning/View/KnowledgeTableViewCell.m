//
//  KnowledgeTableViewCell.m
//  MRobot
//
//  Created by mac on 15/8/26.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "KnowledgeTableViewCell.h"

@implementation KnowledgeTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _knowledgeNameLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, KnowledgeCellHeight)];
        _knowledgeNameLab.backgroundColor = [UIColor clearColor];
        _knowledgeNameLab.font = [UIFont systemFontOfSize:15.0];
        [self.contentView addSubview:_knowledgeNameLab];
        
        _signImgView = [[UIImageView alloc] initWithFrame:CGRectMake(MainScreenSize_W - 30, KnowledgeCellHeight/2 - 17*SIZE_TIMES/2, 17*SIZE_TIMES/2, 17*SIZE_TIMES)];
        _signImgView.image = [UIImage imageNamed:@"grayHide"];
        [self.contentView addSubview:_signImgView];
        
        UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, KnowledgeCellHeight-0.5, MainScreenSize_W, 0.5)];
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
