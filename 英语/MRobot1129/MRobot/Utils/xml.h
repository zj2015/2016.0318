//
//  xml.h
//  xml
//
//  Created by vin on 14-5-5.
//  Copyright (c) 2014年 LianZhan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^Success)(NSString* object);


@interface xml : NSObject<NSXMLParserDelegate>
{
    NSString *lastStr;
}
-(void)getjsonFrom:(NSData *)data success:(Success)success;

+(xml *)shareInstance;
@end
