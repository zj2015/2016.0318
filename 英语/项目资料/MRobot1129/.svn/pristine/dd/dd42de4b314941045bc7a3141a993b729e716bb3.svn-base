//
//  ErrorTianQuestionView.h
//  ERobot
//
//  Created by mac on 15/7/13.
//  Copyright (c) 2015年 BaiYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionListModel.h"
#import "FillBlanksModel.h"
#import "ZJTextView.h"
#import "ErrorParsingView.h"

@protocol ErrorTianQuestionViewDelegate <NSObject>

//放大图片
- (void)tianQuestionViewDelegateWithBigImage:(UIView *)tapView;

//按钮已经掌握
- (void)tianQuestionViewDelegateWithUnderStandard:(NSString *)qId andButton:(UIButton *)btn;

@end

@interface ErrorTianQuestionView : UIView<UITextViewDelegate,ZJTextViewDelegate,ErrorParsingViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) UILabel *contentLabel;

@property (strong, nonatomic) UIImageView *contentImageView;

@property (strong, nonatomic) UIView *topBgView;

@property (strong, nonatomic) UILabel *answerLabel;

@property (strong, nonatomic) UIView *bottomBgView;

@property (strong, nonatomic) NSString *witchVC;

@property (strong, nonatomic) ZJTextView *answerView;

@property (strong, nonatomic) ErrorParsingView *parsingView;

@property (strong, nonatomic) NSString *qID;

@property (weak, nonatomic) id<ErrorTianQuestionViewDelegate>delegate;

- (void)addTianKongData:(QuestionListModel *)data;

@end
