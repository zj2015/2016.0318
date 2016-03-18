//
//  TingliQuestionView.h
//  ERobot
//
//  Created by mac on 15/7/6.
//  Copyright (c) 2015年 BaiYu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ReadingComModel.h"
#import "QuestionView.h"
#import "TianQuestionView.h"
#import "DrawerView.h"
@protocol TingliQuestionViewDelegate <NSObject>

- (void)tingliQuestionViewDelegateWithButton:(UIView *)tap;//播放听力的语音

- (void)tingliQuestionViewDelegateWithBigImage:(UIView *)tapView;//听力标题图片放大

- (void)tingliQuestionViewDelegateWithDanAnswer:(NSString *)answer andTrueOrFalse:(NSString *)judge;//听力单选答案

- (void)tingliQuestionViewDelegateWithTianAnswer:(NSString *)answer andTrueOrFalse:(NSString *)judge andTag:(int)tag;//听力填空答案

- (void)tingliQuestionViewDelegateWithPlayVideo:(NSString *)btn;

@end

@interface TingliQuestionView : UIView<QuestionViewDelegate,TianQuestionViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) UIView *topBgView;

@property (strong, nonatomic) UILabel *qTitleLabel;

@property (strong, nonatomic) UIImageView *qTitleImageView;

@property (strong, nonatomic) UIImageView *tingLiButton;

@property (strong, nonatomic) NSString *whichMV;

@property (weak, nonatomic) id <TingliQuestionViewDelegate>delegate;

- (void)addTingLiData:(ReadingComModel *)data withPage: (NSDictionary *)page withIndex:(int)index;

@end
