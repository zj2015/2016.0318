//
//  SimuBlanksView.h
//  MRobot
//
//  Created by mac on 15/9/14.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionListModel.h"
#import "FillBlanksModel.h"
#import "ZJTextView.h"

@protocol SimuBlanksViewDelegate <NSObject>

//放大图片
- (void)simuBlanksViewDelegateWithBigImage:(UIView *)tapView;

//填空答案
- (void)simuBlanksViewDelegateWithAnswer:(NSString *)answer andTrueOrFalse:(NSString *)judge andTag:(int)tag;

//播放视频
- (void)simuBlanksViewDelegateWithPlayVideo:(NSString *)btn;

@end

@interface SimuBlanksView : UIView<UITextViewDelegate,ZJTextViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) UILabel *contentLabel;

@property (strong, nonatomic) UIImageView *contentImageView;

@property (strong, nonatomic) UIView *topBgView;

@property (strong, nonatomic) UILabel *answerLabel;

@property (strong, nonatomic) UIView *bottomBgView;

@property (strong, nonatomic) ZJTextView *answerView;

@property (strong, nonatomic) NSArray *answerArr;

@property (weak, nonatomic) id<SimuBlanksViewDelegate>delegate;

- (void)addTianKongData:(QuestionListModel *)data;

@end
