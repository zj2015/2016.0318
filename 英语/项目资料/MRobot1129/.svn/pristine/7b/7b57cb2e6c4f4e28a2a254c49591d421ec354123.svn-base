//
//  RequestCenter.m
//  ELibrary
//
//  Created by zjb on 15/4/21.
//  Copyright (c) 2015年 zjb. All rights reserved.
//

#import "RequestCenter.h"

@implementation RequestCenter

#pragma mark+++++++++++++++++++下载 文件++++++++++++++++++++++++++++++++++++
- (NSMutableData *)dataM
{
    if (!_dataM) {
        _dataM = [NSMutableData data];
    }
    return _dataM;
}

- (void)downloadWithURL:(NSURL *)url progress:(ProgressBlock)progress
{
    // 0. 记录块代码
    self.progress = progress;
    
    // 1. request GET
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 2. connection
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    // 让connection支持多线程，指定代理的工作队列即可
    // NSURLConnection在运行时，运行循环不负责监听代理的具体执行
    [connection setDelegateQueue:[[NSOperationQueue alloc] init]];
    
    // 3. 启动连接
    [connection start];
}

#pragma mark - 代理方法
// 1. 接收到服务器的响应，服务器执行完请求，向客户端回传数据
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    PLog(@"%@ %lld", response.suggestedFilename, response.expectedContentLength);
    // 1. 保存的缓存路径
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    self.cachePath = [cachePath stringByAppendingPathComponent:response.suggestedFilename];
    PLog(@"保存的缓存路径:%@", self.cachePath);
    
    //判断是否文件存在
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:self.cachePath]) {
        [connection cancel];
        if (self.progress) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                // 强制运行循环执行一次更新
                [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate date]];
                
                self.progress(1.0 , self.cachePath);
            }];
        }
    }else{
        // 2. 文件总长度
        self.fileLength = response.expectedContentLength;
        // 3. 当前下载的文件长度
        self.currentLength = 0;
        
        // 清空数据
        [self.dataM setData:nil];
    }
}

// 2. 接收数据，从服务器接收到数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // 拼接数据
    [self.dataM appendData:data];
    
    // 根据data的长度增加当前下载的文件长度
    self.currentLength += data.length;
    
    float progress = (float)self.currentLength / self.fileLength;
    
    // 判断是否定义了块代码
    if (self.progress) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            // 强制运行循环执行一次更新
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate date]];
            
            self.progress(progress , self.cachePath);
        }];
    }
}

// 3. 完成接收
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    PLog(@"%s %@", __func__, [NSThread currentThread]);
    // 将dataM写入沙盒的缓存目录
    // 写入数据，NSURLConnection底层实现是用磁盘做的缓存
    [self.dataM writeToFile:self.cachePath atomically:YES];
}

// 4. 出现错误
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    PLog(@"%@", error.localizedDescription);
}

@end
