//
//  ThirdChildView.h
//  MRobot
//
//  Created by BaiYu on 15/9/22.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ChildKBtnTagDelegate <NSObject>

-(void)passChildKBtnTag:(NSInteger)btnTag;

@end

@interface ThirdChildView : UIView

@property (weak, nonatomic) id<ChildKBtnTagDelegate>delegate;
-(id)initWithFrame:(CGRect)frame clickIndex:(NSInteger)clickIndex;
@end
