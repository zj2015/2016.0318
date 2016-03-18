//
//  SubmitYueduQuestionView.h
//  ERobot
//
//  Created by mac on 15/7/14.
//  Copyright (c) 2015年 BaiYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReadingComModel.h"
#import "QuestionListModel.h"
#import "SubmitQuestionView.h"
#import "SubmitTianQuestionView.h"

@protocol SubmitYueduQuestionViewDelegate <NSObject>

- (void)yueduQuestionViewDelegateWithBigImage:(UIView *)tapView;//阅读标题图片放大

@end
@interface SubmitYueduQuestionView : UIView<SubmitQuestionViewDelegate,SubmitTianQuestionViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) UIView *topBgView;

@property (strong, nonatomic) UILabel *qTitleLabel;

@property (strong, nonatomic) UIImageView *qTitleImageView;

@property (strong, nonatomic) SubmitQuestionView *questionView1;

@property (strong, nonatomic) SubmitTianQuestionView *questionView2;

@property (copy, nonatomic) NSString *whichMV;

@property (weak, nonatomic) id<SubmitYueduQuestionViewDelegate>delegate;

- (void)addYueDuData:(ReadingComModel *)data withPage: (NSDictionary *)page andAnswer:(NSArray *)arr;
@end
