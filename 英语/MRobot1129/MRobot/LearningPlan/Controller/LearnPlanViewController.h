//
//  LearnPlanViewController.h
//  MRobot
//
//  Created by mac on 15/8/19.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "BaseViewController.h"

@interface LearnPlanViewController : BaseViewController<UIScrollViewDelegate>
{
    int page;
    int isRight;//是否有强化训练
}
@property (strong, nonatomic) UIScrollView *myScrollView;
@property (strong, nonatomic) NSArray * proListArr;//进度列表
@property (copy, nonatomic) NSString *thisWeek;
@end
