//
//  TianQuestionView.m
//  ERobot
//
//  Created by mac on 15/7/3.
//  Copyright (c) 2015年 BaiYu. All rights reserved.
//

#import "TianQuestionView.h"
#define fontsize   17
@implementation TianQuestionView

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
            _topBgView.backgroundColor = RgbColor(174, 159, 110);
            [_scrollView addSubview:_topBgView];
        }
        
        if (!_answerLabel) {
            _answerLabel = [[UILabel alloc]initWithFrame:CGRectZero];
            _answerLabel.font = [UIFont systemFontOfSize:15];
            _answerLabel.textColor = [UIColor orangeColor];
            [_scrollView addSubview:_answerLabel];
        }
        
        if (!_contentLabel) {
            _contentLabel = [[UILabel alloc]initWithFrame:CGRectZero];
            _contentLabel.font = [UIFont systemFontOfSize:fontsize];
            _contentLabel.numberOfLines = 0;
            _contentLabel.backgroundColor = [UIColor clearColor];
            _contentLabel.textColor = [UIColor whiteColor];
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
            _bottomBgView.backgroundColor = PView_BGColor;
            [_scrollView addSubview:_bottomBgView];
        }
        
        if (!_parsingView) {
            _parsingView = [[ErrorParsingView alloc]initWithFrame:CGRectZero];
            _parsingView.delegate = self;
            [_scrollView addSubview:_parsingView];
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
            NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[data.qContent dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,NSFontAttributeName:[UIFont systemFontOfSize:fontsize] } documentAttributes:nil error:nil];
            _contentLabel.attributedText = attrStr;
        }else{
            _contentLabel.text = data.qContent;
        }
        
    }

    CGFloat contentH = [BaseAPIManager base_getHeightByContent:_contentLabel.text andFontSize:fontsize andFixedWidth:self.width - 20];
    _contentLabel.frame = CGRectMake(10, 5, self.width - 20, contentH + 10);
   
    if ((NSNull *)data.qContentPicUrl != [NSNull null] && data.qContentPicUrl.length) {
        
        [_contentImageView setImageWithURL:[NSURL URLWithString:[data.qContentPicUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"previewImage"]];
        _contentImageView.frame = CGRectMake(10, _contentLabel.bottom + 10, self.width - 20, 80*SIZE_TIMES);
        _topBgView.frame = CGRectMake(0, 0, self.width , _contentImageView.bottom + 10);
    }else{
        _topBgView.frame = CGRectMake(0, 0, self.width , _contentLabel.bottom + 10);
    }

    _answerLabel.frame = CGRectMake(0, _topBgView.bottom + 10, self.width, 20);
    _answerLabel.text = @"你的答案:";
    
    _answerArr = [NSArray arrayWithArray:data.options];
    int temp = 0;
    for (int i = 0; i < [data.options count]; i ++ ) {
        _answerView = [[ZJTextView alloc]initWithFrame:CGRectMake(0, 10+ temp, self.width, 50)];
        _answerView.placeLabel.text = [NSString stringWithFormat:@"%d .",i+1];
        _answerView.delegate = self;
        _answerView.textView.delegate = self;
        _answerView.textView.tag = i;
        _answerView.flagBtn.tag = i;
        _answerView.tag = i;
        [_bottomBgView addSubview:_answerView];
        temp += 60;
    }

    _bottomBgView.frame = CGRectMake(0, _topBgView.bottom + 40, self.width, _answerView.bottom + 40);
    
    _scrollView.contentSize= CGSizeMake(0, _bottomBgView.bottom+50);
    if ((NSNull *)data.answerVideoAnalysis != [NSNull null]) {
        if ([_whichMV isEqualToString:@"讲解视频"]) {
            _voideUrl = data.answerVideoAnalysis;
            _parsingView.hidden = NO;
            _parsingView.playBtn.frame = CGRectMake(0, 10, self.width, 35);
            _parsingView.frame = CGRectMake(0, _bottomBgView.bottom +20, self.width, 45);
            _scrollView.contentSize= CGSizeMake(0, _parsingView.bottom+50);
        }
    }
}

- (void)clickTheTianImageBtn:(UITapGestureRecognizer *)tap
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tianQuestionViewDelegateWithBigImage:)]) {
        [self.delegate tianQuestionViewDelegateWithBigImage:tap.view];
    }
}

#pragma mark --UITextViewDelegate---

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        [self endEditing:YES];
        //去除前后空格
        textView.text=[textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        //禁用
//        if (textView.text.length != 0) {
//            textView.userInteractionEnabled = NO;
//            DLog(@"======%ld",textView.tag);
//        }else{
//           
//        }
        
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    ZJTextView *zjView = nil;
    CGFloat help = 0;
    for (UIView *view in [_bottomBgView subviews]) {
        zjView = (ZJTextView *)view;
        FillBlanksModel *fillBlank = [[FillBlanksModel alloc]init];
        fillBlank = _answerArr[zjView.tag];
        NSString *strUrl = [fillBlank.optionContent stringByReplacingOccurrencesOfString:@"|" withString:@"|"];
        
        if (zjView.tag == textView.tag) {
            CGFloat textH = [BaseAPIManager base_getHeightByContent:zjView.textView.text andFontSize:15 andFixedWidth:self.width - 80]+5;
            if (textH < 25) {
                textH = 25;
            }
            zjView.frame = CGRectMake(0, 10+ help, self.width, textH + 25);
            zjView.textView.frame = CGRectMake(30, 25, zjView.width - 60, textH);
            zjView.lineView.frame = CGRectMake(30, zjView.height -0.5, zjView.width - 40, 0.5);
            zjView.placeLabel.frame = CGRectMake(10, zjView.height - 20, 20, 20);
            zjView.flagBtn.frame = CGRectMake(zjView.width - 35, zjView.height - 30, 30, 30);
            zjView.backgroundColor = [UIColor clearColor];
            help += (textH + 35);
        }else{
            
            CGFloat textH = [BaseAPIManager base_getHeightByContent:zjView.textView.text andFontSize:15 andFixedWidth:self.width - 80]+5;
            if (textH < 25) {
                textH = 25;
            }
            if ([zjView.flagBtn.titleLabel.text isEqualToString:@"确定"]) {
                zjView.frame = CGRectMake(0, 10+ help, self.width, textH + 25);
                zjView.textView.frame = CGRectMake(30, 25, zjView.width - 60, textH);
                zjView.lineView.frame = CGRectMake(30, zjView.height -0.5, zjView.width - 40, 0.5);
                zjView.placeLabel.frame = CGRectMake(10, zjView.height - 20, 20, 20);
                zjView.flagBtn.frame = CGRectMake(zjView.width - 35, zjView.height - 30, 30, 30);
                zjView.backgroundColor = [UIColor clearColor];
                help += (textH + 35);
            }else{
                CGFloat answerH = [BaseAPIManager base_getHeightByContent:strUrl andFontSize:13 andFixedWidth:MainScreenSize_W -140]+5;
                if (answerH < 20) {
                    answerH = 20;
                }
                zjView.frame = CGRectMake(0, 10+ help, self.width, textH+answerH+5);
                zjView.flagBtn.frame = CGRectMake(zjView.width - 35, zjView.height - 30, 30, 30);
                zjView.trueLabel.frame = CGRectMake(80, 5, MainScreenSize_W -140, answerH);
                zjView.textView.frame = CGRectMake(30, zjView.trueLabel.bottom, zjView.width - 60, textH);
                zjView.lineView.frame = CGRectMake(30, zjView.height -0.5, zjView.width - 40, 0.5);
                zjView.placeLabel.frame = CGRectMake(10, zjView.height - 20, 20, 20);
                zjView.backgroundColor = [UIColor clearColor];
                help += (textH + 15 + answerH);
                
            }
            
        }
    }
    _bottomBgView.frame = CGRectMake(0, _topBgView.bottom + 40, self.width, help + 40);
    _scrollView.contentSize= CGSizeMake(0, _bottomBgView.bottom+50);
    
}

#pragma mark ---ZJTextViewDelegate---

- (void)zjTextViewDelegateWithBtnTag:(UIButton *)btn
{
    [self endEditing:YES];
    
    //判断对错
    ZJTextView *zjView = nil;
    CGFloat help = 0;
    int setOne = 0;
   
    NSString * answer = nil;
    for (UIView *view in [_bottomBgView subviews]) {
        zjView = (ZJTextView *)view;
        FillBlanksModel *fillBlank = [[FillBlanksModel alloc]init];
        fillBlank = _answerArr[zjView.tag];
        NSString *strUrl = [fillBlank.optionContent stringByReplacingOccurrencesOfString:@"|" withString:@"|"];
        NSString *str =[zjView.textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        // 长度不为零
        if (str.length != 0 ) {
            // 当前编辑的文本框
            if (zjView.tag == btn.tag ) {
                zjView.textView.userInteractionEnabled = NO;
                btn.userInteractionEnabled = NO;
                zjView.answerLabel.hidden = NO;
                zjView.trueLabel.hidden = NO;
                zjView.trueLabel.text = strUrl;
                
                CGFloat textH = [BaseAPIManager base_getHeightByContent:zjView.textView.text andFontSize:15 andFixedWidth:self.width - 80]+5;
                if (textH < 25) {
                    textH = 25;
                }
                CGFloat answerH = [BaseAPIManager base_getHeightByContent:strUrl andFontSize:13 andFixedWidth:MainScreenSize_W -140]+5;
                if (answerH < 20) {
                    answerH = 20;
                }
                zjView.frame = CGRectMake(0, 10+ help, self.width, textH+answerH+5);
                zjView.trueLabel.frame = CGRectMake(80, 5, MainScreenSize_W -140, answerH);
                zjView.textView.frame = CGRectMake(30, zjView.trueLabel.bottom, zjView.width - 60, textH);
                zjView.lineView.frame = CGRectMake(30, zjView.height -0.5, zjView.width - 40, 0.5);
                zjView.placeLabel.frame = CGRectMake(10, zjView.height - 20, 20, 20);
                zjView.flagBtn.frame = CGRectMake(zjView.width - 35, zjView.height - 30, 30, 30);
//                zjView.flagBtn.layer.cornerRadius = 15.0;
//                zjView.flagBtn.layer.masksToBounds = YES;
                zjView.backgroundColor = [UIColor clearColor];
                help += (textH + 15 + answerH);
                
                if([strUrl rangeOfString:@"|"].location != NSNotFound)
                {
                    NSArray *array = [strUrl componentsSeparatedByString:@"|"];
                    for (int i = 0; i < array.count; i ++) {
                        if ([str isEqualToString:array[i]]) {
                            [[SoundTools sharedSoundTools] playSoundWithName:@"ui_yes"];
                            zjView.flagBtn.backgroundColor = [UIColor clearColor];
                            [zjView.flagBtn setTitle:@"" forState:UIControlStateNormal];
                            [zjView.flagBtn setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
                            zjView.textView.textColor = PView_GreenColor;
                            if (setOne == [[_bottomBgView subviews] count]-1) {
                                answer = @"1";
                            }else{
                                answer = @"2";
                            }
                            setOne ++;
                            if (self.delegate && [self.delegate respondsToSelector:@selector(tianQuestionViewDelegateWithAnswer:andTrueOrFalse:andTag:)]) {
                                [self.delegate tianQuestionViewDelegateWithAnswer:str andTrueOrFalse:answer andTag:(int)zjView.tag];
                            }
                            break;
                        }else{
                            [[SoundTools sharedSoundTools] playSoundWithName:@"ui_no"];
                            zjView.flagBtn.backgroundColor = [UIColor clearColor];
                            [zjView.flagBtn setTitle:@"" forState:UIControlStateNormal];
                            [zjView.flagBtn setImage:[UIImage imageNamed:@"cross"] forState:UIControlStateNormal];
                            zjView.textView.textColor = PView_RedColor;
                            if (self.delegate && [self.delegate respondsToSelector:@selector(tianQuestionViewDelegateWithAnswer:andTrueOrFalse:andTag:)]) {
                                [self.delegate tianQuestionViewDelegateWithAnswer:str andTrueOrFalse:@"2" andTag:(int)zjView.tag];
                            }
                        }
                    }
                }
                else
                {
                    NSLog(@"no");
                    if ([str isEqualToString:strUrl]) {
                        PLog(@"=======true");
                        [[SoundTools sharedSoundTools] playSoundWithName:@"ui_yes"];
                        zjView.flagBtn.backgroundColor = [UIColor clearColor];
                        [zjView.flagBtn setTitle:@"" forState:UIControlStateNormal];
                        [zjView.flagBtn setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
                        zjView.textView.textColor = PView_GreenColor;
                        if (setOne == [[_bottomBgView subviews] count]-1) {
                            answer = @"1";
                        }else{
                            answer = @"2";
                        }
                        setOne ++;
                        if (self.delegate && [self.delegate respondsToSelector:@selector(tianQuestionViewDelegateWithAnswer:andTrueOrFalse:andTag:)]) {
                            [self.delegate tianQuestionViewDelegateWithAnswer:str andTrueOrFalse:answer andTag:(int)zjView.tag];
                        }
                    }else{
                        PLog(@"=======flase");
                        [[SoundTools sharedSoundTools] playSoundWithName:@"ui_no"];
                        zjView.flagBtn.backgroundColor = [UIColor clearColor];
                        [zjView.flagBtn setTitle:@"" forState:UIControlStateNormal];
                        [zjView.flagBtn setImage:[UIImage imageNamed:@"cross"] forState:UIControlStateNormal];
                        zjView.textView.textColor = PView_RedColor;
                        if (self.delegate && [self.delegate respondsToSelector:@selector(tianQuestionViewDelegateWithAnswer:andTrueOrFalse:andTag:)]) {
                            [self.delegate tianQuestionViewDelegateWithAnswer:str andTrueOrFalse:@"2" andTag:(int)zjView.tag];
                        }
                    }
                }
            }else{
                CGFloat textH = [BaseAPIManager base_getHeightByContent:zjView.textView.text andFontSize:15 andFixedWidth:self.width - 80]+5;
                if (textH < 25) {
                    textH = 25;
                }
                if ([zjView.flagBtn.titleLabel.text isEqualToString:@"确定"]) {
                    zjView.frame = CGRectMake(0, 10+ help, self.width, textH + 25);
                    zjView.textView.frame = CGRectMake(30, 25, zjView.width - 60, textH);
                    zjView.lineView.frame = CGRectMake(30, zjView.height -0.5, zjView.width - 40, 0.5);
                    zjView.placeLabel.frame = CGRectMake(10, zjView.height - 20, 20, 20);
                    zjView.flagBtn.frame = CGRectMake(zjView.width - 35, zjView.height - 30, 30, 30);
                    zjView.backgroundColor = [UIColor clearColor];
                    help += (textH + 35);

                }else{
                    CGFloat answerH = [BaseAPIManager base_getHeightByContent:strUrl andFontSize:13 andFixedWidth:MainScreenSize_W -140]+5;
                    if (answerH < 20) {
                        answerH = 20;
                    }
                    zjView.frame = CGRectMake(0, 10+ help, self.width, textH+answerH+5);
                    zjView.flagBtn.frame = CGRectMake(zjView.width - 35, zjView.height - 30, 30, 30);
                    zjView.trueLabel.frame = CGRectMake(80, 5, MainScreenSize_W -140, answerH);
                    zjView.textView.frame = CGRectMake(30, zjView.trueLabel.bottom, zjView.width - 60, textH);
                    zjView.lineView.frame = CGRectMake(30, zjView.height -0.5, zjView.width - 40, 0.5);
                    zjView.placeLabel.frame = CGRectMake(10, zjView.height - 20, 20, 20);
                    zjView.backgroundColor = [UIColor clearColor];
                    help += (textH + 15 + answerH);
                    
                    if([strUrl rangeOfString:@"|"].location != NSNotFound)
                    {
                        NSArray *array = [strUrl componentsSeparatedByString:@"|"];
                        for (int i = 0; i < array.count; i ++) {
                            if ([str isEqualToString:array[i]]) {
                                [[SoundTools sharedSoundTools] playSoundWithName:@"ui_yes"];
                                zjView.flagBtn.backgroundColor = [UIColor clearColor];
                                [zjView.flagBtn setTitle:@"" forState:UIControlStateNormal];
                                [zjView.flagBtn setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
                                zjView.textView.textColor = PView_GreenColor;
                                if (setOne == [[_bottomBgView subviews] count]-1) {
                                    answer = @"1";
                                }else{
                                    answer = @"2";
                                }
                                setOne ++;
                                if (self.delegate && [self.delegate respondsToSelector:@selector(tianQuestionViewDelegateWithAnswer:andTrueOrFalse:andTag:)]) {
                                    [self.delegate tianQuestionViewDelegateWithAnswer:str andTrueOrFalse:answer andTag:(int)zjView.tag];
                                }
                                break;
                            }else{
                                [[SoundTools sharedSoundTools] playSoundWithName:@"ui_no"];
                                zjView.flagBtn.backgroundColor = [UIColor clearColor];
                                [zjView.flagBtn setTitle:@"" forState:UIControlStateNormal];
                                [zjView.flagBtn setImage:[UIImage imageNamed:@"cross"] forState:UIControlStateNormal];
                                zjView.textView.textColor = PView_RedColor;
                                if (self.delegate && [self.delegate respondsToSelector:@selector(tianQuestionViewDelegateWithAnswer:andTrueOrFalse:andTag:)]) {
                                    [self.delegate tianQuestionViewDelegateWithAnswer:str andTrueOrFalse:@"2" andTag:(int)zjView.tag];
                                }
                            }
                        }
                    }
                    else
                    {
                        NSLog(@"no");
                        if ([str isEqualToString:strUrl]) {
                            PLog(@"=======true");
                            [[SoundTools sharedSoundTools] playSoundWithName:@"ui_yes"];
                            zjView.flagBtn.backgroundColor = [UIColor clearColor];
                            [zjView.flagBtn setTitle:@"" forState:UIControlStateNormal];
                            [zjView.flagBtn setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
                            zjView.textView.textColor = PView_GreenColor;
                            if (setOne == [[_bottomBgView subviews] count]-1) {
                                answer = @"1";
                            }else{
                                answer = @"2";
                            }
                            setOne ++;
                            if (self.delegate && [self.delegate respondsToSelector:@selector(tianQuestionViewDelegateWithAnswer:andTrueOrFalse:andTag:)]) {
                                [self.delegate tianQuestionViewDelegateWithAnswer:str andTrueOrFalse:answer andTag:(int)zjView.tag];
                            }
                        }else{
                            PLog(@"=======flase");
                            [[SoundTools sharedSoundTools] playSoundWithName:@"ui_no"];
                            zjView.flagBtn.backgroundColor = [UIColor clearColor];
                            [zjView.flagBtn setTitle:@"" forState:UIControlStateNormal];
                            [zjView.flagBtn setImage:[UIImage imageNamed:@"cross"] forState:UIControlStateNormal];
                            zjView.textView.textColor = PView_RedColor;
                            if (self.delegate && [self.delegate respondsToSelector:@selector(tianQuestionViewDelegateWithAnswer:andTrueOrFalse:andTag:)]) {
                                [self.delegate tianQuestionViewDelegateWithAnswer:str andTrueOrFalse:@"2" andTag:(int)zjView.tag];
                            }
                        }
                    }
                }
            }
            
        }else{
            CGFloat textH = [BaseAPIManager base_getHeightByContent:zjView.textView.text andFontSize:15 andFixedWidth:self.width - 80]+5;
            if (textH < 25) {
                textH = 25;
            }
            zjView.frame = CGRectMake(0, 10+ help, self.width, textH + 25);
            zjView.textView.frame = CGRectMake(30, 25, zjView.width - 60, textH);
            zjView.lineView.frame = CGRectMake(30, zjView.height -0.5, zjView.width - 40, 0.5);
            zjView.placeLabel.frame = CGRectMake(10, zjView.height - 20, 20, 20);
            zjView.flagBtn.frame = CGRectMake(zjView.width - 35, zjView.height - 30, 30, 30);
            zjView.backgroundColor = [UIColor clearColor];
            help += (textH + 35);
        }
        
    }
    
    _bottomBgView.frame = CGRectMake(0, _topBgView.bottom + 40, self.width, help + 40);
    _scrollView.contentSize= CGSizeMake(0, _bottomBgView.bottom+50);
}

#pragma mark ---ErrorParsingViewDelegate---
- (void)errorParsingViewDelegateWithMasterButton:(UIButton *)btn
{
    
}

- (void)errorParsingViewDelegateWithPlayButton:(UIButton *)btn
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tianQuestionViewDelegateWithPlayVideo:)]) {
        [self.delegate tianQuestionViewDelegateWithPlayVideo:_voideUrl];
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
