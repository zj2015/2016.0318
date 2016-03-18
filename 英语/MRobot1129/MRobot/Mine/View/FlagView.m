//
//  FlagView.m
//  MRobot
//
//  Created by mac on 15/8/27.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "FlagView.h"

@implementation FlagView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RgbColor(174, 159, 110);
        
        _topLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height/2)];
        _topLabel.textColor = [UIColor whiteColor];
        _topLabel.font = [UIFont systemFontOfSize:14];
        _topLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_topLabel];
        
        _bottomLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _topLabel.bottom, self.width, self.height/2)];
        _bottomLabel.textColor = [UIColor whiteColor];
        _bottomLabel.font = [UIFont systemFontOfSize:16];
        _bottomLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_bottomLabel];
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
