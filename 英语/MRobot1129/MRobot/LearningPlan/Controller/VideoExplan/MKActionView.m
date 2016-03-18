//
//  MKActionView.m
//  MRobot
//
//  Created by mac on 15/9/20.
//  Copyright © 2015年 silysolong. All rights reserved.
//

#import "MKActionView.h"

@implementation MKActionView

- (instancetype)init
{
    self = [super initWithFrame:CGRectMake(0, 0, MainScreenSize_H, MainScreenSize_W)];
//    self = [super initWithFrame:CGRectMake(0, 0, MainScreenSize_W, MainScreenSize_H)];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:.3]];
        
    }
    return self;
}

- (instancetype)initWithTitleWithArr:(NSArray *)array WithBlock:(MKActionViewBlock)end
{
    self = [self init];
    if (self)
    {
        UITapGestureRecognizer * TapGesturRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureRecognizer:)];
        [self addGestureRecognizer:TapGesturRecognizer];
        
        _block = end;
        
        _backView=[[UIView alloc]init];
        _backView = [MKActionView showAnimationAlert:_backView];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.masksToBounds = YES;
        _backView.layer.cornerRadius = 5;
//        _backView.frame = CGRectMake(100 , MainScreenSize_H/2 - 180/2, MainScreenSize_W - 200 , 180);
        _backView.frame = CGRectMake(80 *SIZE_TIMES , 70*SIZE_TIMES,  MainScreenSize_H - 160*SIZE_TIMES, MainScreenSize_W - 140*SIZE_TIMES);
        [self addSubview:_backView];
        
        int totalColumns = 4;
        CGFloat answerW = _backView.width/4;
        CGFloat answerH = _backView.height/2;
        NSArray *imageArr = [[NSArray alloc]initWithObjects:@"UMS_wechat_icon",@"UMS_wechat_timeline_icon",@"UMS_sina_icon",@"UMS_qq_icon",@"UMS_qzone_icon",@"UMS_tencent_icon",@"UMS_sms_icon",@"UMS_email_icon", nil];
        NSArray *labelArr = [[NSArray alloc]initWithObjects:@"微信",@"朋友圈",@"新浪微博",@"QQ好友",@"QQ空间",@"腾讯微博",@"短信",@"邮件", nil];
        for (int i = 0; i < array.count; i ++) {
            int row=i/totalColumns;
            int col=i%totalColumns;
            CGFloat answerX = col * answerW;
            CGFloat answerY = row * answerH;
            
           
            
            UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(answerX + answerW/2 - 15, answerY + 25, 30, 30)];
            image.image = [UIImage imageNamed:imageArr[i]];
            image.userInteractionEnabled = YES;
            [_backView addSubview:image];
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(answerX, image.bottom + 10, answerW, 15)];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:12];
            label.text = labelArr[i];
            label.userInteractionEnabled = YES;
            [_backView addSubview:label];
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.tag = i;
            btn.frame = CGRectMake(answerX, answerY, answerW, answerH);
            [btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
            [_backView addSubview:btn];
            
        }
        
    }
    return self;
}

- (void)clickButton:(UIButton *)btn
{
    _block((int)btn.tag);
    PLog(@"%ld",btn.tag);
}

- (void)tapGestureRecognizer:(UITapGestureRecognizer *)tap
{
    [self removeFromSuperview];
}

// alertView的弹性效果
+(UIView *) showAnimationAlert:(UIView *)view
{
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.0f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [view.layer addAnimation:popAnimation forKey:nil];
    return view;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
