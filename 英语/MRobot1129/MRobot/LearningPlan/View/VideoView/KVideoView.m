//
//  KVideoView.m
//  MRobot
//
//  Created by BaiYu on 15/8/26.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "KVideoView.h"
#import "ResultArrayListModel.h"

@implementation KVideoView

#define ROWHEIGHT 100

-(id)initWithFrame:(CGRect)frame listIndex:(NSInteger)listIndex smallVideoCount:(NSInteger)smallVideoCount coverImgStr:(NSString *)coverImgStr
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MainScreenSize_W, 0.5)];
        lineLab.backgroundColor = [UIColor clearColor];
        
        [self addSubview:lineLab];
        
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0.5, MainScreenSize_W, ROWHEIGHT*SIZE_TIMES - 0.5)];
//        contentView.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1];
        contentView.backgroundColor = [UIColor colorWithRed:185/255.0 green:179/255.0 blue:125/255.0 alpha:1];
        [self addSubview:contentView];
        
        UIImageView *videoCoverImg = [[UIImageView alloc] initWithFrame: CGRectMake((MainScreenSize_W/2-120*SIZE_TIMES)/2, 14, 120*SIZE_TIMES, 72*SIZE_TIMES)];
        videoCoverImg.userInteractionEnabled = YES;
        [videoCoverImg setImageWithURL:[NSURL URLWithString:[coverImgStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"video"]];
        [contentView addSubview:videoCoverImg];
        
        UIButton *kVideoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        kVideoBtn.frame = CGRectMake((videoCoverImg.size.width - 30*SIZE_TIMES)/2 , (videoCoverImg.size.height - 30*SIZE_TIMES)/2, 30*SIZE_TIMES, 30*SIZE_TIMES);
        kVideoBtn.tag = listIndex;
        [kVideoBtn setBackgroundImage:[UIImage imageNamed:@"PLAY"] forState:UIControlStateNormal];
        [kVideoBtn addTarget:self action:@selector(kVideoClick:) forControlEvents:UIControlEventTouchUpInside];
        [videoCoverImg addSubview:kVideoBtn];
        
//        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(MainScreenSize_W/2 - 0.5, 0.5, 0.5, ROWHEIGHT*SIZE_TIMES - 1)];
//        lineView.backgroundColor = PView_BGColor;
//        [contentView addSubview:lineView];
        
        for (int i=0; i<smallVideoCount; i++) {
            int col = i % 4;
            int row = i / 4;
            
            UIButton *smallVideoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            smallVideoBtn.frame = CGRectMake(40 *SIZE_TIMES *col + 5 + MainScreenSize_W/2, 15 + row * 32 *SIZE_TIMES, 27*SIZE_TIMES, 27*SIZE_TIMES);
            smallVideoBtn.tag = listIndex *10000 + i;
            [smallVideoBtn setBackgroundColor:[UIColor clearColor]];
            smallVideoBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            [smallVideoBtn setBackgroundImage:[UIImage imageNamed:@"videoIcon"] forState:UIControlStateNormal];
            [smallVideoBtn addTarget:self action:@selector(smallVideoClick:) forControlEvents:UIControlEventTouchUpInside];
            [contentView addSubview:smallVideoBtn];
        }
        
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(5+MainScreenSize_W/2, (smallVideoCount/5+1) * 34 *SIZE_TIMES, MainScreenSize_W/2 - 5, 25*SIZE_TIMES)];
        titleLab.text = @"经典例题视频";
        [titleLab setTextColor:[UIColor whiteColor]];
        titleLab.font = [UIFont systemFontOfSize:14];
        [contentView addSubview:titleLab];
    
    }
    return self;
}

-(void)kVideoClick:(UIButton *)btn
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(passKVideoTag:)]) {
        [self.delegate passKVideoTag:btn.tag];
    }
}

-(void)smallVideoClick:(UIButton *)btn
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(passSmallVideoTag:)]) {
        [self.delegate passSmallVideoTag:btn.tag];
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
