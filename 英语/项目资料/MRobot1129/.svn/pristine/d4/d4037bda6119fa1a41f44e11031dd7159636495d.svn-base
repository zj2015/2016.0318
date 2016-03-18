//
//  QuestionView.h
//  ERobot
//
//  Created by mac on 15/7/2.
//  Copyright (c) 2015年 BaiYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionListModel.h"
#import "TheRadioView.h"
#import "ErrorParsingView.h"
@protocol QuestionViewDelegate <NSObject>
//放大图片
- (void)questionViewDelegateWithBigImage:(UIView *)tapView;
//单选答案
- (void)questionViewDelegateWithAnswer:(NSString *)answer andTrueOrFalse:(NSString *)judge;
//播放视频
- (void)questionViewDelegateWithPlayVideo:(NSString *)btn;

@end
@interface QuestionView : UIView<UIScrollViewDelegate,TheRadioViewDelegate,ErrorParsingViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) QuestionListModel *questionModel;
@property (strong, nonatomic) UIView *bgView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIImageView *titleImageView;
@property (strong, nonatomic) UIImageView *lineView;
@property (strong, nonatomic) TheRadioView *isAnswer;
@property (strong, nonatomic) NSString *whichMV;
@property (assign, nonatomic) BOOL only;

@property (strong, nonatomic) NSString *voideUrl;

@property (strong, nonatomic) ErrorParsingView *parsingView;

@property (weak, nonatomic) id<QuestionViewDelegate>delegate;

- (void)addDanxuanData:(QuestionListModel *)data;

@end
