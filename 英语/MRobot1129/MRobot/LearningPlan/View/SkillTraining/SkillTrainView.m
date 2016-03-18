//
//  SkillTrainView.m
//  MRobot
//
//  Created by BaiYu on 15/9/16.
//  Copyright © 2015年 silysolong. All rights reserved.
//

#import "SkillTrainView.h"

@implementation SkillTrainView

-(id)initWithFrame:(CGRect)frame sectionIndex:(NSInteger)sectionIndex coverImgStr:(NSString *)coverImgStr
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 5, MainScreenSize_W, 240*SIZE_TIMES)];
        bgView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:bgView];
        
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0.5, 0.5, MainScreenSize_W - 11, 34*SIZE_TIMES)];
//        titleLab.backgroundColor = [UIColor whiteColor];
        titleLab.backgroundColor = [UIColor colorWithRed:196/255.0 green:185/255.0 blue:142/255.0 alpha:1];

        titleLab.font = [UIFont systemFontOfSize:14];
        titleLab.text = @"   重点解题技巧试题";
        [bgView addSubview:titleLab];
        
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 1 + 34*SIZE_TIMES, MainScreenSize_W, 205*SIZE_TIMES - 0.5)];
        contentView.backgroundColor = [UIColor colorWithRed:184/255.0 green:159/255.0 blue:123/255.0 alpha:1];
        [bgView addSubview:contentView];
        
        SVideoView *sVideoView = [[SVideoView alloc] initWithFrame:CGRectMake(0, 0, MainScreenSize_W - 11, 120*SIZE_TIMES) listIndex:sectionIndex coverImgStr:coverImgStr videoName:@"重点解题技巧试题" trainBtnTitle:@"技巧训练"];
        [contentView addSubview:sVideoView];
        [sVideoView.skillVideoBtn addTarget:self action:@selector(skillVideoClick:) forControlEvents:UIControlEventTouchUpInside];
        [sVideoView.skillTrainBtn addTarget:self action:@selector(skillTrainClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *otherLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 120*SIZE_TIMES, MainScreenSize_W - 11, 34*SIZE_TIMES)];
        otherLab.backgroundColor = [UIColor colorWithRed:196/255.0 green:185/255.0 blue:142/255.0 alpha:1];
        otherLab.font = [UIFont systemFontOfSize:14];
        otherLab.text = @"   其它测试题";
        [contentView addSubview:otherLab];
        
        UIButton *otherSkillBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        otherSkillBtn.frame = CGRectMake(10, 154*SIZE_TIMES + 10, MainScreenSize_W - 31, 30*SIZE_TIMES);
        otherSkillBtn.tag = sectionIndex;
        otherSkillBtn.clipsToBounds = YES;
        otherSkillBtn.layer.cornerRadius = 3;
        [otherSkillBtn setBackgroundColor:[UIColor colorWithRed:234/255.0 green:103/255.0 blue:43/255.0 alpha:1]];
        [otherSkillBtn setTitle:@"技巧训练" forState:UIControlStateNormal];
        otherSkillBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [otherSkillBtn addTarget:self action:@selector(otherSkillTrainingClick:) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:otherSkillBtn];
    }
    return self;
}

-(void)skillVideoClick:(UIButton *)btn
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(skillVideoTag:)]) {
        [self.delegate skillVideoTag:btn.tag];
    }
}

-(void)skillTrainClick:(UIButton *)btn
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(skillTrainTag:)]) {
        [self.delegate skillTrainTag:btn.tag];
    }
}

-(void)otherSkillTrainingClick:(UIButton *)btn
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(otherSkillTrainTag:)]) {
        [self.delegate otherSkillTrainTag:btn.tag];
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
