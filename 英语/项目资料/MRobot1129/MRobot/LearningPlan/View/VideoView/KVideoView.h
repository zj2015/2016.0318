//
//  KVideoView.h
//  MRobot
//
//  Created by BaiYu on 15/8/26.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PassBtnTagDelegate <NSObject>

-(void)passKVideoTag:(NSInteger)btnTag;
-(void)passSmallVideoTag:(NSInteger)btnTag;

@end

@interface KVideoView : UIView

@property (weak, nonatomic) id<PassBtnTagDelegate>delegate;

/**
 *  创建知识点视频
 *
 *  @param frame           一列视频frame
 *  @param listIndex       列表Index
 *  @param smallVideoCount 小视频数量
 *
 *  @return 一列View
 */
-(id)initWithFrame:(CGRect)frame listIndex:(NSInteger)listIndex smallVideoCount:(NSInteger)smallVideoCount coverImgStr:(NSString *)coverImgStr;
@end
