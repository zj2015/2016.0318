//
//  ExamOutHeadView.h
//  MRobot
//
//  Created by mac on 15/9/7.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ExamOutHeight 40*SIZE_TIMES 

typedef void(^ExamOutHeadViewBlock)(NSInteger tag);

@interface ExamOutHeadView : UIView
{
    ExamOutHeadViewBlock _block;
}

@property (strong, nonatomic) UIView * bgView;

@property (strong, nonatomic) UILabel * leftLabel;

@property (strong, nonatomic) UIImageView * rightImageView;

- (instancetype)initWithFrame:(CGRect)frame withBlock:(ExamOutHeadViewBlock)block;

@end
