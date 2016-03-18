//
//  WrongTitleTableViewCell.m
//  ERobot
//
//  Created by BaiYu on 15/7/6.
//  Copyright (c) 2015年 BaiYu. All rights reserved.
//

#import "WrongTitleTableViewCell.h"

@implementation WrongTitleTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainScreenSize_W,50)];
        bgView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
        [self.contentView addSubview:bgView];
    
        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(5, 1, MainScreenSize_W-10, 48)];
        titleView.backgroundColor = [UIColor whiteColor];
        [bgView addSubview:titleView];

        UILabel *leftSignLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
        leftSignLab.backgroundColor = [UIColor colorWithRed:35/255.0 green:174/255.0 blue:92/255.0 alpha:1];
        leftSignLab.clipsToBounds = YES;
        leftSignLab.layer.cornerRadius = 5;
        [titleView addSubview:leftSignLab];

        UILabel *contentLab = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, MainScreenSize_W - 70, 30)];
        contentLab.text = @"Who are you?";
        [titleView addSubview:contentLab];
    
//        UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        moreBtn.frame = CGRectMake(10, 7 + 50*[_dataArr count], UIScreenWidth - 20, 35);
//        [moreBtn setBackgroundImage:[UIImage imageNamed:@"greenBg"] forState:UIControlStateNormal];
//        moreBtn.titleLabel.font = [UIFont systemFontOfSize:16];
//        [moreBtn setTitle:@"查看更多" forState:UIControlStateNormal];
//        [moreBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [moreBtn addTarget:self action:@selector(showMoreQuestion) forControlEvents:UIControlEventTouchUpInside];
//        [bgView addSubview:moreBtn];
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
