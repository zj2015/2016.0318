//
//  TianQuestionView.h
//  ERobot
//
//  Created by mac on 15/7/3.
//  Copyright (c) 2015年 BaiYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionListModel.h"
#import "FillBlanksModel.h"
#import "ZJTextView.h"
#import "ErrorParsingView.h"

@protocol TianQuestionViewDelegate <NSObject>

//放大图片
- (void)tianQuestionViewDelegateWithBigImage:(UIView *)tapView;

//填空答案
- (void)tianQuestionViewDelegateWithAnswer:(NSString *)answer andTrueOrFalse:(NSString *)judge andTag:(int)tag;

//播放视频
- (void)tianQuestionViewDelegateWithPlayVideo:(NSString *)btn;

@end

@interface TianQuestionView : UIView<UITextViewDelegate,ZJTextViewDelegate,ErrorParsingViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) UILabel *contentLabel;

@property (strong, nonatomic) UIImageView *contentImageView;

@property (strong, nonatomic) UIView *topBgView;

@property (strong, nonatomic) UILabel *answerLabel;

@property (strong, nonatomic) UIView *bottomBgView;

@property (strong, nonatomic) ZJTextView *answerView;

@property (strong, nonatomic) NSArray *answerArr;

@property (strong, nonatomic) ErrorParsingView *parsingView;

@property (strong, nonatomic) NSString *voideUrl;

@property (strong, nonatomic) NSString *whichMV;

@property (weak, nonatomic) id<TianQuestionViewDelegate>delegate;

- (void)addTianKongData:(QuestionListModel *)data;

@end
