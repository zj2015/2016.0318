//
//  BaseEntity.m
//  ZLYDoc
//
//  Created by Ryan on 14-4-3.
//  Copyright (c) 2014年 ZLY. All rights reserved.
//

#import "BaseEntity.h"

static NSString * const MSG = @"msg";
static NSString * const STATUS = @"status";
static NSString * const RES = @"res";

@implementation BaseEntity

-(void)initWithJson:(NSDictionary *)resultDic
{
    
}

+(BaseEntity* )parseResponseErrorJSON:(id)json
{
    NSString *responseJSON = [NSString stringWithFormat:@"%@",json];
    PLog(@"%@",responseJSON);
    NSData *jsonData = [responseJSON dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
    if ([NSJSONSerialization isValidJSONObject:dic_json]) {
        BaseEntity *baseEntity = [[BaseEntity alloc] init];
        baseEntity.status = [((NSNumber *)[dic_json objectForKey:STATUS]) intValue];
        baseEntity.msg = [dic_json objectForKey:MSG];
        return baseEntity;
    }
    return nil;
}

+ (BaseEntity *)parseResponseStatusJSON:(id)json
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:nil];
    //格式化打印输出至控制台
    NSString *responseJSON = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    PLog(@"%@",responseJSON);
    NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
    if ([NSJSONSerialization isValidJSONObject:dic_json]) {
        NSNumber *status = (NSNumber *)[dic_json objectForKey:STATUS];
        BaseEntity *baseEntity = [[BaseEntity alloc] init];
        baseEntity.status = [status intValue];
        baseEntity.msg = [dic_json objectForKey:MSG];
        return baseEntity;
    }
    return nil;
}

+(BaseEntity *)parseResponseUpdateJSON:(id)json
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:nil];
    //格式化打印输出至控制台
    NSString *responseJSON = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    PLog(@"%@",responseJSON);
    NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
    if ([NSJSONSerialization isValidJSONObject:dic_json]) {
        NSNumber *status = (NSNumber *)[dic_json objectForKey:STATUS];
        BaseEntity *baseEntity = [[BaseEntity alloc] init];
        baseEntity.status = [status intValue];
        id res = [dic_json objectForKey:RES];
        baseEntity.version = [res objectForKey:@"v"];
        baseEntity.updateURL = [res objectForKey:@"url"];
        return baseEntity;
    }
    return nil;
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}

+ (instancetype)modelObjectWithDictionary:(NSDictionary*)dict
{
    BaseEntity *instance = [[BaseEntity alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.code = [self objectOrNilForKey:@"code" fromDictionary:dict];
        self.desc = [self objectOrNilForKey:@"desc" fromDictionary:dict];
        self.extraObject = [self objectOrNilForKey:@"data" fromDictionary:dict];
    }
    
    return self;
}

@end
