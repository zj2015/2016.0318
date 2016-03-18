//
//  QuestionAnswer.h
//  ECenter
//
//  Created by mac on 15/6/8.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QuestionAnswerDelegate <NSObject>

- (void)QuestionAnswerDelegateWithTag:(NSUInteger)tag;

@end

@interface QuestionAnswer : UIView

@property (strong, nonatomic) UIScrollView *bgScrollView;
@property (strong, nonatomic) UILabel *trueLabel;
@property (strong, nonatomic) UILabel *falseLabel;
@property (strong, nonatomic) UILabel *noneLabel;
@property (strong, nonatomic) UILabel *normalLabel1;
@property (strong, nonatomic) UILabel *normalLabel1s;
@property (strong, nonatomic) UILabel *normalLabel1d;
@property (strong, nonatomic) UILabel *normalLabel2;
@property (strong, nonatomic) UILabel *normalLabel3;
@property (strong, nonatomic) UILabel *normalLabel4;
@property (strong, nonatomic) UILabel *normalLabel5;
@property (weak, nonatomic) id<QuestionAnswerDelegate>delegate;

- (void)answerWithTrueOrFalse:(int)danxuan and:(int)tiankong and:(int)yuedu and:(int)tingli allArr:(NSArray *)arr;

@end
