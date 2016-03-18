//
//  ExerciseTrainViewController.h
//  MRobot
//
//  Created by mac on 15/8/22.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "BaseViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "QuestionAnswer.h"
#import "TianQuestionView.h"
#import "YueduQuestionView.h"
#import "TingliQuestionView.h"
#import "QuestionAnswer.h"
#import "SkillListModel.h"
#import "TypeQListModel.h"
@interface ExerciseTrainViewController : BaseViewController<QuestionAnswerDelegate,UIScrollViewDelegate,TingliQuestionViewDelegate,YueduQuestionViewDelegate,QuestionViewDelegate,TianQuestionViewDelegate,UIAlertViewDelegate,AVAudioPlayerDelegate>
{
    BOOL bsound;//语音是否播放
    int myPage;
    int j ;
    int k ;
    int m ;
    
    NSString *_videoId;//视频Id
    NSString *_videoTitle;//视频名称
    NSString *_imgUrlstring;//视频封面地址
    NSString *_videoURL;//视频分享地址
}
@property (strong, nonatomic) QuestionAnswer *answerView;//答案对照
@property (strong, nonatomic) NSMutableArray *answerArr;// 0 没写， 1正确   2错误
@property (strong, nonatomic) NSMutableArray *choose;
@property (strong, nonatomic) NSMutableArray *array;//提交答案
@property (strong, nonatomic) NSMutableDictionary *answerDict;
@property (assign, nonatomic) int numQuestionCount;//未答题目的个数；
@property (strong, nonatomic) NSMutableArray *tianArray1;//填空题答案
@property (strong, nonatomic) NSMutableArray *tianArray2;
@property (strong, nonatomic) NSMutableArray *tianArray3;

@property (strong, nonatomic) NSMutableArray *isPlay;
@property (assign, nonatomic) int soundIndex;//听力第几题
@property (copy, nonatomic) NSString *soundUrl;//听力地址
@property (strong, nonatomic) AVAudioPlayer *soundplayer;//播放器
@property (strong, nonatomic) UIScrollView *myScrollView;
@property (assign, nonatomic)int page;
@property (assign, nonatomic) int questionAccount;//题目数量
@property (strong, nonatomic) UILabel *titleLabels;//试卷标题
@property (strong, nonatomic) UILabel *topicLabel;//题型
@property (strong, nonatomic) UILabel *timeLabel;//考试倒计时
@property (strong, nonatomic) UIImageView *timeView;//时钟的图片
@property (assign, nonatomic) long timeNumber;//总时间
@property (assign, nonatomic) long time;

@property (strong, nonatomic) NSArray *danArr;//选择题
@property (strong, nonatomic) NSArray *tianArr;//填空题
@property (strong, nonatomic) NSArray *yueArr;//阅读理解
@property (strong, nonatomic) NSMutableArray *yuedanArr;

@property (strong, nonatomic) NSArray *tingArr;//听力题
@property (strong, nonatomic) NSMutableArray *tingdanArr;

@property (copy, nonatomic) NSString *whichMV;
@property (copy, nonatomic) NSString *weekId;//周编号
@property (copy, nonatomic) NSString *sId;//技巧编号
@property (assign, nonatomic) int setType;//习题类型 0:习题训练  1:训练技巧   2:重新训练  3:知识点题目列表  4:查询大题
@property (copy, nonatomic) NSString * sType;//技巧训练的技巧类型  0:重点  1:其他   2:题型选择-技巧训练
@property (copy, nonatomic) NSString * kId; //重新训练页面(知识点题目列表) 知识点id
@property (assign, nonatomic) int fromType;// 0 知识点学习的知识点题目列  1:我的重新训练

@property (strong, nonatomic) SkillListModel *skillModel;//训练结果视频
@property (strong, nonatomic) TypeQListModel *qListModel;//训练结果视频

@property (strong, nonatomic) NSString * qId; //查询大题  大题qId

@end
