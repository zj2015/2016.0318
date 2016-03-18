//
//  SoundTools.h
//  MRobot
//
//  Created by sdfsdf on 15/11/23.
//  Copyright © 2015年 silysolong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@interface SoundTools : NSObject

//单例宏
singleton_interface(SoundTools)

//要播放的音效名
- (void)playSoundWithName:(NSString *)name;

@end