//
//  SimuReadingView.h
//  MRobot
//
//  Created by mac on 15/9/14.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReadingComModel.h"
#import "QuestionListModel.h"
#import "SimuBlanksView.h"
#import "SimuTheRadioView.h"
#import "DrawerView.h"

@protocol SimuReadingViewDelegate <NSObject>

- (void)simuReadingViewDelegateWithBigImage:(UIView *)tapView;//阅读标题图片放大

- (void)simuReadingViewDelegateWithDanAnswer:(NSString *)answer andTrueOrFalse:(NSString *)judge;//阅读单选

- (void)simuReadingViewDelegateWithTianAnswer:(NSString *)answer andTrueOrFalse:(NSString *)judge andTag:(int)tag;//阅读填空

@end

@interface SimuReadingView : UIView<SimuTheRadioViewDelegate,SimuBlanksViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) UIView *topBgView;

@property (strong, nonatomic) UILabel *qTitleLabel;

@property (strong, nonatomic) UIImageView *qTitleImageView;

@property (strong, nonatomic) NSString *whichMV;

@property (weak, nonatomic) id<SimuReadingViewDelegate>delegate;

- (void)addYueDuData:(ReadingComModel *)data withPage: (NSDictionary *)page;


@end
