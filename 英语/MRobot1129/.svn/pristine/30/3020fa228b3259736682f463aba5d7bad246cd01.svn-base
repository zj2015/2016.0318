//
//  YueduQuestionView.h
//  ERobot
//
//  Created by mac on 15/7/6.
//  Copyright (c) 2015年 BaiYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReadingComModel.h"
#import "QuestionListModel.h"
#import "QuestionView.h"
#import "TianQuestionView.h"
#import "DrawerView.h"
@protocol YueduQuestionViewDelegate <NSObject>

- (void)yueduQuestionViewDelegateWithBigImage:(UIView *)tapView;//阅读标题图片放大

- (void)yueduQuestionViewDelegateWithDanAnswer:(NSString *)answer andTrueOrFalse:(NSString *)judge;//阅读单选

- (void)yueduQuestionViewDelegateWithTianAnswer:(NSString *)answer andTrueOrFalse:(NSString *)judge andTag:(int)tag;//阅读填空

- (void)yueduQuestionViewDelegateWithPlayVideo:(NSString *)btn;//播放视频

@end

@interface YueduQuestionView : UIView<QuestionViewDelegate,TianQuestionViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) UIView *topBgView;

@property (strong, nonatomic) UILabel *qTitleLabel;

@property (strong, nonatomic) UIImageView *qTitleImageView;

@property (strong, nonatomic) NSString *whichMV;

@property (weak, nonatomic) id<YueduQuestionViewDelegate>delegate;

- (void)addYueDuData:(ReadingComModel *)data withPage: (NSDictionary *)page;

@end
