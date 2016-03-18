//
//  ZJTextView.h
//  ERobot
//
//  Created by mac on 15/7/6.
//  Copyright (c) 2015年 BaiYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZJTextViewDelegate <NSObject>

- (void)zjTextViewDelegateWithBtnTag:(UIButton *)btn;

@end

@interface ZJTextView : UIView

@property (strong, nonatomic) UILabel *answerLabel;

@property (strong, nonatomic) UILabel *trueLabel;

@property (strong, nonatomic) UITextView *textView;

@property (strong, nonatomic) UIButton *flagBtn;//确定提交答案

@property (strong, nonatomic) UIImageView *lineView;

@property (strong, nonatomic) UILabel *placeLabel;

@property (weak, nonatomic) id<ZJTextViewDelegate>delegate;

@end
