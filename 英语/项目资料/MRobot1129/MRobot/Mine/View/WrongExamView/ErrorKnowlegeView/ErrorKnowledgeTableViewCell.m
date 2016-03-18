//
//  ErrorKnowledgeTableViewCell.m
//  ERobot
//
//  Created by BaiYu on 15/7/1.
//  Copyright (c) 2015年 BaiYu. All rights reserved.
//

#import "ErrorKnowledgeTableViewCell.h"

@implementation ErrorKnowledgeTableViewCell
@synthesize knowledgeLab;
@synthesize errorLab;
@synthesize signImgView;

- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        knowledgeLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, MainScreenSize_W - 85, 50*SIZE_TIMES)];
        knowledgeLab.backgroundColor = [UIColor clearColor];
        knowledgeLab.font = [UIFont systemFontOfSize:15.0];
        [self.contentView addSubview:knowledgeLab];
        
        errorLab = [[UILabel alloc] initWithFrame:CGRectMake(MainScreenSize_W - 80, 5*SIZE_TIMES, 50, 20*SIZE_TIMES)];
        errorLab.backgroundColor = [UIColor clearColor];
        errorLab.textAlignment = NSTextAlignmentCenter;
        errorLab.font = [UIFont systemFontOfSize:14.0];
        errorLab.textColor = [UIColor redColor];
        [self.contentView addSubview:errorLab];
        
        UILabel *errorPercentLab = [[UILabel alloc] initWithFrame:CGRectMake(MainScreenSize_W - 80, 25*SIZE_TIMES, 50, 20*SIZE_TIMES)];
        errorPercentLab.backgroundColor = [UIColor clearColor];
        errorPercentLab.textAlignment = NSTextAlignmentCenter;
        errorPercentLab.font = [UIFont systemFontOfSize:13.0];
        errorPercentLab.text = @"错误率";
        errorPercentLab.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:errorPercentLab];
        
        signImgView = [[UIImageView alloc] initWithFrame:CGRectMake(MainScreenSize_W - 30, (50 - 15)/2*SIZE_TIMES, 15*SIZE_TIMES, 15*SIZE_TIMES)];
        [self.contentView addSubview:signImgView];
        
        UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 50*SIZE_TIMES-0.5, MainScreenSize_W, 0.5)];
        lineLab.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:lineLab];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
