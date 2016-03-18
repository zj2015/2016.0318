//
//  WsqMD5Util.h
//  Elibrary
//
//  Created by zjb on 15/5/15.
//  Copyright (c) 2015年 zjb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>


#define FileHashDefaultChunkSizeForReadingData 1024*8 // 8K
@interface WsqMD5Util : NSObject
//计算NSData 的MD5值
+(NSString*)getMD5WithData:(NSData*)data;

//计算字符串的MD5值，
+(NSString*)getmd5WithString:(NSString*)string;

//计算大文件的MD5值
+(NSString*)getFileMD5WithPath:(NSString*)path;
@end
