//
//  FillBlanksModel.h
//  ERobot
//
//  Created by mac on 15/7/2.
//  Copyright (c) 2015年 BaiYu. All rights reserved.
//

#import "BaseEntity.h"

@interface FillBlanksModel : BaseEntity

@property (copy, nonatomic) NSString *optionId;//选项id、填空题答案id

@property (copy, nonatomic) NSString *optionContent;//选项内容、填空题标准答案

@property (copy, nonatomic) NSString *optionPicUrl;//选项图片

@property (copy, nonatomic) NSString *isAnswer;//该选项是否是正确选项   0：否   1：是

@property (copy, nonatomic) NSString *myOption;//填空题用户填写的答案  知识点错题集

@end
