//
//  ChooseKindView.h
//  MRobot
//
//  Created by mac on 15/8/21.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ChooseKindViewBlock)(int tag);

@interface ChooseKindView : UIView

{
    ChooseKindViewBlock _block;
}
- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title withImageArr:(NSArray *)imagesArr withTitleArr:(NSArray *)titlesArr withBlock:(ChooseKindViewBlock)block;

@end
