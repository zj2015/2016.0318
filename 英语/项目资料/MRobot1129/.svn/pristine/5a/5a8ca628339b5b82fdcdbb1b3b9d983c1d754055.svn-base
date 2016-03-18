//
//  SkillTrainView.h
//  MRobot
//
//  Created by BaiYu on 15/9/16.
//  Copyright © 2015年 silysolong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVideoView.h"

@protocol SkillTrainPassTagDelegate <NSObject>

-(void)skillVideoTag:(NSInteger)btnTag;
-(void)skillTrainTag:(NSInteger)btnTag;
-(void)otherSkillTrainTag:(NSInteger)btnTag;

@end

@interface SkillTrainView : UIView

@property (weak, nonatomic) id<SkillTrainPassTagDelegate>delegate;

-(id)initWithFrame:(CGRect)frame sectionIndex:(NSInteger)sectionIndex coverImgStr:(NSString *)coverImgStr;
@end
