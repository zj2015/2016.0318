//
//  SimuBlanksView.m
//  MRobot
//
//  Created by mac on 15/9/14.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "SimuBlanksView.h"

@implementation SimuBlanksView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectZero];
        _scrollView.frame = CGRectMake(0, 0, self.width, self.height);
        _scrollView.backgroundColor = PView_BGColor;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:_scrollView];
        
        if (!_topBgView) {
            _topBgView = [[UIView alloc]initWithFrame:CGRectZero];
            _topBgView.backgroundColor = [UIColor whiteColor];
            _topBgView.layer.cornerRadius = 4;
            _topBgView.layer.borderWidth = 0.5;
            _topBgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
            [_scrollView addSubview:_topBgView];
        }
        
        if (!_answerLabel) {
            _answerLabel = [[UILabel alloc]initWithFrame:CGRectZero];
            _answerLabel.font = [UIFont systemFontOfSize:15];
            _answerLabel.textColor = [UIColor grayColor];
            [_scrollView addSubview:_answerLabel];
        }
        
        if (!_contentLabel) {
            _contentLabel = [[UILabel alloc]initWithFrame:CGRectZero];
            _contentLabel.font = [UIFont systemFontOfSize:15];
            _contentLabel.numberOfLines = 0;
            _contentLabel.backgroundColor = [UIColor clearColor];
            [_topBgView addSubview:_contentLabel];
        }
        
        if (!_contentImageView) {
            _contentImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
            _contentImageView.userInteractionEnabled = YES;
            _contentImageView.backgroundColor = [UIColor clearColor];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTheTianImageBtn:)];
            [_contentImageView addGestureRecognizer:tap];
            [_topBgView addSubview:_contentImageView];
        }
        
        if (!_bottomBgView) {
            _bottomBgView = [[UIView alloc]initWithFrame:CGRectZero];
            _bottomBgView.backgroundColor = [UIColor whiteColor];
            _bottomBgView.layer.cornerRadius = 4;
            _bottomBgView.layer.borderWidth = 0.5;
            _bottomBgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
            [_scrollView addSubview:_bottomBgView];
        }
    }
    return self;
}

- (void)addTianKongData:(QuestionListModel *)data
{
    NSScanner * scanner = [NSScanner scannerWithString:data.qContent];
    NSString * text = nil;
    
    if([scanner isAtEnd]==NO){
        
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        
        if (([data.qContent rangeOfString:@"<"].location !=NSNotFound&&[data.qContent rangeOfString:@"</"].location !=NSNotFound&&[data.qContent rangeOfString:@">"].location !=NSNotFound)  || [data.qContent rangeOfString:@"&nbsp;"].location !=NSNotFound) {
            NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[data.qContent dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,NSFontAttributeName:[UIFont systemFontOfSize:15] } documentAttributes:nil error:nil];
            _contentLabel.attributedText = attrStr;
        }else{
            _contentLabel.text = data.qContent;
        }
        
    }
    
    CGFloat contentH = [BaseAPIManager base_getHeightByContent:_contentLabel.text andFontSize:15 andFixedWidth:self.width - 20];
    _contentLabel.frame = CGRectMake(10, 5, self.width - 20, contentH + 10);
    
    if ((NSNull *)data.qContentPicUrl != [NSNull null] && data.qContentPicUrl.length) {
        [_contentImageView setImageWithURL:[NSURL URLWithString:[data.qContentPicUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"previewImage"]];
        _contentImageView.frame = CGRectMake(10, _contentLabel.bottom + 10, self.width - 20, 80*SIZE_TIMES);
        _topBgView.frame = CGRectMake(0, 10, self.width , _contentImageView.bottom + 10);
    }else{
        _topBgView.frame = CGRectMake(0, 10, self.width , _contentLabel.bottom + 10);
    }
    
    _answerLabel.frame = CGRectMake(0, _topBgView.bottom + 10, self.width, 20);
    _answerLabel.text = @"我的答案:";
    
    _answerArr = [NSArray arrayWithArray:data.options];
    int temp = 0;
    for (int i = 0; i < [data.options count]; i ++ ) {
        _answerView = [[ZJTextView alloc]initWithFrame:CGRectMake(10, 10+ temp, self.width -20, 50)];
        _answerView.placeLabel.text = [NSString stringWithFormat:@"%d .",i+1];
        _answerView.flagBtn.hidden = YES;
        _answerView.delegate = self;
        _answerView.textView.delegate = self;
        _answerView.textView.tag = i;
        _answerView.flagBtn.tag = i;
        _answerView.tag = i;
        [_bottomBgView addSubview:_answerView];
        temp += 60;
    }
    
    _bottomBgView.frame = CGRectMake(0, _topBgView.bottom + 40, self.width, _answerView.bottom + 40);
    
    _scrollView.contentSize= CGSizeMake(0, _bottomBgView.bottom+20);

}

- (void)clickTheTianImageBtn:(UITapGestureRecognizer *)tap
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(simuBlanksViewDelegateWithBigImage:)]) {
        [self.delegate simuBlanksViewDelegateWithBigImage:tap.view];
    }
}

#pragma mark --UITextViewDelegate---

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        [self endEditing:YES];
        //去除前后空格
        textView.text=[textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    textView.text=[textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    ZJTextView *zjView = nil;
    CGFloat help = 0;
    int i = 0;
    int j = 0;
    for (UIView *view in [_bottomBgView subviews]) {
        zjView = (ZJTextView *)view;
        
        FillBlanksModel *fillBlank = [[FillBlanksModel alloc]init];
        fillBlank = _answerArr[zjView.tag];
        
        if (zjView.textView.text.length != 0) {
            if ([fillBlank.optionContent isEqualToString:zjView.textView.text]) {
                j ++;
            }else{
                if([fillBlank.optionContent rangeOfString:@"|"].location != NSNotFound){
                    NSArray *array = [fillBlank.optionContent componentsSeparatedByString:@"|"];
                    for (int i = 0; i < array.count; i ++) {
                        if ([zjView.textView.text isEqualToString:array[i]]) {
                            j ++;
                        }else{
                            if (self.delegate && [self.delegate respondsToSelector:@selector(simuBlanksViewDelegateWithAnswer:andTrueOrFalse:andTag:)]) {
                                [self.delegate simuBlanksViewDelegateWithAnswer:zjView.textView.text andTrueOrFalse:@"2" andTag:(int)zjView.tag];
                            }
                        }
                    }
                }else{
                    if (self.delegate && [self.delegate respondsToSelector:@selector(simuBlanksViewDelegateWithAnswer:andTrueOrFalse:andTag:)]) {
                        [self.delegate simuBlanksViewDelegateWithAnswer:zjView.textView.text andTrueOrFalse:@"2" andTag:(int)zjView.tag];
                    }
                }
            }
            if (j == [[_bottomBgView subviews] count]) { // 全部为空 是0
                if (self.delegate && [self.delegate respondsToSelector:@selector(simuBlanksViewDelegateWithAnswer:andTrueOrFalse:andTag:)]) {
                    [self.delegate simuBlanksViewDelegateWithAnswer:zjView.textView.text andTrueOrFalse:@"1" andTag:(int)zjView.tag];
                }
            }else{
                if (self.delegate && [self.delegate respondsToSelector:@selector(simuBlanksViewDelegateWithAnswer:andTrueOrFalse:andTag:)]) {//只有一个空   是2 错
                    [self.delegate simuBlanksViewDelegateWithAnswer:zjView.textView.text andTrueOrFalse:@"2" andTag:(int)zjView.tag];
                }
            }
            
        }
        if (zjView.textView.text.length == 0) {
            if (i == [[_bottomBgView subviews] count]-1) { // 全部为空 是0
                if (self.delegate && [self.delegate respondsToSelector:@selector(simuBlanksViewDelegateWithAnswer:andTrueOrFalse:andTag:)]) {
                    [self.delegate simuBlanksViewDelegateWithAnswer:zjView.textView.text andTrueOrFalse:@"0" andTag:(int)zjView.tag];
                }
               
            }else{
                if (self.delegate && [self.delegate respondsToSelector:@selector(simuBlanksViewDelegateWithAnswer:andTrueOrFalse:andTag:)]) {//只有一个空   是2 错
                    [self.delegate simuBlanksViewDelegateWithAnswer:zjView.textView.text andTrueOrFalse:@"2" andTag:(int)zjView.tag];
                }
            }
             i++;
        }
        CGFloat textH = [BaseAPIManager base_getHeightByContent:zjView.textView.text andFontSize:15 andFixedWidth:self.width - 80]+5;
        if (textH < 25) {
            textH = 25;
        }
        zjView.frame = CGRectMake(10, 10+ help, self.width -20, textH + 25);
        zjView.textView.frame = CGRectMake(30, 25, zjView.width - 60, textH);
        zjView.lineView.frame = CGRectMake(30, zjView.height -0.5, zjView.width - 40, 0.5);
        zjView.placeLabel.frame = CGRectMake(10, zjView.height - 20, 20, 20);
        zjView.backgroundColor = [UIColor clearColor];
        help += (textH + 35);

    }
    _bottomBgView.frame = CGRectMake(0, _topBgView.bottom + 40, self.width, help + 40);
    _scrollView.contentSize= CGSizeMake(0, _bottomBgView.bottom+50);
    
}

- (void)zjTextViewDelegateWithBtnTag:(UIButton *)btn
{
    // 不用填写填空的时候不需要
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
