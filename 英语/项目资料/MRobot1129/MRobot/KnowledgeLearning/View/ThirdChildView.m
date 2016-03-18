//
//  ThirdChildView.m
//  MRobot
//
//  Created by BaiYu on 15/9/22.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "ThirdChildView.h"
#define ROWHEIGHT 85

@implementation ThirdChildView

-(id)initWithFrame:(CGRect)frame clickIndex:(NSInteger)clickIndex
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RgbColor(174, 159, 110);
        
        NSArray *imgArr = @[@"bulbknowledge",@"bookknowledge"];
        NSArray *nameArr = @[@"知识点解析",@"习题练习"];
        for (int i = 0; i < 2; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(((MainScreenSize_W - 100)/2-50*SIZE_TIMES)/2+(MainScreenSize_W - 100)/2*i, 5, 50*SIZE_TIMES, 50*SIZE_TIMES);
            [btn setBackgroundImage:[UIImage imageNamed:imgArr[i]] forState:UIControlStateNormal];
            btn.tag = 10000 * clickIndex + i;
            [btn addTarget:self action:@selector(childKBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake((MainScreenSize_W - 100)/2*i, 10 + 50 *SIZE_TIMES, (MainScreenSize_W - 100)/2, 20)];
            lab.text = nameArr[i];
            lab.textAlignment = NSTextAlignmentCenter;
            lab.textColor = [UIColor whiteColor];
            lab.font = [UIFont systemFontOfSize:15];
            [self addSubview:lab];
        }
        
        UIView *mLineView = [[UIView alloc] initWithFrame:CGRectMake((MainScreenSize_W - 100)/2, 0, 0.5, ROWHEIGHT *SIZE_TIMES)];
        mLineView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:mLineView];
        
        UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, ROWHEIGHT *SIZE_TIMES - 0.5, MainScreenSize_W - 100, 0.5)];
        bottomLineView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:bottomLineView];
    }
    return self;
}

- (void)childKBtnClick:(UIButton *)btn
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(passChildKBtnTag:)]) {
        [self.delegate passChildKBtnTag:btn.tag];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
