//
//  KVideoCollectionCell.m
//  ECenter
//
//  Created by mac on 15/10/9.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "KVideoCollectionCell.h"

@implementation KVideoCollectionCell

- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.backgroundColor = [UIColor whiteColor];
        
        _videoImgView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, (MainScreenSize_W-15*4)/2, 75*SIZE_TIMES)];
        _videoImgView.backgroundColor = [UIColor clearColor];
        _videoImgView.image = [UIImage imageNamed:@"video"];
        [self addSubview:_videoImgView];
        
        
        
        _smallVideoView = [[UIImageView alloc]initWithFrame:CGRectMake(15+((MainScreenSize_W-15*4)/2 - 30*SIZE_TIMES)/2, 15+(75*SIZE_TIMES-30*SIZE_TIMES)/2, 30*SIZE_TIMES, 30*SIZE_TIMES)];
        _smallVideoView.image = [UIImage imageNamed:@"PLAY"];
        [self addSubview:_smallVideoView];
        
        
        
        _videoLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, _videoImgView.bottom + 5, (MainScreenSize_W-15*4)/2, 25)];
        _videoLabel.backgroundColor = [UIColor clearColor];
        _videoLabel.textAlignment = NSTextAlignmentCenter;
        _videoLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:_videoLabel];

        
        
    }
    return self;
}

@end
