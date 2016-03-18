//
//  ErrorTopicSetViewController.h
//  ERobot
//
//  Created by mac on 15/7/13.
//  Copyright (c) 2015年 BaiYu. All rights reserved.
//

#import "BaseViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "ErrorQuestionView.h"
#import "ErrorTianQuestionView.h"
#import "ErrorYueduQuestionView.h"
#import "ErrorTingliQuestionView.h"
#import "QuestionAnswer.h"

@interface ErrorTopicSetViewController : BaseViewController<UIScrollViewDelegate,AVAudioPlayerDelegate,UIAlertViewDelegate,ErrorTingliQuestionViewDelegate,ErrorYueduQuestionViewDelegate,ErrorTianQuestionViewDelegate,QuestionAnswerDelegate,ErrorQuestionViewDelegate>
{
    NSMutableArray *openedInArr;//听力 存储0或1 如果是0 不播放  如果是1 播放
    NSMutableDictionary *openedInDict;
    BOOL bsound;//语音是否播放
}
@property (assign, nonatomic) BOOL isRightBtn;//点击中间按钮
@property (strong, nonatomic) QuestionAnswer *answerView;//答案对照
@property (strong, nonatomic) NSMutableArray *answerArr;// 0 没写， 1正确   2错误

@property (strong, nonatomic) NSMutableArray *isPlay;
@property (assign, nonatomic) int soundIndex;//听力第几题
@property (copy, nonatomic) NSString *soundUrl;//听力地址
@property (strong, nonatomic) UIView *lastView;
@property (strong, nonatomic) AVAudioPlayer *soundplayer;//播放器
@property (strong, nonatomic) UIScrollView *myScrollView;

@property (assign, nonatomic) int questionAccount;//题目数量

@property (strong, nonatomic) UILabel *topicLabel;//题型


@property (strong, nonatomic) NSArray *danArr;//选择题
@property (strong, nonatomic) NSArray *tianArr;//填空题
@property (strong, nonatomic) NSArray *yueArr;//阅读理解
@property (strong, nonatomic) NSMutableArray *yuedanArr;

@property (strong, nonatomic) NSArray *tingArr;//听力题
@property (strong, nonatomic) NSMutableArray *tingdanArr;

@property (copy, nonatomic) NSString * kId;

@property (copy, nonatomic) NSString * monthTimeStamp;

@property (copy, nonatomic) NSString * qId;

@property (strong, nonatomic) NSMutableArray *qIdArray;

@property (copy, nonatomic) NSString *witchVC;

@property (assign, nonatomic) int errorType; // 0:我的错题库， 1:易错知识点-我的错题集

@property (assign, nonatomic) int page;

@end
