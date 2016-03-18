//
//  Singleton.h
//  MRobot
//
//  Created by sdfsdf on 15/11/23.
//  Copyright © 2015年 silysolong. All rights reserved.
//

#ifndef Singleton_h
#define Singleton_h


#endif /* Singleton_h */

// .h
#define singleton_interface(className) + (instancetype)shared##className;

// .m
// 最后一句不要斜线
#define singleton_implementation(className) \
static className *_instace; \
\
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instace = [super allocWithZone:zone]; \
}); \
\
return _instace; \
} \
\
+ (instancetype)shared##className \
{ \
if (_instace == nil) { \
_instace = [[className alloc] init]; \
} \
\
return _instace; \
}