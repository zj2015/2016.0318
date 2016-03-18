//
//  BaseAPIManager.h
//  WangLaiProject
//
//  Created by dupeng on 14-10-8.
//  Copyright (c) 2014年 dupeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseAPIManager : NSObject

// 根据固定 宽度 和文字大小 动态获得内容的高度
+(float)base_getHeightByContent:(NSString *)content andFontSize:(float)fontSize andFixedWidth:(float)width;
// 根据固定 高度 和文字大小 动态获得内容的宽度
+(float)base_getWidthByContent:(NSString *)content andFontSize:(float)fontSize andFixedHeight:(float)height;
// 裁剪图片
+(UIImage *)base_imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;

//等比例截取图片
+(UIImage *)base_imageCompressForUIImage:(UIImage *)OriImage targetWidth:(CGFloat)defineWidth;

// 判断输入的TEXT是否为连续空格
+(BOOL)base_containsOnlyWhitespaces:(NSString *)text;

@end
