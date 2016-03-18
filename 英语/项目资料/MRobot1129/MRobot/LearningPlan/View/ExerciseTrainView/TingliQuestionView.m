//
//  TingliQuestionView.m
//  ERobot
//
//  Created by mac on 15/7/6.
//  Copyright (c) 2015年 BaiYu. All rights reserved.
//

#import "TingliQuestionView.h"

@implementation TingliQuestionView


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
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTheTingImageBtn:)];
            [_qTitleImageView addGestureRecognizer:tap];
            [_topBgView addSubview:_qTitleImageView];
        }
        
        if (!_tingLiButton) {
            _tingLiButton = [[UIImageView alloc]init];
            _tingLiButton.userInteractionEnabled = YES;
            _tingLiButton.layer.cornerRadius = 50/2;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTheTingLiBtn:)];
            [_tingLiButton addGestureRecognizer:tap];
            [_tingLiButton setImage:[UIImage imageNamed:@"btn_listen_normal"]];
            UIImage *image1 = [UIImage imageNamed:@"chat_left_white_sound1.png"];
            UIImage *image2 = [UIImage imageNamed:@"chat_left_white_sound2.png"];
            UIImage *image3 = [UIImage imageNamed:@"chat_left_white_sound3.png"];
            UIImage *image4 = [UIImage imageNamed:@"chat_left_white_sound4.png"];
            NSArray *animationArray = [NSArray arrayWithObjects:image1,image2,image3,image4, nil];
            _tingLiButton.animationImages = animationArray;
            _tingLiButton.animationDuration = 0.6;//设置动画时间
            _tingLiButton.animationRepeatCount = 0;//设置动画次数 0 表示无限
            
            [_topBgView addSubview:_tingLiButton];
        }
        
    }
    return self;
}

- (void)addTingLiData:(ReadingComModel *)data withPage: (NSDictionary *)page withIndex:(int)index
{
   
    NSScanner * scanner = [NSScanner scannerWithString:data.qTitle];
    NSString * text = nil;
    if([scanner isAtEnd]==NO){
        
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        
        if (([data.qTitle rangeOfString:@"<"].location !=NSNotFound&&[data.qTitle rangeOfString:@"</"].location !=NSNotFound&&[data.qTitle rangeOfString:@">"].location !=NSNotFound)  || [data.qTitle rangeOfString:@"&nbsp;"].location !=NSNotFound) {
            NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[data.qTitle dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,NSFontAttributeName:[UIFont systemFontOfSize:15] } documentAttributes:nil error:nil];
            _qTitleLabel.attributedText = attrStr;
        }else{
            _qTitleLabel.text = data.qTitle;
        }
    
    }
//    _qTitleLabel.text = data.qTitle;
    CGFloat qTitleH = [BaseAPIManager base_getHeightByContent:_qTitleLabel.text andFontSize:15 andFixedWidth:self.width - 20];
    _qTitleLabel.frame = CGRectMake(10, 10, self.width - 20, qTitleH + 13);
   
    _tingLiButton.tag = index;
    if ((NSNull *)data.qTitlePicUrl != [NSNull null]&& data.qTitlePicUrl.length) {
        [_qTitleImageView setImageWithURL:[NSURL URLWithString:[data.qTitlePicUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"previewImage"]];
        _qTitleImageView.frame = CGRectMake(10, _qTitleLabel.bottom + 10, self.width - 20, 80*SIZE_TIMES);
        _tingLiButton.frame = CGRectMake(self.width/2 - 25, _qTitleImageView.bottom + 10, 50 , 50);
    }else{
        _tingLiButton.frame = CGRectMake(self.width/2 - 25, _qTitleLabel.bottom + 10, 50 , 50);
    }
    
    _topBgView.frame = CGRectMake(0, 0, self.width , _tingLiButton.bottom + 10);
    _scrollView.contentSize= CGSizeMake(0, _topBgView.bottom+40);
    if ([[page valueForKey:@"type"] isEqual:@"0"]) {
        QuestionView *questionView = [[QuestionView alloc]initWithFrame:CGRectMake(0, 0 , self.width, MainScreenSize_H)];
        questionView.only = NO;
        questionView.delegate = self;
        QuestionListModel *listModel = [page valueForKey:@"title"];
        if ((NSNull *)listModel.answerVideoAnalysis != [NSNull null]) {
            if ([_whichMV isEqualToString:@"Videos"]) {
                questionView.voideUrl = listModel.answerVideoAnalysis;
                questionView.parsingView.hidden = NO;
                questionView.whichMV = @"Videos";
                questionView.scrollView.contentSize= CGSizeMake(0, questionView.parsingView.bottom+20);
            }
        }
        [questionView addDanxuanData:[page valueForKey:@"title"]];
        questionView.backgroundColor = [UIColor clearColor];
        DrawerView *testView = [[DrawerView alloc]initWithView:questionView parentView:_scrollView withBlock:^(CGFloat drawerY) {
            _scrollView.contentSize= CGSizeMake(0, _topBgView.bottom+20+MainScreenSize_H - drawerY);
            questionView.scrollView.contentSize = CGSizeMake(0, questionView.bgView.bottom+20 + drawerY );
        }];
        
        [self addSubview:testView];
        
    }else if ([[page valueForKey:@"type"] isEqual:@"1"]){
        TianQuestionView *questionView = [[TianQuestionView alloc]initWithFrame:CGRectMake(0, 0 , MainScreenSize_W - 20, MainScreenSize_H)];
        QuestionListModel *listModel = [page valueForKey:@"title"];
        if ((NSNull *)listModel.answerVideoAnalysis != [NSNull null]) {
            if ([_whichMV isEqualToString:@"Videos"]) {
                questionView.voideUrl = listModel.answerVideoAnalysis;
                questionView.parsingView.hidden = NO;
                questionView.whichMV = @"Videos";
                questionView.scrollView.contentSize= CGSizeMake(0, questionView.parsingView.bottom+20);
            }
        }
        [questionView addTianKongData:[page valueForKey:@"title"]];
        questionView.delegate = self;
        DrawerView *testView = [[DrawerView alloc]initWithView:questionView parentView:_scrollView withBlock:^(CGFloat drawerY) {
            _scrollView.contentSize= CGSizeMake(0, _topBgView.bottom+20+MainScreenSize_H - drawerY);
            questionView.scrollView.contentSize = CGSizeMake(0, questionView.bottomBgView.bottom+20 + drawerY );
        }];
        
        [self addSubview:testView];
        
    }
}

- (void)clickTheTingLiBtn:(UITapGestureRecognizer *)tap
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tingliQuestionViewDelegateWithButton:)]) {
        [self.delegate tingliQuestionViewDelegateWithButton:tap.view];
    }
}

- (void)clickTheTingImageBtn:(UITapGestureRecognizer *)tap
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tingliQuestionViewDelegateWithBigImage:)]) {
        [self.delegate tingliQuestionViewDelegateWithBigImage:tap.view];
    }
}

#pragma mark ---QuestionViewDelegate---

- (void)questionViewDelegateWithBigImage:(UIView *)tapView
{
    PLog(@"点击放大图片===听力单选");
    if (self.delegate && [self.delegate respondsToSelector:@selector(tingliQuestionViewDelegateWithBigImage:)]) {
        [self.delegate tingliQuestionViewDelegateWithBigImage:tapView];
    }
}

- (void)questionViewDelegateWithAnswer:(NSString *)answer andTrueOrFalse:(NSString *)judge
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tingliQuestionViewDelegateWithDanAnswer:andTrueOrFalse:)]) {
        [self.delegate tingliQuestionViewDelegateWithDanAnswer:answer andTrueOrFalse:judge];
    }
}

- (void)questionViewDelegateWithPlayVideo:(NSString *)btn
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tingliQuestionViewDelegateWithPlayVideo:)]) {
        [self.delegate tingliQuestionViewDelegateWithPlayVideo:btn];
    }
}

#pragma mark  ----TianQuestionViewDelegate----

- (void)tianQuestionViewDelegateWithBigImage:(UIView *)tapView
{
    PLog(@"点击放大图片===听力填空");
    if (self.delegate && [self.delegate respondsToSelector:@selector(tingliQuestionViewDelegateWithBigImage:)]) {
        [self.delegate tingliQuestionViewDelegateWithBigImage:tapView];
    }
}

- (void)tianQuestionViewDelegateWithAnswer:(NSString *)answer andTrueOrFalse:(NSString *)judge andTag:(int)tag
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tingliQuestionViewDelegateWithTianAnswer:andTrueOrFalse:andTag:)]) {
        [self.delegate tingliQuestionViewDelegateWithTianAnswer:answer andTrueOrFalse:judge andTag:tag];
    }
}

- (void)tianQuestionViewDelegateWithPlayVideo:(NSString *)btn
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tingliQuestionViewDelegateWithPlayVideo:)]) {
        [self.delegate tingliQuestionViewDelegateWithPlayVideo:btn];
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
