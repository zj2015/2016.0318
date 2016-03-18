//
//  ErrorYueduQuestionView.m
//  ERobot
//
//  Created by mac on 15/7/13.
//  Copyright (c) 2015年 BaiYu. All rights reserved.
//

#import "ErrorYueduQuestionView.h"
#import "DrawerView.h"
@implementation ErrorYueduQuestionView

- (id)initWithFrame:(CGRect)frame
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
        
        if (!_qTitleLabel) {
            _qTitleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
            _qTitleLabel.font = [UIFont systemFontOfSize:15];
            _qTitleLabel.numberOfLines = 0;
            [_topBgView addSubview:_qTitleLabel];
        }
        
        if (!_qTitleImageView) {
            _qTitleImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
            _qTitleImageView.backgroundColor = [UIColor clearColor];
            _qTitleImageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTheYueImageBtn:)];
            [_qTitleImageView addGestureRecognizer:tap];
            [_topBgView addSubview:_qTitleImageView];
        }
        
    }
    return self;
}

- (void)addYueDuData:(ReadingComModel *)data withPage: (NSDictionary *)page
{
    NSScanner * scanner = [NSScanner scannerWithString:data.qTitle];
    NSString * text = nil;
    if([scanner isAtEnd]==NO){
        
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        
        if (([data.qTitle rangeOfString:@"<"].location !=NSNotFound&&[data.qTitle rangeOfString:@"</"].location !=NSNotFound&&[data.qTitle rangeOfString:@">"].location !=NSNotFound) || [data.qTitle rangeOfString:@"&nbsp;"].location !=NSNotFound) {
            NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[data.qTitle dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,NSFontAttributeName:[UIFont systemFontOfSize:15] } documentAttributes:nil error:nil];
            _qTitleLabel.attributedText = attrStr;
        }else{
            _qTitleLabel.text = data.qTitle ;
        }
        
    }
    
//    _qTitleLabel.text = data.qTitle;
    CGFloat qTitleH = [BaseAPIManager base_getHeightByContent:_qTitleLabel.text andFontSize:15 andFixedWidth:self.width - 20];
    _qTitleLabel.frame = CGRectMake(10, 10, self.width - 20, qTitleH + 13);
    
    if ((NSNull *)data.qTitlePicUrl != [NSNull null] && data.qTitlePicUrl.length) {
        [_qTitleImageView setImageWithURL:[NSURL URLWithString:[data.qTitlePicUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"previewImage"]];
        _qTitleImageView.frame = CGRectMake(10, _qTitleLabel.bottom + 10, self.width - 20, 80*SIZE_TIMES);
        _topBgView.frame = CGRectMake(0, 0, self.width , _qTitleImageView.bottom + 10);
    }else{
        _topBgView.frame = CGRectMake(0, 0, self.width , _qTitleLabel.bottom + 10);
    }
    _scrollView.contentSize= CGSizeMake(0, _topBgView.bottom+40);
    if ([[page valueForKey:@"type"] isEqual:@"0"]) {
        if ([data.questionType isEqualToString:@"0"]) {
            _questionView1 = [[ErrorQuestionView alloc]initWithFrame:CGRectMake(0, _topBgView.bottom + 20 , self.width, MainScreenSize_H - 114)];
            _questionView1.only = NO;
            _questionView1.delegate = self;
            if ([self.witchVC isEqualToString:@"我的错题库"]) {
                _questionView1.witchVC = @"我的错题库";
            }
            [_questionView1 addDanxuanData:[page valueForKey:@"title"]];
            _questionView1.backgroundColor = [UIColor clearColor];
            [_scrollView addSubview:_questionView1];
            _scrollView.contentSize= CGSizeMake(0, _questionView1.bottom+20);
        }else{
            _questionView1 = [[ErrorQuestionView alloc]initWithFrame:CGRectMake(0, 0 , self.width, MainScreenSize_H)];
            _questionView1.only = NO;
            _questionView1.delegate = self;
            if ([self.witchVC isEqualToString:@"我的错题库"]) {
                _questionView1.witchVC = @"我的错题库";
            }
            [_questionView1 addDanxuanData:[page valueForKey:@"title"]];
            _questionView1.backgroundColor = [UIColor clearColor];
            DrawerView *testView = [[DrawerView alloc]initWithView:_questionView1 parentView:_scrollView withBlock:^(CGFloat drawerY) {
                _scrollView.contentSize= CGSizeMake(0, _topBgView.bottom+20+MainScreenSize_H - drawerY);
                _questionView1.scrollView.contentSize = CGSizeMake(0, _questionView1.parsingView.bottom+20 + drawerY );
            }];
            
            [self addSubview:testView];
        }
    }else if ([[page valueForKey:@"type"] isEqual:@"1"]){
        if ([data.questionType isEqualToString:@"0"]) {
            _questionView2 = [[ErrorTianQuestionView alloc]initWithFrame:CGRectMake(0, _topBgView.bottom + 20 , self.width, MainScreenSize_H - 114)];
            if ([self.witchVC isEqualToString:@"我的错题库"]) {
                _questionView2.witchVC = @"我的错题库";
            }
            [_questionView2 addTianKongData:[page valueForKey:@"title"]];
            _questionView2.delegate = self;
            [_scrollView addSubview:_questionView2];
            _scrollView.contentSize= CGSizeMake(0, _questionView2.bottom+20);
        }else{
            _questionView2 = [[ErrorTianQuestionView alloc]initWithFrame:CGRectMake(0, 0 , MainScreenSize_W - 20, MainScreenSize_H)];
            if ([self.witchVC isEqualToString:@"我的错题库"]) {
                _questionView2.witchVC = @"我的错题库";
            }
            [_questionView2 addTianKongData:[page valueForKey:@"title"]];
            _questionView2.delegate = self;
            DrawerView *testView = [[DrawerView alloc]initWithView:_questionView2 parentView:_scrollView withBlock:^(CGFloat drawerY) {
                _scrollView.contentSize= CGSizeMake(0, _topBgView.bottom+20+MainScreenSize_H - drawerY);
                _questionView2.scrollView.contentSize = CGSizeMake(0, _questionView2.parsingView.bottom+20 + drawerY );
            }];
            [self addSubview:testView];
        }
    }
    
}

- (void)clickTheYueImageBtn:(UITapGestureRecognizer *)tap
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(yueduQuestionViewDelegateWithBigImage:)]) {
        [self.delegate yueduQuestionViewDelegateWithBigImage:tap.view];
    }
}

#pragma mark ---ErrorQuestionViewDelegate---

- (void)errorQuestionViewDelegateWithBigImage:(UIView *)tapView
{
    PLog(@"点击放大图片===阅读单选");
    if (self.delegate && [self.delegate respondsToSelector:@selector(yueduQuestionViewDelegateWithBigImage:)]) {
        [self.delegate yueduQuestionViewDelegateWithBigImage:tapView];
    }
}

- (void)errorQuestionViewDelegateWithUnderStand:(NSString *)qId andButton:(UIButton *)btn
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(yueduQuestionViewDelegateWithUnderStanderd:andButton:)]) {
        [self.delegate yueduQuestionViewDelegateWithUnderStanderd:qId andButton:btn];
    }
}

#pragma mark  ----TianQuestionViewDelegate----

- (void)tianQuestionViewDelegateWithBigImage:(UIView *)tapView
{
    PLog(@"点击放大图片===阅读填空");
    if (self.delegate && [self.delegate respondsToSelector:@selector(yueduQuestionViewDelegateWithBigImage:)]) {
        [self.delegate yueduQuestionViewDelegateWithBigImage:tapView];
    }
}

- (void)tianQuestionViewDelegateWithUnderStandard:(NSString *)qId andButton:(UIButton *)btn
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(yueduQuestionViewDelegateWithUnderStanderd:andButton:)]) {
        [self.delegate yueduQuestionViewDelegateWithUnderStanderd:qId andButton:btn];
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
