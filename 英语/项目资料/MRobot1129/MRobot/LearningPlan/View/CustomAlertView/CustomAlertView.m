//
//  CustomAlertView.m
//  MRobot
//
//  Created by BaiYu on 15/8/28.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "CustomAlertView.h"

@implementation CustomAlertView
@synthesize continueBtn;
@synthesize cancleBtn;

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *tipsLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, 260, 30)];
        tipsLab.text = @"Drill is recommended before video";
        tipsLab.textColor = PView_RedColor;
        tipsLab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:tipsLab];
        
        continueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        continueBtn.frame = CGRectMake(10, 110, 115, 30);
        [continueBtn setTitle:@"Continue" forState:UIControlStateNormal];
        continueBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [continueBtn setBackgroundImage:[UIImage imageNamed:@"btn01"] forState:UIControlStateNormal];
        [self addSubview:continueBtn];
        
        cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancleBtn.frame = CGRectMake(135, 110, 115, 30);
        cancleBtn.tag = 0;
        [cancleBtn setTitle:@"I know" forState:UIControlStateNormal];
        cancleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [cancleBtn setBackgroundImage:[UIImage imageNamed:@"btn02"] forState:UIControlStateNormal];
        [self addSubview:cancleBtn];
    }
    return  self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
