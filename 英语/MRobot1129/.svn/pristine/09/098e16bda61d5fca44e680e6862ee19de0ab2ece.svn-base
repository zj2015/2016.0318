//
//  CustomButton.h
//  MRobot
//
//  Created by mac on 15/8/28.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomButtonDelegate <NSObject>

- (void)chooseDifferentCategoriesWithTag:(NSInteger)tag;

@end

@interface CustomButton : UIView

@property (strong, nonatomic) UILabel * leftLabel;

@property (strong, nonatomic) UIImageView * rightImageView;

@property (weak, nonatomic)id<CustomButtonDelegate>delegate;

@end
