//
//  TheRadioView.m
//  ERobot
//
//  Created by mac on 15/7/3.
//  Copyright (c) 2015年 BaiYu. All rights reserved.
//

#import "TheRadioView.h"

@implementation TheRadioView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        if (!_chooseBtn) {
            _chooseBtn = [[UILabel alloc]init];
            _chooseBtn.font = [UIFont systemFontOfSize:15];
            _chooseBtn.textAlignment = NSTextAlignmentCenter;
            _chooseBtn.userInteractionEnabled = YES;
            _chooseBtn.textColor = [UIColor whiteColor];
            _chooseBtn.layer.borderColor = [UIColor whiteColor].CGColor;
            _chooseBtn.layer.borderWidth = 3;
            _chooseBtn.backgroundColor = RgbColor(195,182, 139);
            _chooseBtn.layer.masksToBounds = YES;
            [self addSubview:_chooseBtn];
        }
        
        if (!_chooseImageView) {
            _chooseImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
            _chooseImageView.backgroundColor = [UIColor clearColor];
            _chooseImageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTheCellImageBtn:)];
            [_chooseImageView addGestureRecognizer:tap];
            [self addSubview:_chooseImageView];
        }
        
        if (!_chooseLabel) {
            _chooseLabel = [[UILabel alloc]initWithFrame:CGRectZero];
            _chooseLabel.font = [UIFont systemFontOfSize:15];
            _chooseLabel.numberOfLines = 0;
            _chooseLabel.textColor = [UIColor whiteColor];
            [self addSubview:_chooseLabel];
        }
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCellChoose:)];
        [self addGestureRecognizer:tap];
        
    }
    return self;
}

//你的选项
- (void)clickCellChoose:(UITapGestureRecognizer *)tap
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(theRadioViewDelegateWithTag:)]) {
        [self.delegate theRadioViewDelegateWithTag:tap.view];
    }
    
}

//图片放大
- (void)clickTheCellImageBtn:(UITapGestureRecognizer *)tap
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(theRadioViewDelegateWithBigImage:)]) {
        [self.delegate theRadioViewDelegateWithBigImage:tap.view];
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
