//
//  SubmitTingliQuestionView.h
//  ERobot
//
//  Created by mac on 15/7/14.
//  Copyright (c) 2015年 BaiYu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ReadingComModel.h"
#import "SubmitQuestionView.h"
#import "SubmitTianQuestionView.h"

@protocol SubmitTingliQuestionViewDelegate <NSObject>

- (void)tingliQuestionViewDelegateWithButton:(UIView *)tap;//播放听力的语音

- (void)tingliQuestionViewDelegateWithBigImage:(UIView *)tapView;//听力标题图片放大

@end

@interface SubmitTingliQuestionView : UIView<SubmitQuestionViewDelegate,SubmitTianQuestionViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) UIView *topBgView;

@property (strong, nonatomic) UILabel *qTitleLabel;

@property (strong, nonatomic) UIImageView *qTitleImageView;

@property (strong, nonatomic) UIImageView *tingLiButton;

@property (strong, nonatomic) SubmitQuestionView *questionView1;

@property (strong, nonatomic) SubmitTianQuestionView *questionView2;

@property (copy, nonatomic) NSString *whichMV;

@property (weak, nonatomic) id <SubmitTingliQuestionViewDelegate>delegate;

- (void)addTingLiData:(ReadingComModel *)data withPage: (NSDictionary *)page withIndex:(int)index andAnswer:(NSArray *)arr;

@end
