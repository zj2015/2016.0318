//
//  ErrorYueduQuestionView.h
//  ERobot
//
//  Created by mac on 15/7/13.
//  Copyright (c) 2015年 BaiYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReadingComModel.h"
#import "QuestionListModel.h"
#import "ErrorQuestionView.h"
#import "ErrorTianQuestionView.h"

@protocol ErrorYueduQuestionViewDelegate <NSObject>

- (void)yueduQuestionViewDelegateWithBigImage:(UIView *)tapView;//阅读标题图片放大

- (void)yueduQuestionViewDelegateWithUnderStanderd:(NSString *)qId andButton:(UIButton *)btn;

@end
@interface ErrorYueduQuestionView : UIView<ErrorQuestionViewDelegate,ErrorTianQuestionViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) UIView *topBgView;

@property (strong, nonatomic) UILabel *qTitleLabel;

@property (strong, nonatomic) UIImageView *qTitleImageView;

@property (strong, nonatomic) NSString *witchVC;

@property (strong, nonatomic) ErrorQuestionView *questionView1;

@property (strong, nonatomic) ErrorTianQuestionView *questionView2;

@property (weak, nonatomic) id<ErrorYueduQuestionViewDelegate>delegate;

- (void)addYueDuData:(ReadingComModel *)data withPage: (NSDictionary *)page;

@end
