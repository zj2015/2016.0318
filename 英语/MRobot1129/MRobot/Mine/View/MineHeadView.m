//
//  MineHeadView.m
//  MRobot
//
//  Created by mac on 15/8/27.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "MineHeadView.h"

@implementation MineHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _headBGImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, MainScreenSize_W, HeadViewCellHeight - 45*SIZE_TIMES)];
//        _headBGImageView.image = [UIImage imageNamed:@"mybg"];
        _headBGImageView.backgroundColor = RgbColor(117, 104, 98);
        _headBGImageView.userInteractionEnabled = NO;
        [self addSubview:_headBGImageView];
        
        CGFloat headImgW = _headBGImageView.height - 20;
        UIImageView *userHeagImg = [[UIImageView alloc]initWithFrame:CGRectMake((_headBGImageView.width - headImgW) / 2.0, (_headBGImageView.height - headImgW ) / 2.0, headImgW, headImgW)];
        userHeagImg.layer.cornerRadius = headImgW/2.0;
        userHeagImg.layer.masksToBounds = YES;
        userHeagImg.image = [UIImage imageNamed:@"mybg"];
        [_headBGImageView addSubview:userHeagImg];
        
//        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _headBGImageView.bottom - 35*SIZE_TIMES, MainScreenSize_W, 20)];
//        _nameLabel.textAlignment = NSTextAlignmentCenter;
//        _nameLabel.textColor = PView_RedColor;
//        _nameLabel.font = [UIFont boldSystemFontOfSize:17];
//        _nameLabel.text = [NSString stringWithFormat:@"%@   %@",[UserDefaultsUtils valueWithKey:USER_CAMPUS],[UserDefaultsUtils valueWithKey:USER_NAME]];
//        [self addSubview:_nameLabel];
        
        _flagView1 = [[FlagView alloc]initWithFrame:CGRectMake(0, _headBGImageView.bottom, self.width/3, 45*SIZE_TIMES)];
        _flagView1.topLabel.text = @"CC币";
        
        NSLog(@"%@",[UserDefaultsUtils valueWithKey:USER_CCAMOUNT]);
        
        _flagView1.bottomLabel.text = [NSString stringWithFormat:@"%@",[UserDefaultsUtils valueWithKey:USER_CCAMOUNT]];
        [self addSubview:_flagView1];
        
        _flagView2 = [[FlagView alloc]initWithFrame:CGRectMake(self.width/3, _headBGImageView.bottom, self.width/3, 45*SIZE_TIMES)];
        _flagView2.topLabel.text = @"会员状态";
        // 0：非会员 1：正常 2：已过期
        if ([[UserDefaultsUtils valueWithKey:USER_VIPSTATUS] isEqualToString:@"1"]) {
            _flagView2.bottomLabel.text = @"正常";
        }else if ([[UserDefaultsUtils valueWithKey:USER_VIPSTATUS] isEqualToString:@"0"]) {
            _flagView2.bottomLabel.text = @"非会员";
        }else if ([[UserDefaultsUtils valueWithKey:USER_VIPSTATUS] isEqualToString:@"2"]) {
            _flagView2.bottomLabel.text = @"已过期";
        }
        [self addSubview:_flagView2];
        
        _flagView3 = [[FlagView alloc]initWithFrame:CGRectMake(self.width/3*2, _headBGImageView.bottom, self.width/3, 45*SIZE_TIMES)];
        _flagView3.topLabel.text = @"会员截止";
        
        PLog(@"%@",[UserDefaultsUtils valueWithKey:USER_VIPENDDATE]);
        
        NSString *date = [UserDefaultsUtils valueWithKey:USER_VIPENDDATE];
        
        if (date.length > 10) {
            date = [NSString stringWithFormat:@"%@",[[UserDefaultsUtils valueWithKey:USER_VIPENDDATE] substringToIndex:10]] ;
        }
        
        date = [date stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
        _flagView3.bottomLabel.text = date;
        [self addSubview:_flagView3];
        
    }
    return self;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
