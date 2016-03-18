//
//  RequestCenter.h
//  ELibrary
//
//  Created by zjb on 15/4/21.
//  Copyright (c) 2015年 zjb. All rights reserved.
//

#import <Foundation/Foundation.h>

//下载进度代码块
typedef void(^ProgressBlock)(float percent , NSString *path);

@interface RequestCenter : NSObject<NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSMutableData *dataM;//数据大小
// 保存在沙盒中的文件路径
@property (nonatomic, strong) NSString *cachePath;
// 文件总长度
@property (nonatomic, assign) long long fileLength;
// 当前下载的文件长度
@property (nonatomic, assign) long long currentLength;
// 回调块代码
@property (nonatomic, copy) ProgressBlock progress;

-(void)downloadWithURL:(NSURL *)url progress:(ProgressBlock)progress;

@end
