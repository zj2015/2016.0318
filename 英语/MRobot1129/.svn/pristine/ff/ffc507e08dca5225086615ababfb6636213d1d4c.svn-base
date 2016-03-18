//
//  ItemView.m
//  Movie
//
//  Created by shangke on 14-9-25.
//  Copyright (c) 2014年 shangke. All rights reserved.
//

#import "ItemView.h"
@implementation ItemView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initSubviews];
        
        [self addGesture];
    }
    return self;
}

- (void)initSubviews
{
    // 小图片
    _item = [[UIImageView alloc] initWithFrame:CGRectMake(self.width/2.0-23/2, 4, 23, 23)];
    _item.contentMode = UIViewContentModeScaleToFill;//合适比例
    _item.userInteractionEnabled = YES;
    [self addSubview:_item];
    
    // 小标题
    _title = [[UILabel alloc] initWithFrame:CGRectMake(0, _item.bottom+5, self.width, 10)];
    _title.backgroundColor = [UIColor clearColor];
    _title.textColor = [UIColor grayColor];
    _title.font = [UIFont boldSystemFontOfSize:11];
    _title.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_title];
}

- (void)addGesture
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didItemView:)];
    [self addGestureRecognizer:tap];

}

#pragma mark - Target Actions
- (void)didItemView:(UITapGestureRecognizer *)tap
{
    if ([self.delegate respondsToSelector:@selector(didItemView:atIndex:)]) {
        
        [self.delegate didItemView:self atIndex:self.tag];
    }
}


@end
