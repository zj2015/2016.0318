//
//  ExamAnswerView.h
//  MRobot
//
//  Created by mac on 15/10/20.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ExamAnswerViewDelegate <NSObject>

- (void)ExamAnswerViewDelegateWithTag:(NSUInteger)tag;

@end

@interface ExamAnswerView : UIView

@property (strong, nonatomic) UIScrollView *bgScrollView;
@property (strong, nonatomic) UILabel *trueLabel;
@property (strong, nonatomic) UILabel *falseLabel;
@property (strong, nonatomic) UILabel *noneLabel;
@property (strong, nonatomic) UILabel *normalLabel1;
@property (strong, nonatomic) UILabel *normalLabel2;
@property (strong, nonatomic) UILabel *normalLabel3;
@property (strong, nonatomic) UILabel *normalLabel4;
@property (strong, nonatomic) UILabel *normalLabel5;
@property (weak, nonatomic) id<ExamAnswerViewDelegate>delegate;

- (void)answerWithTrueOrFalse:(int)danxuan and:(int)tiankong and:(int)yuedu and:(int)tingli allArr:(NSArray *)arr;

@end
