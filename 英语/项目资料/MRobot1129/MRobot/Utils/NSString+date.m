//
//  NSString+date.m
//  ECenter
//
//  Created by mac on 15/6/8.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "NSString+date.h"

@implementation NSString (date)

+ (NSString *)makeTimeWithYear:(NSString *)date
{
    NSDate *dates = [[NSDate alloc]initWithTimeIntervalSince1970:[date longLongValue]/1000.0];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    return [dateFormatter stringFromDate:dates];
}

+ (NSString *)makeTimeStrWithDate:(NSString *)date
{
    NSDate *dates = [[NSDate alloc]initWithTimeIntervalSince1970:[date longLongValue]/1000.0];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return [dateFormatter stringFromDate:dates];
}

+ (NSString *)makeBtWithKbOrMb:(NSString *)bite
{
    float kb = [bite floatValue]/1024;
    float mb = kb / 1024;
    float tb = mb / 1024;
    if (tb > 1) {
        return [NSString stringWithFormat:@"%.2fTB",tb];
    }else if (mb > 1){
        return [NSString stringWithFormat:@"%.2fMB",mb];
    }else if (kb > 1){
        return [NSString stringWithFormat:@"%.2fKB",kb];
    }else{
        return [NSString stringWithFormat:@"%.2fB",[bite floatValue]];
    }
}

#pragma mark -计算字符串高度
+(CGSize)getTextHeight:(NSString *)textStr maxWidth:(CGFloat)width
{
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    NSDictionary * attributes = @{NSFontAttributeName :[UIFont systemFontOfSize:15],
                                  NSParagraphStyleAttributeName : paragraphStyle};
    CGSize contentSize = [textStr boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                               options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                            attributes:attributes
                                               context:nil].size;
    return contentSize;
}

#pragma mark ---将数字转化成拼音
+ (NSString *)makeNumWithPinYin:(NSString *)number
{
    
    if ([number isEqualToString:@"0"]) {
        return @"A";
    }else if ([number isEqualToString:@"1"]){
        return @"B";
    }else if ([number isEqualToString:@"2"]){
        return @"C";
    }else if ([number isEqualToString:@"3"]){
        return @"D";
    }else if ([number isEqualToString:@"4"]){
        return @"E";
    }else if ([number isEqualToString:@"5"]){
        return @"F";
    }else if ([number isEqualToString:@"6"]){
        return @"G";
    }else if ([number isEqualToString:@"7"]){
        return @"H";
    }else if ([number isEqualToString:@"8"]){
        return @"I";
    }else if ([number isEqualToString:@"9"]){
        return @"J";
    }else if ([number isEqualToString:@"10"]){
        return @"K";
    }else if ([number isEqualToString:@"11"]){
        return @"L";
    }else if ([number isEqualToString:@"12"]){
        return @"M";
    }else if ([number isEqualToString:@"13"]){
        return @"N";
    }else if ([number isEqualToString:@"14"]){
        return @"O";
    }else if ([number isEqualToString:@"15"]){
        return @"P";
    }else{
        return @"Q";
    }
    
}

+ (NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    NSString * regEx = @"&nbsp;";
    html = [html stringByReplacingOccurrencesOfString:regEx withString:@" "];
    return html;
}

@end
