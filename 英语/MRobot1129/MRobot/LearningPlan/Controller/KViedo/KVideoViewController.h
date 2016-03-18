//
//  KVideoViewController.h
//  MRobot
//
//  Created by BaiYu on 15/8/26.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "BaseViewController.h"
#import "KVideoView.h"

@interface KVideoViewController : BaseViewController<PassBtnTagDelegate>
{
    NSArray *kVideosArr;
    
    NSString *_videoId;//视频Id
    NSString *_videoTitle;//视频名称
    NSString *_imgUrlstring;//视频封面地址
    NSString *_videoURL;//视频分享地址
}
@property (strong, nonatomic) NSString *kId;//知识点Id
@property (strong, nonatomic) NSString *kName;//知识点名称
@end
