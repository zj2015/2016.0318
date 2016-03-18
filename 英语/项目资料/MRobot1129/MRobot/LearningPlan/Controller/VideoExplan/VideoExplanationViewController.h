//
//  VideoExplanationViewController.h
//  MRobot
//
//  Created by BaiYu on 15/8/22.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "BaseViewController.h"
#import "KVideoView.h"
#import "SVideoView.h"
#import "CustomAlertView.h"

@interface VideoExplanationViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,PassBtnTagDelegate,PassSkillBtnTagDelegate>
{
    UIButton *knowledgeBtn;
    UIButton *solveBtn;
    UITableView *videoTable;
    
    UIView *alertBgView;
    
    NSMutableArray *openedInSectionArr;
    NSInteger preHeaderIndex;//上一个被点击的区头
    
    NSArray *kVideosArr;//知识点视频列表
    NSArray *sVideosArr;//技巧视频列表
    
    NSInteger dataCount;//返回数据量（代表需创建几个区）
    
    NSString *_videoId;//视频Id
    NSString *_videoTitle;//视频名称
    NSString *_imgUrlstring;//视频封面地址
    NSString *_videoURL;//视频分享地址
}
@property (assign, nonatomic) NSInteger fromVC;//(0 代表视频讲解 1 代表Lecture on answer to question Repeat)
@property (strong, nonatomic) NSString *weekId;//周Id

@end
