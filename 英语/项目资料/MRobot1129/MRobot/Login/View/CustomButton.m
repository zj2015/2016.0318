//
//  CustomButton.m
//  MRobot
//
//  Created by mac on 15/8/28.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.layer.borderWidth = 0.5f;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 4.0f;
        
        _leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, self.width, self.height)];
        _leftLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:_leftLabel];
        
        _rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.width - 25, self.height/2 - 15/2, 15, 15)];
        _rightImageView.image = [UIImage imageNamed:@"dropdown"];
//        _rightImageView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_rightImageView];
        
        UITapGestureRecognizer * TapGesturRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureRecognizer:)];
        [self addGestureRecognizer:TapGesturRecognizer];
        
    }
    return self;
}

- (void)tapGestureRecognizer:(UITapGestureRecognizer *)tap
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(chooseDifferentCategoriesWithTag:)]) {
        [self.delegate chooseDifferentCategoriesWithTag:tap.view.tag];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
