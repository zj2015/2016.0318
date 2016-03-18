//
//  SubmitTianQuestionView.h
//  ERobot
//
//  Created by mac on 15/7/14.
//  Copyright (c) 2015年 BaiYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionListModel.h"
#import "FillBlanksModel.h"
#import "ZJTextView.h"
#import "ErrorParsingView.h"
@protocol SubmitTianQuestionViewDelegate <NSObject>

//放大图片
- (void)tianQuestionViewDelegateWithBigImage:(UIView *)tapView;

@end

@interface SubmitTianQuestionView : UIView<UITextViewDelegate,ZJTextViewDelegate,ErrorParsingViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) UILabel *contentLabel;

@property (strong, nonatomic) UIImageView *contentImageView;

@property (strong, nonatomic) UIView *topBgView;

@property (strong, nonatomic) UILabel *answerLabel;

@property (strong, nonatomic) UIView *bottomBgView;

@property (strong, nonatomic) ZJTextView *answerView;

@property (strong, nonatomic) ErrorParsingView *parsingView;

@property (strong, nonatomic) UIButton *flagBtn;

@property (copy, nonatomic) NSString *whichMV;

@property (weak, nonatomic) id<SubmitTianQuestionViewDelegate>delegate;

- (void)addTianKongData:(QuestionListModel *)data andAnswer:(NSArray *)arr;

@end
