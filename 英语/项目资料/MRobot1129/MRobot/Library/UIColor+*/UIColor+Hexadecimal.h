//
//  UIColor+Hexadecimal.h
//  BaseDemo
//
//  Created by mac on 15/7/28.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hexadecimal)

/**
 *  [UIColor colorWithHex:0x757575]  使用方法，16进制的颜色转化
 **/

+ (UIColor*) colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;

+ (UIColor*) colorWithHex:(NSInteger)hexValue;

+ (NSString *) hexFromUIColor: (UIColor*) color;

@end
