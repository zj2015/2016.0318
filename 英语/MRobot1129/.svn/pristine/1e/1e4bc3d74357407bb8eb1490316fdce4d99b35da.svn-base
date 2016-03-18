//
//  KSelectTableViewCell.m
//  MRobot
//
//  Created by BaiYu on 15/9/9.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "KSelectTableViewCell.h"

@implementation KSelectTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = PView_BGColor;
        
        _kNameLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40*SIZE_TIMES)];
        _kNameLab.backgroundColor = [UIColor clearColor];
        _kNameLab.font = [UIFont systemFontOfSize:15.0];
        [self.contentView addSubview:_kNameLab];
        
        UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 40*SIZE_TIMES-0.5, 100, 0.5)];
        lineLab.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:lineLab];
        
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

@end
