//
//  QuestionView.m
//  ERobot
//
//  Created by mac on 15/7/2.
//  Copyright (c) 2015年 BaiYu. All rights reserved.
//

#import "QuestionView.h"

#import "FillBlanksModel.h"

#define fontsize   17
@implementation QuestionView


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectZero];
        _scrollView.frame = CGRectMake(0, 0, self.width, self.height);
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.backgroundColor = PView_BGColor;
        [self addSubview:_scrollView];
        
        if (!_bgView) {
            _bgView = [[UIView alloc]initWithFrame:CGRectZero];
            _bgView.backgroundColor = RgbColor(174, 159, 110);
            [_scrollView addSubview:_bgView];
        }
        
        if (!_titleLabel) {
            _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
            _titleLabel.text = @"题目内容";
            _titleLabel.font = [UIFont systemFontOfSize:fontsize];
            _titleLabel.numberOfLines = 0;
            _titleLabel.textColor = [UIColor whiteColor];
            _titleLabel.backgroundColor = [UIColor clearColor];
            [_bgView addSubview:_titleLabel];
        }
        
        if (!_titleImageView) {
            _titleImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
            _titleImageView.backgroundColor = [UIColor clearColor];
            _titleImageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTheDanXuanBtn:)];
            [_titleImageView addGestureRecognizer:tap];
            [_bgView addSubview:_titleImageView];
        }
        
        if (!_lineView) {
            _lineView = [[UIImageView alloc]initWithFrame:CGRectZero];
            _lineView.backgroundColor = [UIColor clearColor];
            [_bgView addSubview:_lineView];
        }
        
        if (!_parsingView) {
            _parsingView = [[ErrorParsingView alloc]initWithFrame:CGRectZero];
            _parsingView.delegate = self;
            [_scrollView addSubview:_parsingView];
        }
        
    }
    return self;
}

- (void)addDanxuanData:(QuestionListModel *)data
{
    _questionModel = data;
    
    NSScanner * scanner = [NSScanner scannerWithString:data.qContent];
    NSString * text = nil;
    if([scanner isAtEnd]==NO){
        
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        
        if (([data.qContent rangeOfString:@"<"].location !=NSNotFound&&[data.qContent rangeOfString:@"</"].location !=NSNotFound&&[data.qContent rangeOfString:@">"].location !=NSNotFound) || [data.qContent rangeOfString:@"&nbsp;"].location !=NSNotFound) {
            NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[data.qContent dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,NSFontAttributeName:[UIFont systemFontOfSize:fontsize] } documentAttributes:nil error:nil];
            _titleLabel.attributedText = attrStr;
        }else{
            _titleLabel.text = data.qContent;
        }
        
    }
    CGFloat titleH = [BaseAPIManager base_getHeightByContent:_titleLabel.text andFontSize:fontsize andFixedWidth:self.width - 20];
    _titleLabel.frame = CGRectMake(10, 10, self.width - 20, titleH + 10);
    
    if ((NSNull *)data.qContentPicUrl != [NSNull null] && data.qContentPicUrl.length) {
        [_titleImageView setImageWithURL:[NSURL URLWithString:[data.qContentPicUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"previewImage"]];
        _titleImageView.frame = CGRectMake(10, _titleLabel.bottom, self.width - 20, 80*SIZE_TIMES);
        _lineView.frame =CGRectMake(10, _titleImageView.bottom + 9.5, self.width - 20, 0.5);
    }else{
        _lineView.frame =CGRectMake(10, _titleLabel.bottom + 9.5, self.width - 20, 0.5);
    }
    
    int temp = 0;
    for (int i = 0; i < data.options.count; i ++) {
        FillBlanksModel *fillBlank = data.options[i];
        TheRadioView *cell = [[TheRadioView alloc]initWithFrame:CGRectMake(10, _lineView.bottom + 10 + temp, self.width - 20, 50)];
        cell.delegate = self;
        cell.tag = i+1;
        if ([fillBlank.isAnswer isEqualToString:@"1"]) {
            _isAnswer = cell;
        }
        cell.chooseBtn.text = [NSString makeNumWithPinYin:[NSString stringWithFormat:@"%d",i]];
        cell.chooseBtn.frame = CGRectMake(0, 15, 20, 20);
        cell.chooseBtn.layer.cornerRadius = cell.chooseBtn.width/2.0;
        NSScanner * scanner = [NSScanner scannerWithString:fillBlank.optionContent];
        NSString * text = nil;
        if([scanner isAtEnd]==NO){
            
            [scanner scanUpToString:@"<" intoString:nil];
            //找到标签的结束位置
            [scanner scanUpToString:@">" intoString:&text];
            
            if (([fillBlank.optionContent rangeOfString:@"<"].location !=NSNotFound&&[fillBlank.optionContent rangeOfString:@"</"].location !=NSNotFound&&[fillBlank.optionContent rangeOfString:@">"].location !=NSNotFound) || [fillBlank.optionContent rangeOfString:@"&nbsp;"].location !=NSNotFound) {
                NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[fillBlank.optionContent dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,NSFontAttributeName:[UIFont systemFontOfSize:15] } documentAttributes:nil error:nil];
                cell.chooseLabel.attributedText = attrStr;
            }else{
                cell.chooseLabel.text = fillBlank.optionContent;
            }
            
        }
        CGFloat chooseH = 0;
        
        if ((NSNull *)fillBlank.optionPicUrl != [NSNull null] && fillBlank.optionPicUrl.length) {
            [cell.chooseImageView setImageWithURL:[NSURL URLWithString:[fillBlank.optionPicUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"previewImage"]];
            cell.chooseImageView.frame = CGRectMake(30, 5, 50, 30);
            chooseH = [BaseAPIManager base_getHeightByContent:cell.chooseLabel.text andFontSize:15 andFixedWidth:self.width - 120];
            cell.chooseLabel.frame = CGRectMake(cell.chooseImageView.right + 10, 10, self.width - 120, chooseH + 10);
        }else{
            chooseH = [BaseAPIManager base_getHeightByContent:cell.chooseLabel.text andFontSize:15 andFixedWidth:self.width - 70];
            cell.chooseLabel.frame = CGRectMake(cell.chooseBtn.right + 10, 10, self.width - 70, chooseH + 10);
        }
        
        cell.frame = CGRectMake(10, _lineView.bottom + 10 + temp, self.width - 20, chooseH + 20);
        cell.chooseLabel.backgroundColor = [UIColor clearColor];
        [_scrollView addSubview:cell];
        temp += chooseH + 25;
    }
    _bgView.frame = CGRectMake(0, 0, self.width , temp + _lineView.bottom + 30);
    _scrollView.contentSize= CGSizeMake(0, _bgView.bottom+20);
    
    if ((NSNull *)data.answerVideoAnalysis != [NSNull null]) {
        if ([_whichMV isEqualToString:@"讲解视频"]) {
            _voideUrl = data.answerVideoAnalysis;
            _parsingView.hidden = NO;
            _parsingView.playBtn.frame = CGRectMake(0, 10, self.width, 35);
            _parsingView.frame = CGRectMake(0, _bgView.bottom +20, self.width, 45);
            _scrollView.contentSize= CGSizeMake(0, _parsingView.bottom+20);
        }
    }
}

- (void)clickTheDanXuanBtn:(UITapGestureRecognizer *)tap
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(questionViewDelegateWithBigImage:)]) {
        [self.delegate questionViewDelegateWithBigImage:tap.view];
    }
}

#pragma mark ---TheRadioViewDelegate---
- (void)theRadioViewDelegateWithTag:(UIView *)tap
{
    if (!_only) {
        FillBlanksModel *fillBlank = _questionModel.options[tap.tag-1];
        TheRadioView *cell = (TheRadioView *)tap;
        cell.chooseBtn.backgroundColor = [UIColor redColor];
        cell.chooseLabel.textColor = [UIColor whiteColor];
        cell.chooseBtn.textColor = [UIColor whiteColor];
        
        TheRadioView *cells = (TheRadioView *)_isAnswer;
        cells.chooseBtn.backgroundColor = [UIColor greenColor];
        cells.chooseLabel.textColor = [UIColor whiteColor];
        cells.chooseBtn.textColor = [UIColor whiteColor];
        
        if (cell.tag == cells.tag ) {
            [[SoundTools sharedSoundTools] playSoundWithName:@"ui_yes"];
            if (self.delegate && [self.delegate respondsToSelector:@selector(questionViewDelegateWithAnswer:andTrueOrFalse:)]) {
                [self.delegate questionViewDelegateWithAnswer:fillBlank.optionId andTrueOrFalse:[NSString stringWithFormat:@"%d",1]];
            }
        }else{
            [[SoundTools sharedSoundTools] playSoundWithName:@"ui_no"];
            if (self.delegate && [self.delegate respondsToSelector:@selector(questionViewDelegateWithAnswer:andTrueOrFalse:)]) {
                [self.delegate questionViewDelegateWithAnswer:fillBlank.optionId andTrueOrFalse:[NSString stringWithFormat:@"%d",2]];
            }
        }
        _only = YES;
    }
}

//单元格图片放大
- (void)theRadioViewDelegateWithBigImage:(UIView *)tapView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(questionViewDelegateWithBigImage:)]) {
        [self.delegate questionViewDelegateWithBigImage:tapView];
    }
}


#pragma mark ---ErrorParsingViewDelegate---
- (void)errorParsingViewDelegateWithMasterButton:(UIButton *)btn
{
    
}

- (void)errorParsingViewDelegateWithPlayButton:(UIButton *)btn
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(questionViewDelegateWithPlayVideo:)]) {
        [self.delegate questionViewDelegateWithPlayVideo:_voideUrl];
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
