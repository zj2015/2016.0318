//
//  SimuHearingView.h
//  MRobot
//
//  Created by mac on 15/9/14.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReadingComModel.h"
#import "QuestionListModel.h"
#import "SimuBlanksView.h"
#import "SimuTheRadioView.h"
#import "DrawerView.h"

@protocol SimuHearingViewDelegate <NSObject>

- (void)simuHearingViewDelegateWithButton:(UIView *)tap;//播放听力的语音

- (void)simuHearingViewDelegateWithBigImage:(UIView *)tapView;//听力标题图片放大

- (void)simuHearingViewDelegateWithDanAnswer:(NSString *)answer andTrueOrFalse:(NSString *)judge;//听力单选答案

- (void)simuHearingViewDelegateWithTianAnswer:(NSString *)answer andTrueOrFalse:(NSString *)judge andTag:(int)tag;//听力填空答案

- (void)tingliQuestionViewDelegateWithPlayVideo:(NSString *)btn;

@end

@interface SimuHearingView : UIView<SimuTheRadioViewDelegate,SimuBlanksViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) UIView *topBgView;

@property (strong, nonatomic) UILabel *qTitleLabel;

@property (strong, nonatomic) UIImageView *qTitleImageView;

@property (strong, nonatomic) UIImageView *tingLiButton;

@property (weak, nonatomic) id <SimuHearingViewDelegate>delegate;

- (void)addTingLiData:(ReadingComModel *)data withPage: (NSDictionary *)page withIndex:(int)index;

@end
