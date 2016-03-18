//
//  ErrorQuestionView.h
//  ERobot
//
//  Created by mac on 15/7/13.
//  Copyright (c) 2015年 BaiYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionListModel.h"
#import "TheRadioView.h"
#import "ErrorParsingView.h"

@protocol ErrorQuestionViewDelegate <NSObject>
//放大图片
- (void)errorQuestionViewDelegateWithBigImage:(UIView *)tapView;

//按钮已经掌握
- (void)errorQuestionViewDelegateWithUnderStand:(NSString *)qId andButton:(UIButton *)btn;

@end
@interface ErrorQuestionView : UIView<UIScrollViewDelegate,TheRadioViewDelegate,ErrorParsingViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) UIView *bgView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIImageView *titleImageView;
@property (strong, nonatomic) UIImageView *lineView;
@property (strong, nonatomic) TheRadioView *isAnswer;
@property (strong, nonatomic) ErrorParsingView *parsingView;
@property (strong, nonatomic) UIButton *flagBtn;

@property (strong, nonatomic) NSString *qID;

@property (assign, nonatomic) BOOL only;
@property (weak, nonatomic) id<ErrorQuestionViewDelegate>delegate;
- (void)addDanxuanData:(QuestionListModel *)data;

@property (strong, nonatomic) NSString *witchVC;

@end
