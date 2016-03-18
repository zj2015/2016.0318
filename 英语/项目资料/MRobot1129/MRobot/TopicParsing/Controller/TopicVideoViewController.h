//
//  TopicVideoViewController.h
//  MRobot
//
//  Created by BaiYu on 15/9/6.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "BaseViewController.h"
#import "TypeQuestionListModel.h"

@interface TopicVideoViewController : BaseViewController
{
    TypeQuestionListModel *typeQListModel;
    NSArray *qListArr;
    
    NSString *_videoId;//视频Id
    NSString *_videoTitle;//视频名称
    NSString *_imgUrlstring;//视频封面地址
    NSString *_videoURL;//视频分享地址
}
@property (strong, nonatomic) NSString *tId;//题型Id
@property (strong, nonatomic) NSString *tName;//题型名称
@end
