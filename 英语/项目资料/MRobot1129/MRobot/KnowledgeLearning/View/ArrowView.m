//
//  ArrowView.m
//  ArrowView
//
//  Created by hzz on 15/11/19.
//  Copyright © 2015年 rongye. All rights reserved.
//

#import "ArrowView.h"

@implementation ArrowView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor  = RgbColor(174, 159, 110);
    }
    return self;
}
- (void)drawRect:(CGRect)rect{
    
    CGPoint leftPoint = CGPointMake(0, 0);
    CGPoint middlePoint1 = CGPointMake(rect.size.width/2.0 - 6, 0);
    CGPoint middlePoint2 = CGPointMake(rect.size.width/2.0, rect
                                       .size.height - 2);
    CGPoint middlePoint3 = CGPointMake(rect.size.width/2.0 + 6, 0);
    CGPoint rightPoint = CGPointMake(rect.size.width, 0);
    
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextBeginPath(currentContext);//标记
    CGContextMoveToPoint(currentContext,leftPoint.x, leftPoint.y);//设置起点
    CGContextAddLineToPoint(currentContext,middlePoint1.x, middlePoint1.y);
    CGContextAddLineToPoint(currentContext,middlePoint2.x, middlePoint2.y);
    CGContextAddLineToPoint(currentContext,middlePoint3.x, middlePoint3.y);
    CGContextAddLineToPoint(currentContext,rightPoint.x, rightPoint.y);
    CGContextSetLineWidth(currentContext, 1.0);
    CGContextSetShadowWithColor(currentContext, CGSizeMake(0, 0.5), 0.2, [UIColor grayColor].CGColor);
//    CGContextSetShadow(currentContext, CGSizeMake(0, 1.0), 0.5);
    [self.backgroundColor setFill];
    [[UIColor grayColor] setStroke];
    CGContextDrawPath(currentContext,kCGPathFillStroke);//绘制路径path
    
}


@end
