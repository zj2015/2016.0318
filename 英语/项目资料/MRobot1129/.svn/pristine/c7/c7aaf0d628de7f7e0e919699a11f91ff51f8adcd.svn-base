//
//  ErrorParsingView.h
//  ERobot
//
//  Created by mac on 15/7/13.
//  Copyright (c) 2015年 BaiYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ErrorParsingViewDelegate <NSObject>

- (void)errorParsingViewDelegateWithMasterButton:(UIButton *)btn;//掌握按钮

- (void)errorParsingViewDelegateWithPlayButton:(UIButton *)btn;//视频按钮

@end

@interface ErrorParsingView : UIView

@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) UIView *bgView;

@property (strong, nonatomic) UILabel *answerLabel;

@property (strong, nonatomic) UIButton *masterBtn;

@property (strong, nonatomic) UIButton *playBtn;

@property (weak, nonatomic) id <ErrorParsingViewDelegate> delegate;

@end
