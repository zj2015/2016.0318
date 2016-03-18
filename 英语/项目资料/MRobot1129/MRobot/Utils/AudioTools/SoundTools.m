//
//  SoundTools.m
//  MRobot
//
//  Created by sdfsdf on 15/11/23.
//  Copyright © 2015年 silysolong. All rights reserved.
//

#import "SoundTools.h"
#import <AudioToolbox/AudioToolbox.h>

/**
 将所有的音频文件在此单例中统一处理
 */

@interface SoundTools()
{
    NSDictionary    *_soundDict; // 音频字典
}

@end

@implementation SoundTools
singleton_implementation(SoundTools)

- (id)init
{
    self = [super init];
    
    if (self) {
        // 完成所有音频文件的加载工作
        _soundDict = [self loadSounds];
    }
    
    return self;
}
#pragma mark 加载所有的音频文件
- (SystemSoundID)loadSoundWithURL:(NSURL *)url
{
    SystemSoundID soundID = 0;
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url), &soundID);
    
    return soundID;
}
- (NSDictionary *)loadSounds
{
    // 思考:如何直到加载哪些音频文件呢?
    // 建立一个sound.bundle,存放所有的音效文件
    // 在程序执行时,直接遍历bundle中的所有文件
    // 1. 取出bundle的路径名
    NSString *mainBundlPath = [[NSBundle mainBundle] bundlePath];
    NSString *bundlePath =[mainBundlPath stringByAppendingPathComponent:@"sound.bundle"];
    
    // 2. 遍历目录
    NSArray *array = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:bundlePath error:nil];
    
    // 3. 遍历数组,创建SoundID,如何使用?
    NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithCapacity:array.count];
    
    [array enumerateObjectsUsingBlock:^(NSString *fileName, NSUInteger idx, BOOL *stop) {
        // 1> 拼接URL
        NSString *filePath = [bundlePath stringByAppendingPathComponent:fileName];
        NSURL *fileURL = [NSURL fileURLWithPath:filePath];
        
        SystemSoundID soundID = [self loadSoundWithURL:fileURL];
        
        // 将文件名作为键值
        [dictM setObject:@(soundID) forKey:fileName];
    }];
    
    return dictM;
    
    
}


#pragma mark - 播放音频

- (void)playSoundWithName:(NSString *)name
{
    
    SystemSoundID soundID = 0;

    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"wav"];
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundID);
    
    
    AudioServicesPlaySystemSound (soundID);

}

@end