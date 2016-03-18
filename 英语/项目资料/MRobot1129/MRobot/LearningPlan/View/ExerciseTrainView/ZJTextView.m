//
//  ZJTextView.m
//  ERobot
//
//  Created by mac on 15/7/6.
//  Copyright (c) 2015年 BaiYu. All rights reserved.
//

#import "ZJTextView.h"

@implementation ZJTextView


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _answerLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _answerLabel.frame = CGRectMake(10, 5, 60, 20);
        _answerLabel.text = @"正确答案:";
        _answerLabel.hidden = YES;
        _answerLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:_answerLabel];
        
        _trueLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _trueLabel.frame = CGRectMake(80, 5, MainScreenSize_W -140, 20);
        _trueLabel.font = [UIFont systemFontOfSize:13];
        _trueLabel.textColor = PView_GreenColor;
        _trueLabel.hidden = YES;
        _trueLabel.numberOfLines = 0;
        _trueLabel.text = @"我怎么知道";
        [self addSubview:_trueLabel];
        
        _textView = [[UITextView alloc]initWithFrame:CGRectZero];
        _textView.backgroundColor = [UIColor clearColor];
        _textView.frame = CGRectMake(30, 25, self.width - 65, self.height - 15);
        _textView.font = [UIFont systemFontOfSize:15];
        _textView.returnKeyType = UIReturnKeyDone;
        [self addSubview:_textView];
        
        _lineView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _lineView.frame = CGRectMake(30, self.height - 0.5, self.width - 65, 0.5);
        _lineView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_lineView];
        
        _flagBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _flagBtn.frame = CGRectMake(self.width - 35, self.height - 30, 30, 30);
        _flagBtn.backgroundColor = PView_GreenColor;
        [_flagBtn setTitle:@"确定" forState:UIControlStateNormal];
        _flagBtn.layer.cornerRadius = 5.0;
        _flagBtn.layer.masksToBounds = YES;
        _flagBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [_flagBtn addTarget:self action:@selector(sureYourAnswer:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_flagBtn];
        
        _placeLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _placeLabel.frame = CGRectMake(10, self.height - 20, 20, 20);
        _placeLabel.font = [UIFont boldSystemFontOfSize:14];
        [self addSubview:_placeLabel];
        
    }
    return self;
}


- (void)sureYourAnswer:(UIButton *)btn
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(zjTextViewDelegateWithBtnTag:)]) {
        [self.delegate zjTextViewDelegateWithBtnTag:btn];
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
