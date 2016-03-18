//
//  BaseEntity.h
//  ZLYDoc
//
//  Created by Ryan on 14-4-3.
//  Copyright (c) 2014年 ZLY. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SUCCESS 0

@interface BaseEntity : NSObject

@property (nonatomic,copy) NSString *_id;//ID
@property (nonatomic,assign) int      status;//状态
@property (nonatomic,copy) NSString *msg;//状态信息
@property (nonatomic,copy) NSString *version;//版本号
@property (nonatomic,copy) NSString *updateURL;//升级URL

@property(nonatomic, copy) NSString *code;
@property(nonatomic, copy) NSString *desc;
@property(nonatomic, strong) NSDictionary *extraObject;

+ (instancetype)modelObjectWithDictionary:(NSDictionary*)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;//根据字典初始化model

/**
 *  解析HTTP返回异常JSON
 *
 *  @param json
 *
 *  @return 
 */
+ (BaseEntity *)parseResponseErrorJSON:(id)json;

/**
 *  解析成功或失败状态JSON
 *
 *  @param json
 *
 *  @return 
 */
+ (BaseEntity *)parseResponseStatusJSON:(id)json;

/**
 *  解析版本号及升级URL JSON
 *
 *  @param json
 *
 *  @return 
 */
+ (BaseEntity *)parseResponseUpdateJSON:(id)json;

-(void)initWithJson:(NSDictionary *)resultDic;

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;//根据key从字典里面取值，如果是空自动容错

@end
