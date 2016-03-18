//
//  BaseAPIManager.m
//  WangLaiProject
//
//  Created by dupeng on 14-10-8.
//  Copyright (c) 2014年 dupeng. All rights reserved.
//

#import "BaseAPIManager.h"

@implementation BaseAPIManager

// 根据固定 宽度 和文字大小 动态获得内容的高度
+(float)base_getHeightByContent:(NSString *)content andFontSize:(float)fontSize andFixedWidth:(float)width{
    
    UIFont * font = [UIFont systemFontOfSize:fontSize];
    CGSize contentSize = [content boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                               options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading   // 文本绘制时的附加选项
                                            attributes:@{NSFontAttributeName:font}  // 绘制
                                               context:nil].size;
    
    return contentSize.height;
}

// 根据固定 高度 和文字大小 动态获得内容的宽度
+(float)base_getWidthByContent:(NSString *)content andFontSize:(float)fontSize andFixedHeight:(float)height{
    
    UIFont * font = [UIFont systemFontOfSize:fontSize];
    CGSize contentSize = [content boundingRectWithSize:CGSizeMake(MAXFLOAT,height)
                                               options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading   // 文本绘制时的附加选项
                                            attributes:@{NSFontAttributeName:font}  // 绘制
                                               context:nil].size;
    
    return contentSize.width;
}

+(UIImage *)base_imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth{
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat square = 0;
    CGRect myImageRect;
    if (width > height) {
        square = height;
        myImageRect = CGRectMake((width - height)/2, 0.0, square, square);
    }else{
        square = width;
        myImageRect = CGRectMake(0.0, (height - width)/2, square, square);
    }
    CGImageRef imageRef = sourceImage.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, myImageRect);
    CGSize size;
    size.width = square;
    size.height = square;
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, myImageRect, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    return smallImage;
}

+(UIImage *)base_imageCompressForUIImage:(UIImage *)OriImage targetWidth:(CGFloat)defineWidth{
    UIImage *newImage = nil;
    CGSize imageSize = OriImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(size);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [OriImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        PLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    return newImage;
}

// 判断输入的TEXT是否为连续空格
+(BOOL)base_containsOnlyWhitespaces:(NSString *)text{
    
    NSString *resultString = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if(resultString.length == 0){
        return YES;
    }
    return NO;
}


@end
