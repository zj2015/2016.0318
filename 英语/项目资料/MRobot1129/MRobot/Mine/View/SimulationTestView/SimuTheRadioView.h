//
//  SimuTheRadioView.h
//  MRobot
//
//  Created by mac on 15/9/14.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TheRadioView.h"
#import "QuestionListModel.h"

@protocol SimuTheRadioViewDelegate <NSObject>

//放大图片
- (void)simuTheRadioViewDelegateWithBigImage:(UIView *)tapView;
//单选答案
- (void)simuTheRadioViewDelegateWithAnswer:(NSString *)answer andTrueOrFalse:(NSString *)judge;
//播放视频
- (void)simuTheRadioViewDelegateWithPlayVideo:(NSString *)btn;

@end

@interface SimuTheRadioView : UIView<UIScrollViewDelegate,TheRadioViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) QuestionListModel *questionModel;

@property (strong, nonatomic) UIView *bgView;

@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) UIImageView *titleImageView;

@property (strong, nonatomic) UIImageView *lineView;

@property (strong, nonatomic) TheRadioView *isAnswer;

@property (strong, nonatomic) NSMutableArray *radioArray;

@property (weak, nonatomic) id<SimuTheRadioViewDelegate>delegate;

- (void)addDanxuanData:(QuestionListModel *)data;

@end
