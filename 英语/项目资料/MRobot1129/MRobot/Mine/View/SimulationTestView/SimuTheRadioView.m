//
//  SimuTheRadioView.m
//  MRobot
//
//  Created by mac on 15/9/14.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "SimuTheRadioView.h"
#import "FillBlanksModel.h"

@implementation SimuTheRadioView

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
            _bgView.backgroundColor = [UIColor whiteColor];
            _bgView.layer.cornerRadius = 4;
            _bgView.layer.borderWidth = 0.5;
            _bgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
            [_scrollView addSubview:_bgView];
        }
        
        if (!_titleLabel) {
            _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
            _titleLabel.text = @"题目内容";
            _titleLabel.font = [UIFont systemFontOfSize:15];
            _titleLabel.numberOfLines = 0;
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
            _lineView.backgroundColor = [UIColor lightGrayColor];
            [_bgView addSubview:_lineView];
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
        
        if (([data.qContent rangeOfString:@"<"].location !=NSNotFound&&[data.qContent rangeOfString:@"</"].location !=NSNotFound&&[data.qContent rangeOfString:@">"].location !=NSNotFound)  || [data.qContent rangeOfString:@"&nbsp;"].location !=NSNotFound) {
            NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[data.qContent dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,NSFontAttributeName:[UIFont systemFontOfSize:15] } documentAttributes:nil error:nil];
            _titleLabel.attributedText = attrStr;
        }else{
            _titleLabel.text = data.qContent;
        }
        
    }
    //    _titleLabel.text = data.qContent;
    CGFloat titleH = [BaseAPIManager base_getHeightByContent:_titleLabel.text andFontSize:15 andFixedWidth:self.width - 20];
    _titleLabel.frame = CGRectMake(10, 10, self.width - 20, titleH + 10);
    
    if ((NSNull *)data.qContentPicUrl != [NSNull null] && data.qContentPicUrl.length) {
        [_titleImageView setImageWithURL:[NSURL URLWithString:[data.qContentPicUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"previewImage"]];
        _titleImageView.frame = CGRectMake(10, _titleLabel.bottom, self.width - 20, 80*SIZE_TIMES);
        _lineView.frame =CGRectMake(10, _titleImageView.bottom + 9.5, self.width - 20, 0.5);
    }else{
        _lineView.frame =CGRectMake(10, _titleLabel.bottom + 9.5, self.width - 20, 0.5);
    }
    
    int temp = 0;
    _radioArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < data.options.count; i ++) {
        FillBlanksModel *fillBlank = data.options[i];
        TheRadioView *cell = [[TheRadioView alloc]initWithFrame:CGRectMake(10, _lineView.bottom + 10 + temp, self.width - 20, 50)];
        cell.delegate = self;
        cell.tag = i+1;
        [_radioArray addObject:cell];
        if ([fillBlank.isAnswer isEqualToString:@"1"]) {
            _isAnswer = cell;
        }
        cell.chooseBtn.text = [NSString makeNumWithPinYin:[NSString stringWithFormat:@"%d",i]];
        cell.chooseBtn.frame = CGRectMake(0, 15, 20, 20);
        cell.chooseBtn.layer.masksToBounds = YES;
        cell.chooseBtn.layer.cornerRadius = 10;
        
        NSScanner * scanner = [NSScanner scannerWithString:fillBlank.optionContent];
        NSString * text = nil;
        if([scanner isAtEnd]==NO){
            
            [scanner scanUpToString:@"<" intoString:nil];
            //找到标签的结束位置
            [scanner scanUpToString:@">" intoString:&text];
            
            if (([fillBlank.optionContent rangeOfString:@"<"].location !=NSNotFound&&[fillBlank.optionContent rangeOfString:@"</"].location !=NSNotFound&&[fillBlank.optionContent rangeOfString:@">"].location !=NSNotFound)  || [fillBlank.optionContent rangeOfString:@"&nbsp;"].location !=NSNotFound) {
                NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[fillBlank.optionContent dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,NSFontAttributeName:[UIFont systemFontOfSize:15] } documentAttributes:nil error:nil];
                cell.chooseLabel.attributedText = attrStr;
            }else{
                cell.chooseLabel.text = fillBlank.optionContent;
            }
            
        }
        //        cell.chooseLabel.text = fillBlank.optionContent;
        CGFloat chooseH = 0;
        
        if ((NSNull *)fillBlank.optionPicUrl != [NSNull null]&& fillBlank.optionPicUrl.length) {
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
    _bgView.frame = CGRectMake(0, 10, self.width , temp + _lineView.bottom + 30);
    _scrollView.contentSize= CGSizeMake(0, _bgView.bottom+20);

}

- (void)clickTheDanXuanBtn:(UITapGestureRecognizer *)tap
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(simuTheRadioViewDelegateWithBigImage:)]) {
        [self.delegate simuTheRadioViewDelegateWithBigImage:tap.view];
    }
}

#pragma mark ---TheRadioViewDelegate---
- (void)theRadioViewDelegateWithTag:(UIView *)tap
{
    for (TheRadioView *radio in _radioArray) {
        if (radio.tag == tap.tag) {
            FillBlanksModel *fillBlank = _questionModel.options[tap.tag-1];
            radio.chooseLabel.textColor = PView_GreenColor;
            radio.chooseBtn.textColor = [UIColor whiteColor];
            [radio.chooseBtn setBackgroundColor:PView_GreenColor];
            
            if ([fillBlank.isAnswer isEqualToString:@"1"]) {
                if (self.delegate && [self.delegate respondsToSelector:@selector(simuTheRadioViewDelegateWithAnswer:andTrueOrFalse:)]) {
                    [self.delegate simuTheRadioViewDelegateWithAnswer:fillBlank.optionId andTrueOrFalse:@"1"];
                }
            }else{
                if (self.delegate && [self.delegate respondsToSelector:@selector(simuTheRadioViewDelegateWithAnswer:andTrueOrFalse:)]) {
                    [self.delegate simuTheRadioViewDelegateWithAnswer:fillBlank.optionId andTrueOrFalse:@"2"];
                }
            }
        }else{
            radio.chooseLabel.textColor = [UIColor blackColor];
            [radio.chooseBtn setBackgroundColor:[UIColor whiteColor]];
            radio.chooseBtn.textColor = [UIColor blackColor];
        }
    }
   
}

- (void)theRadioViewDelegateWithBigImage:(UIView *)tapView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(simuTheRadioViewDelegateWithBigImage:)]) {
        [self.delegate simuTheRadioViewDelegateWithBigImage:tapView];
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
