//
//  WeekHeadView.h
//  MRobot
//
//  Created by mac on 15/8/22.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExamProListModel.h"
#import "WhiteCircle.h"
#import "ProgressView.h"

typedef void(^WeekHeadViewBlock)(int tag); // tag = 1 后退， tag = 2 前进

@interface WeekHeadView : UIView

{
    WeekHeadViewBlock _block;
    NSString *contentStr;
    ProgressView *progress;
}

@property (strong, nonatomic) UILabel *bigTitleLabel;//大标题

@property (strong, nonatomic) UILabel *numLabel;//计算

@property (strong, nonatomic) UIImageView *bgImageView;//进度底色

@property (strong, nonatomic) UIImageView *progressImageView;//进度背景

@property (strong, nonatomic) UIButton *currentBtn;//当前周

@property (strong, nonatomic) UIButton *progressBtn;//总进度

@property (strong, nonatomic) UILabel *smallTitleLabel;//小标题

@property (strong, nonatomic) UILabel *smallSubTitleLabel;//副标题

@property (strong, nonatomic) UIButton *forwardBtn;//前进

@property (strong, nonatomic) UIButton *backBtn;//后退

- (void)headDataWithModel:(ExamProListModel *)examModel withCount:(int)count withPage:(int)page;

- (instancetype)initWithFrame:(CGRect)frame withExamModel:(ExamProListModel*)examModel withCount:(NSInteger)count withBlock:(WeekHeadViewBlock)block;

@end
