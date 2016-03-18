//
//  xml.m
//  xml
//
//  Created by vin on 14-5-5.
//  Copyright (c) 2014年 LianZhan. All rights reserved.
//

#import "xml.h"

@implementation xml
{
    Success successBlock;
    
}

//static  Success successBlock;

//单例
+(xml *)shareInstance
{
    static  xml *shareInterface=nil;
    if (shareInterface==nil) {
        shareInterface=[[xml alloc]init];
    }
    return shareInterface;
}
-(id)init
{
    self=[super init];
   
    if (self ==nil) {
        
    }
    
    return self;
}

-(void)getjsonFrom:(NSData *)data success:(Success)success {
    
    NSXMLParser *parser = [[NSXMLParser alloc]initWithData:data];
    parser.delegate = self;
    
    successBlock=[success copy];
    
    lastStr = @"";
    [parser parse];    
    
}


#pragma mark xmlparser
//step 1 :准备解析
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    PLog(@"准备");
    
}
//step 2：准备解析节点
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    
}
//step 3:获取首尾节点间内容
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    lastStr = [lastStr stringByAppendingString:string];
}

//step 4 ：解析完当前节点
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
//    DLog(@"%@   %@    %@",elementName,namespaceURI,qName);
//    DLog(@"%@",lastStr);
    successBlock(lastStr);
}

//step 5；解析结束
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    //    DLog(@"%@",NSStringFromSelector(_cmd) );
    
    PLog(@"结束");
}

@end
