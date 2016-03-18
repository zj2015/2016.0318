//
//  ErrorTingliQuestionView.h
//  ERobot
//
//  Created by mac on 15/7/13.
//  Copyright (c) 2015年 BaiYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReadingComModel.h"
#import "ErrorQuestionView.h"
#import "ErrorTianQuestionView.h"

@protocol ErrorTingliQuestionViewDelegate <NSObject>

- (void)tingliQuestionViewDelegateWithButton:(UIView *)tap;//播放听力的语音

- (void)tingliQuestionViewDelegateWithBigImage:(UIView *)tapView;//听力标题图片放大

- (void)tingliQuestionViewDelegateWithUnderStandard:(NSString *)qId andButton:(UIButton *)btn;

@end

@interface ErrorTingliQuestionView : UIView<ErrorQuestionViewDelegate,ErrorTianQuestionViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) UIView *topBgView;

@property (strong, nonatomic) UILabel *qTitleLabel;

@property (strong, nonatomic) UIImageView *qTitleImageView;

@property (strong, nonatomic) UIImageView *tingLiButton;

@property (strong, nonatomic) NSString *witchVC;

@property (strong, nonatomic) ErrorQuestionView *questionView1;

@property (strong, nonatomic) ErrorTianQuestionView *questionView2;

@property (weak, nonatomic) id <ErrorTingliQuestionViewDelegate>delegate;

- (void)addTingLiData:(ReadingComModel *)data withPage: (NSDictionary *)page withIndex:(int)index;

@end
