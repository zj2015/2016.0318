//
//  ErrorParsingView.m
//  ERobot
//
//  Created by mac on 15/7/13.
//  Copyright (c) 2015年 BaiYu. All rights reserved.
//

#import "ErrorParsingView.h"

@implementation ErrorParsingView


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = PView_BGColor;
        
        if (!_titleLabel) {
            _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
            _titleLabel.font = [UIFont systemFontOfSize:15];
            _titleLabel.text = @"题目解析:";
            _titleLabel.textColor = [UIColor grayColor];
            [self addSubview:_titleLabel];
        }
        
        if (!_bgView) {
            _bgView = [[UIView alloc]initWithFrame:CGRectZero];
            _bgView.backgroundColor = [UIColor whiteColor];
            _bgView.layer.cornerRadius = 4;
            _bgView.layer.borderWidth = 0.5;
            _bgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
            [self addSubview:_bgView];
        }
        
        if (!_answerLabel) {
            _answerLabel = [[UILabel alloc]initWithFrame:CGRectZero];
            _answerLabel.font = [UIFont systemFontOfSize:14];
            _answerLabel.numberOfLines = 0;
            [_bgView addSubview:_answerLabel];
        }
        
        if (!_masterBtn) {
            _masterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _masterBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
            _masterBtn.backgroundColor = PView_GreenColor;
            _masterBtn.layer.cornerRadius = 4;
            _masterBtn.layer.borderWidth = 0.5;
            [_masterBtn setTitle:@"已掌握" forState:UIControlStateNormal];
            [_masterBtn addTarget:self action:@selector(clickTheMasterBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_masterBtn];
        }
        
        if (!_playBtn) {
            _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _playBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
            _playBtn.backgroundColor = PView_GreenColor;
            _playBtn.layer.cornerRadius = 4.0;
            [_playBtn setTitle:@"查看视频" forState:UIControlStateNormal];
            [_playBtn addTarget:self action:@selector(clickThePlayBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_playBtn];
        }
        
    }
    return self;
    
}

- (void)clickTheMasterBtn:(UIButton *)btn
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(errorParsingViewDelegateWithMasterButton:)]) {
        [self.delegate errorParsingViewDelegateWithMasterButton:btn];
    }
}

- (void)clickThePlayBtn:(UIButton *)btn
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(errorParsingViewDelegateWithPlayButton:)]) {
        [self.delegate errorParsingViewDelegateWithPlayButton:btn];
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
