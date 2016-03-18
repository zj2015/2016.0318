
//
//  MKTextView.m
//  MRobot
//
//  Created by mac on 15/9/6.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "MKTextView.h"

@implementation MKTextView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addObserver];
    }
    return self;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self addObserver];
    }
    return self;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    self.text = placeholder;
    self.textColor = [UIColor grayColor];
}

- (void)addObserver
{
    //注册通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didBeginEditing:) name:UITextViewTextDidBeginEditingNotification object:self];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didEndEditing:) name:UITextViewTextDidEndEditingNotification object:self];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(terminate:) name:UIApplicationWillTerminateNotification object:[UIApplication sharedApplication]];
}

- (void)terminate:(NSNotification *)notification
{
    //移除通知
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)didBeginEditing:(NSNotification *)notification
{
    if ([self.text isEqualToString:self.placeholder]) {
        self.text = @"";
        self.textColor = [UIColor blackColor];
    }
}

- (void)didEndEditing:(NSNotification *)notification
{
    if (self.text.length < 1) {
        self.text = self.placeholder;
        self.textColor = [UIColor grayColor];
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
