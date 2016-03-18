//
//  SubmitQuestionView.h
//  ERobot
//
//  Created by mac on 15/7/14.
//  Copyright (c) 2015年 BaiYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionListModel.h"
#import "TheRadioView.h"
#import "ErrorParsingView.h"
@protocol SubmitQuestionViewDelegate <NSObject>
//放大图片
- (void)submitQuestionViewDelegateWithBigImage:(UIView *)tapView;

@end
@interface SubmitQuestionView : UIView<UIScrollViewDelegate,TheRadioViewDelegate,ErrorParsingViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) UIView *bgView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIImageView *titleImageView;
@property (strong, nonatomic) UIImageView *lineView;
@property (strong, nonatomic) TheRadioView *isAnswer;
@property (strong, nonatomic) ErrorParsingView *parsingView;
@property (strong, nonatomic) UIButton *flagBtn;
@property (copy, nonatomic) NSString *whichMV;

@property (assign, nonatomic) BOOL only;
@property (weak, nonatomic) id<SubmitQuestionViewDelegate>delegate;
- (void)addDanxuanData:(QuestionListModel *)data andAnswer:(NSArray *)arr;


@end
