//
//  ExerciseTrainViewController.m
//  MRobot
//
//  Created by mac on 15/8/22.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "ExerciseTrainViewController.h"
#import "TrainResultViewController.h"
#import "QuestionDataModel.h"
#import "ReadingComModel.h"
#import "QuestionListModel.h"
#import "SubmitQuestionModel.h"
#import "PicBrowseViewController.h"
#import "DWCustomPlayerViewController.h"
#import "RequestCenter.h"
#import "SBJSON.h"
#import "TrainResultViewController.h"
#import "TrainResultTwoViewController.h"
#import "TrainResultThreeViewController.h"
#import "TrainResultFourViewController.h"

#import "SubmitByWeekModel.h"
#import "SubmitBySkillModel.h"
#import "UserLoginModel.h"
@interface ExerciseTrainViewController ()
{
    BOOL _isMiddleClick;
}
@property (strong, nonatomic) QuestionDataModel *questionModel;
@property (strong,nonatomic)NSTimer *timer;
@property (strong,nonatomic)NSMutableArray *sourceViewArr;
@end

@implementation ExerciseTrainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _page = 0;
    j=0;k=0;m = 0;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tryToExamAgain:) name:MYNOTI_USER_TRYAGAIN object:nil];
}

- (void)tryToExamAgain:(NSNotification *)noti
{
    _page = 0;
    j=0;k=0;m = 0;
    [self.view removeAllSubviews];
    [self _prepareData];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MYNOTI_USER_TRYAGAIN object:nil];
}

- (void)_prepareData
{
    _questionAccount = 0;
    LearningPlanRequest *request = [[LearningPlanRequest  alloc]init];
    if ( _setType == 0) {
        //weekId 周编号
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [request userQuestinListWithWeekId:_weekId success:^(id obj) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self infoResult:obj];
        } failed:^(id obj) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
    }else if (_setType == 1){
        //sId  技巧编号
        //sType 0：重点 1：其他  2：题型选择-技巧训练
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [request userSkillQuestionListWithSId:_sId andSType:_sType success:^(id obj) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self infoResult:obj];
        } failed:^(id obj) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
    }else if (_setType == 2){
        // 1.4.33 知识点错题集
        //kId  重新训练的知识点id
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [request userKnowledgeWrongQuestionListWithKId:_kId success:^(id obj) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self infoResult:obj];
        } failed:^(id obj) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
    }else if (_setType == 3){
        //1.4.27 知识点题目列表
        //kId  知识点id
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [request userKnowledgeQuestionListWithKId:_kId success:^(id obj) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self infoResult:obj];
        } failed:^(id obj) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
    }else if (_setType == 4){
        //1.4.31 查询大题
        //qId  大题Id
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [request userQuestionInfoWithQId:_qId success:^(id obj) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self infoResult:obj];
        } failed:^(id obj) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
    }
}

- (void)infoResult:(id)obj
{
    _yuedanArr = [NSMutableArray array];
    _tingdanArr = [NSMutableArray array];
    InfoResult *infoResult = (InfoResult *)obj;
    if ([infoResult.code isEqualToString:@"0"]) {
        _questionModel = [[QuestionDataModel alloc] init];
        _questionModel = (QuestionDataModel *)[infoResult extraObj];
        _timeNumber = 0;
        
        _danArr = [NSArray arrayWithArray:_questionModel.dxt];
        _tianArr = [NSArray arrayWithArray:_questionModel.tkt];
        _yueArr = [NSArray arrayWithArray:_questionModel.ydljt];
        _tingArr = [NSArray arrayWithArray:_questionModel.tlt];
        
        //提交答案
        _array = [NSMutableArray array];
        _answerDict = [NSMutableDictionary dictionary];
        
        for (int i = 0; i < [_danArr count]; i ++ ) {
            QuestionListModel *listModel = _danArr[i];
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            _choose = [[NSMutableArray alloc]initWithObjects:@"", nil];
            [dict setValue:listModel.qId forKey:@"qId"];
            [dict setValue:_choose forKey:@"options"];
            [_array addObject:dict];
        }
        
        for (int i = 0; i < [_tianArr count]; i ++ ) {
            QuestionListModel *listModel = _tianArr[i];
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            _tianArray1 = [NSMutableArray array];
            if (listModel.options.count) {
                for (int i = 0; i < listModel.options.count; i ++) {
                    [_tianArray1 addObject:@""];
                }
            }else{
                [_tianArray1 addObject:@""];
            }
            [dict setValue:listModel.qId forKey:@"qId"];
            [dict setValue:_tianArray1 forKey:@"options"];
            [_array addObject:dict];
        }
        
        
        
        //阅读理解
        for (int i = 0; i < _yueArr.count; i ++ ) {
            ReadingComModel *listmodel = _yueArr[i];
            NSDictionary *dict = listmodel.childQuestions;
            if ([dict objectForKey:@"DXT"]) {
                QuestionDataModel *dataModel = [dict objectForKey:@"DXT"];
                for (QuestionListModel *arr in dataModel.dxt) {
                    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:arr,@"title",@"0",@"type", nil];
                    [_yuedanArr addObject: dict];
                    
                    _choose = [[NSMutableArray alloc]initWithObjects:@"", nil];
                    NSMutableDictionary *Dict = [NSMutableDictionary dictionary];
                    [Dict setValue:arr.qId forKey:@"qId"];
                    [Dict setValue:_choose forKey:@"options"];
                    [_array addObject:Dict];
                }
            }
            if ([dict objectForKey:@"TKT"]) {
                QuestionDataModel *dataModel = [dict objectForKey:@"TKT"];
                for (QuestionListModel *arr in dataModel.tkt) {
                    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:arr,@"title",@"1",@"type", nil];
                    [_yuedanArr addObject: dict];
                    
                    _tianArray2 = [NSMutableArray array];
                    for (int i = 0; i < arr.options.count; i ++) {
                        [_tianArray2 addObject:@""];
                    }
                    
                    NSMutableDictionary *Dict = [NSMutableDictionary dictionary];
                    [Dict setValue:arr.qId forKey:@"qId"];
                    [Dict setValue:_tianArray2 forKey:@"options"];
                    [_array addObject:Dict];
                }
            }
            
        }
        
        //听力
        for (int i = 0; i < _tingArr.count; i ++ ) {
            
            ReadingComModel *listmodel = _tingArr[i];
            NSDictionary *dict = listmodel.childQuestions;
            if ([dict objectForKey:@"DXT"]) {
                QuestionDataModel *dataModel = [dict objectForKey:@"DXT"];
                for (QuestionListModel *arr in dataModel.dxt) {
                    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:arr,@"title",@"0",@"type", nil];
                    [_tingdanArr addObject: dict];
                    _choose = [[NSMutableArray alloc]initWithObjects:@"", nil];
                    NSMutableDictionary *Dict = [NSMutableDictionary dictionary];
                    [Dict setValue:arr.qId forKey:@"qId"];
                    [Dict setValue:_choose forKey:@"options"];
                    [_array addObject:Dict];
                }
            }
            if ([dict objectForKey:@"TKT"]) {
                QuestionDataModel *dataModel = [dict objectForKey:@"TKT"];
                for (QuestionListModel *arr in dataModel.tkt) {
                    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:arr,@"title",@"1",@"type", nil];
                    [_tingdanArr addObject: dict];
                    
                    _tianArray3 = [NSMutableArray array];
                    for (int i = 0; i < arr.options.count; i ++) {
                        [_tianArray3 addObject:@""];
                    }
                    
                    NSMutableDictionary *Dict = [NSMutableDictionary dictionary];
                    [Dict setValue:arr.qId forKey:@"qId"];
                    [Dict setValue:_tianArray3 forKey:@"options"];
                    [_array addObject:Dict];
                }
            }
        }
        
        _questionAccount = (int)_tianArr.count + (int)_danArr.count + (int)_yuedanArr.count + (int)_tingdanArr.count;
        
        //答案对照
        _answerArr = [NSMutableArray array];
        for (int i = 0; i < _questionAccount; i ++) {
            [_answerArr addObject:@"0"];
        }
        
        [self _prepareView];
        
    }
}

- (void)_prepareView
{
    if (_questionAccount) {
        
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MainScreenSize_W, 65)];
        bgView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:bgView];
        
        
        CGFloat exerciseWidth = 35;//bookknowledge
        CGFloat exerciseX =( MainScreenSize_W - exerciseWidth)/2.0;
        UIImageView *exerciseImg = [[UIImageView alloc]initWithFrame:CGRectMake(exerciseX, 5, exerciseWidth, exerciseWidth)];
        exerciseImg.image = [UIImage imageNamed:@"bookknowledge"];
        exerciseImg.layer.cornerRadius = exerciseWidth/2.0;
        exerciseImg.layer.masksToBounds = YES;
        [bgView addSubview:exerciseImg];
        
        CGFloat topicLabW = 250;
        CGFloat topicLabX = ( MainScreenSize_W - topicLabW)/2.0;
        _topicLabel = [[UILabel alloc]initWithFrame:CGRectMake(topicLabX, exerciseImg.bottom, topicLabW, 25)];
        _topicLabel.hidden = NO;
        _topicLabel.textAlignment = NSTextAlignmentCenter;
        _topicLabel.textColor = [UIColor grayColor];
        _topicLabel.font = [UIFont boldSystemFontOfSize:14];
        if (_danArr.count) {
            _topicLabel.text = @"选择题";
        }else if (_tianArr.count){
            _topicLabel.text = @"填空题";
        }else if (_yueArr.count){
            ReadingComModel *listmodel = [_yueArr firstObject];
            if ([listmodel.questionType isEqualToString:@"0"]) {
                _topicLabel.text = @"套题";
            }else {
                _topicLabel.text = @"阅读理解题";
            }
        }else if (_tingdanArr.count){
            _topicLabel.text = @"听力题";
        }
        [bgView addSubview:_topicLabel];
        
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(MainScreenSize_W - 70, bgView.height / 2.0, 60, 20)];
        _timeLabel.text = @"00:00:00";
        _timeLabel.textColor = [UIColor grayColor];
        _timeLabel.font = [UIFont boldSystemFontOfSize:12];
        _time = _timeNumber;
        [bgView addSubview:_timeLabel];
        
        _timeView = [[UIImageView alloc]initWithFrame:CGRectMake((_timeLabel.left + _timeLabel.right)/2.0 - 15/2.0 , bgView.height/2.0 - 15 , 15, 15)];
        _timeView.image = [UIImage imageNamed:@"clock"];
        [bgView addSubview:_timeView];
        
        CGRect rect = CGRectMake(0.0f,bgView.bottom,MainScreenSize_W,MainScreenSize_H-bgView.bottom);
        _myScrollView = [[UIScrollView alloc]initWithFrame:rect];
        //题目的个数
        _myScrollView.contentSize= CGSizeMake(MainScreenSize_W*_questionAccount, 0);
        _myScrollView.pagingEnabled = YES;
        _myScrollView.delegate = self;
        _myScrollView.tag = 111;
        _myScrollView.showsHorizontalScrollIndicator = NO;
        _myScrollView.showsVerticalScrollIndicator = NO;
        _myScrollView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_myScrollView];
        
        _sourceViewArr = @[].mutableCopy;
        
        _answerView = [[QuestionAnswer alloc]initWithFrame:CGRectMake(0, 64, MainScreenSize_W, MainScreenSize_H - 64)];
        _answerView.backgroundColor = [UIColor whiteColor];
        _answerView.delegate = self;
        _answerView.hidden = YES;
        [self.view addSubview:_answerView];
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        for (int i = 0; i < _questionAccount; i ++) {
            //判断选择题，填空题，听力题,阅读理解
            if ((i+1)> (_danArr.count + _tianArr.count + _yuedanArr.count)) {
                //听力题
                TingliQuestionView *questionView = [[TingliQuestionView alloc]initWithFrame:CGRectMake(10 + i*MainScreenSize_W, 0 , MainScreenSize_W - 20, MainScreenSize_H - 114)];
                int temp = 0;
                questionView.tag = i+1;
                for (int o = 0; o < _tingArr.count; o ++ ) {
                    ReadingComModel *listmodel = _tingArr[o];
                    NSDictionary *dict = listmodel.childQuestions;
                    if ([dict objectForKey:@"DXT"]) {
                        QuestionDataModel *dataModel = [dict objectForKey:@"DXT"];
                        if (dataModel.dxt.count) {
                            temp += dataModel.dxt.count;
                        }
                    }
                    if ([dict objectForKey:@"TKT"]) {
                        QuestionDataModel *dataModel = [dict objectForKey:@"TKT"];
                        if (dataModel.tkt.count) {
                            temp += dataModel.tkt.count;
                        }
                    }
                    if (temp>m) {
                        if ([_whichMV isEqualToString:@"讲解视频"]) {
                            questionView.whichMV = _whichMV;
                        }
                        [questionView addTingLiData:_tingArr[o] withPage:_tingdanArr[m] withIndex:o];
                        break;
                    }
                }
                questionView.delegate = self;
                myPage ++ ;
                questionView.backgroundColor = PView_BGColor;
                [_myScrollView addSubview:questionView];
                m ++;
                [_sourceViewArr addObject:questionView];
            }else if ((i+1)> (_danArr.count + _tianArr.count)){
                //阅读理解题
                YueduQuestionView *questionView = [[YueduQuestionView alloc]initWithFrame:CGRectMake(10 + i*MainScreenSize_W, 0 , MainScreenSize_W - 20, MainScreenSize_H - 114)];
                int temp = 0;
                for (int n = 0; n < _yueArr.count; n ++ ) {
                    ReadingComModel *listmodel = _yueArr[n];
                    NSDictionary *dict = listmodel.childQuestions;
                    if ([dict objectForKey:@"DXT"]) {
                        QuestionDataModel *dataModel = [dict objectForKey:@"DXT"];
                        if (dataModel.dxt.count) {
                            temp += dataModel.dxt.count;
                        }
                    }
                    if ([dict objectForKey:@"TKT"]) {
                        QuestionDataModel *dataModel = [dict objectForKey:@"TKT"];
                        if (dataModel.tkt.count) {
                            temp += dataModel.tkt.count;
                        }
                    }
                    if (temp>k) {
                        if ([_whichMV isEqualToString:@"讲解视频"]) {
                            questionView.whichMV = _whichMV;
                        }
                        [questionView addYueDuData:_yueArr[n] withPage:_yuedanArr[k]];
                        break;
                    }
                }
                questionView.delegate = self;
                questionView.tag = 0;
                myPage ++ ;
                questionView.backgroundColor = PView_BGColor;
                [_myScrollView addSubview:questionView];
                k ++;
                [_sourceViewArr addObject:questionView];
            }else if ((i+1)> _danArr.count){
                //填空题
                TianQuestionView *questionView = [[TianQuestionView alloc]initWithFrame:CGRectMake(i*MainScreenSize_W, 0 , MainScreenSize_W, MainScreenSize_H - 114)];
                if ([_whichMV isEqualToString:@"讲解视频"]) {
                    questionView.whichMV = _whichMV;
                }
                [questionView addTianKongData:_tianArr[j]];
                questionView.delegate = self;
                questionView.tag = 0;
                questionView.backgroundColor = PView_BGColor;
                myPage ++ ;
                [_myScrollView addSubview:questionView];
                j ++;
                [_sourceViewArr addObject:questionView];
            }else {
                //选择题
                QuestionView *questionView = [[QuestionView alloc]initWithFrame:CGRectMake(0 + i*MainScreenSize_W, 0 , MainScreenSize_W , MainScreenSize_H - 114)];
                questionView.only = NO;
                questionView.delegate = self;
                questionView.tag = 0;
                if ([_whichMV isEqualToString:@"讲解视频"]) {
                    questionView.whichMV = _whichMV;
                }
                [questionView addDanxuanData:_danArr[i]];
                questionView.backgroundColor = RgbColor(174, 159, 110);
                myPage ++ ;
                [_myScrollView addSubview:questionView];
                [_sourceViewArr addObject:questionView];
            }
            
        }
        
        
        [self performSelector:@selector(titles) withObject:self afterDelay:0.3];
        
        [self addTimer];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    }else{
        [aCommon iToast:@"没有数据~"];
    }
    self.view.backgroundColor = PView_BGColor;
    
}

- (void)titles
{
//    [self base_changeNavigationTitleWithString:[NSString stringWithFormat:@"%d/%d",1,_questionAccount] andImage:@"nav_title"];
    [self base_changeNavigationTitleWithString:@"在线考试" andSmallTitle:[NSString stringWithFormat:@"%d-%d",1,_questionAccount]];
    [self base_createRightNavigationBarButtonWithFrontImage:@"more2" andSelectedImageName:@"more2" andBackGroundImageName:@"more2" andTitle:@"交卷" andSize:CGSizeMake(40, 30)];
}

-(void)addTimer
{
    _timer=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(nextTime) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

-(void)removeTimer
{
    //    if (self.rightBtn.hidden == NO) {
    [self.timer invalidate];
    self.timer=nil;
    //    }
}

-(void)nextTime
{
    _timeNumber++;
    int hour = _timeNumber/3600.0;
    int min = (int)_timeNumber%3600/60;
    int temp = (int)_timeNumber%3600%60;
    _timeLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d",hour,min,temp];
    
}


#pragma mark --UIScrollViewDelegate--

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offset = scrollView.contentOffset.x;
    if (offset < 0)
    {
        return;
    }
    for (UIView *viewController in _sourceViewArr)
    {
        NSInteger index = [_sourceViewArr indexOfObject:viewController];
        CGFloat width = _myScrollView.frame.size.width;
        CGFloat y = index * width;
        CGFloat value = (offset-y)/width;
        //        CGFloat scale = 1.f-fabs(value);
        CGFloat scale = fabs(cos(fabs(value)*M_PI/5));
        
        //        if (scale > 1.f) scale = 1.f;
        //        if (scale < .9f) scale = .9f;
        
        viewController.transform = CGAffineTransformMakeScale(scale, scale);
    }
    
    for (UIView *viewController in _sourceViewArr)
    {
        CALayer *layer = viewController.layer;
        layer.shadowPath = [UIBezierPath bezierPathWithRect:viewController.bounds].CGPath;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    
     [[SoundTools sharedSoundTools] playSoundWithName:@"ui_turn"];

    
    if (scrollView.tag == 111) {
        [self.view endEditing:YES];
    }
    _page = (scrollView.contentOffset.x+MainScreenSize_W*0.5)/MainScreenSize_W;
    PLog(@"%d",_page);
    
    _tianArray1 = [NSMutableArray array];
    _tianArray2 = [NSMutableArray array];
    _tianArray3 = [NSMutableArray array];
    
    if (_page < _danArr.count+_tianArr.count+_yuedanArr.count + _tingdanArr.count) {
        if (_page>=(_danArr.count+_tianArr.count+_yuedanArr.count)) {
            NSDictionary *page3 = _tingdanArr[_page-_danArr.count-_tianArr.count-_yuedanArr.count];
            QuestionListModel *data3 = [page3 valueForKey:@"title"];
            for (int i = 0; i < data3.options.count; i ++) {
                [_tianArray3 addObject:@""];
            }
        }else if (_page>=(_danArr.count+_tianArr.count)) {
            NSDictionary *page2 = _yuedanArr[_page-_danArr.count-_tianArr.count];
            QuestionListModel *data2 = [page2 valueForKey:@"title"];
            for (int i = 0; i < data2.options.count; i ++) {
                [_tianArray2 addObject:@""];
            }
        }else if (_page>=_danArr.count) {
            QuestionListModel *data1 = _tianArr[_page-_danArr.count];
            for (int i = 0; i < data1.options.count; i ++) {
                [_tianArray1 addObject:@""];
            }
        }
//        [self base_changeNavigationTitleWithString:[NSString stringWithFormat:@"%d/%d",_page+1,_questionAccount]
//                                          andImage:@"nav_title"];
        [self base_changeNavigationTitleWithString:@"在线考试" andSmallTitle:[NSString stringWithFormat:@"%d-%d",_page+1,_questionAccount]];
        if ((_page+1)> (_danArr.count + _tianArr.count + _yuedanArr.count)) {
            _topicLabel.text = @"听力题";
            int oral =  (int)(_page - _danArr.count - _tianArr.count - _yueArr.count);
            int temp = 0;
            for (int n = 0; n < _tingArr.count; n ++ ) {
                ReadingComModel *listmodel = _tingArr[n];
                NSDictionary *dict = listmodel.childQuestions;
                if ([dict objectForKey:@"DXT"]) {
                    QuestionDataModel *dataModel = [dict objectForKey:@"DXT"];
                    if (dataModel.dxt.count) {
                        temp += dataModel.dxt.count;
                    }
                }
                if ([dict objectForKey:@"TKT"]) {
                    QuestionDataModel *dataModel = [dict objectForKey:@"TKT"];
                    if (dataModel.tkt.count) {
                        temp += dataModel.tkt.count;
                    }
                }
                if (temp>=oral) {
                    
                    TingliQuestionView *questionView;
                    for (UIView *view in [scrollView subviews]) {
                        if (view.tag){
                            questionView = (TingliQuestionView *)view;
                            
                            if (bsound) {
                                if ([_soundUrl isEqualToString:listmodel.qTitleMediaUrl]) {
                                    
                                    [questionView.tingLiButton startAnimating];//开始播放动画
                                    
                                }else{
                                    if ([self.soundplayer isPlaying]) {
                                        [self.soundplayer stop];
                                        [questionView.tingLiButton stopAnimating];
                                        bsound = NO;
                                    }
                                }
                            }else{
                                [questionView.tingLiButton stopAnimating];
                            }
                        }
                    }
                    
                    
                    break;
                }
            }
            
        }else if ((_page+1)> (_danArr.count + _tianArr.count)){
            int temp = 0;
            int yueCount = _page+1 - (int)_danArr.count - (int)_tianArr.count;
            for (int n = 0; n < _yueArr.count; n ++ ) {
                ReadingComModel *listmodel = _yueArr[n];
                NSDictionary *dict = listmodel.childQuestions;
                if ([dict objectForKey:@"DXT"]) {
                    QuestionDataModel *dataModel = [dict objectForKey:@"DXT"];
                    if (dataModel.dxt.count) {
                        temp += dataModel.dxt.count;
                    }
                }
                if ([dict objectForKey:@"TKT"]) {
                    QuestionDataModel *dataModel = [dict objectForKey:@"TKT"];
                    if (dataModel.tkt.count) {
                        temp += dataModel.tkt.count;
                    }
                }
                if (temp >= yueCount) {
                    if ([listmodel.questionType isEqualToString:@"0"]) {
                        _topicLabel.text = @"套题";
                    }else {
                        _topicLabel.text = @"阅读理解题";
                    }
                    break;
                }
            }
            if ([self.soundplayer isPlaying]) {
                [self.soundplayer stop];
                bsound = NO;
            }
        }else if ((_page+1)> _danArr.count){
            _topicLabel.text = @"填空题";
            if ([self.soundplayer isPlaying]) {
                [self.soundplayer stop];
                bsound = NO;
            }
        }else {
            _topicLabel.text = @"选择题";
            if ([self.soundplayer isPlaying]) {
                [self.soundplayer stop];
                bsound = NO;
            }
        }
    }

}

- (void)submitAnswer
{
    
    [[SoundTools sharedSoundTools] playSoundWithName:@"ui_click_in"];

    
    NSString *TakeTime = [NSString stringWithFormat:@"%.0f",_timeNumber*1000.0];
    
    [_answerDict setValue:_array forKey:@"result"];
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    NSString *jsonString = [writer stringWithObject:_answerDict];
    jsonString = [jsonString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    PLog(@"json = %@ =",jsonString);
    [self removeTimer];
    if (bsound) {
        [self.soundplayer stop];
        self.soundplayer=nil;
        bsound = NO;
    }
    
    LearningPlanRequest *request = [[LearningPlanRequest alloc] init];
    if (self.setType == 0) { // 0:习题训练
        // 提交答案-教材强化习题训练
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [request userSubmitAnswerByWeekWithWeekId:_weekId andTakeTime:TakeTime andAnswerResult:jsonString success:^(id obj) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            InfoResult *infoResult = (InfoResult *)obj;
            if ([infoResult.code isEqualToString:@"0"]) {
                SubmitByWeekModel *weekModel = [[SubmitByWeekModel alloc] init];
                weekModel = (SubmitByWeekModel *)[infoResult extraObj];
                TrainResultViewController *trainVC = [[TrainResultViewController alloc]init];
                trainVC.weekModel = weekModel;
                trainVC.questionModel = _questionModel;
                trainVC.answerArray = _array;
                trainVC.answerArr = _answerArr;
                [self.navigationController pushViewController:trainVC animated:YES];
            }
        } failed:^(id obj) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
    }else if (self.setType == 1){ // 1:训练技巧
        //提交答案-综合训练技巧训练
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [request userSubmitAnswerBySkillWithSId:_sId andTakeTime:TakeTime andAnswerResult:jsonString success:^(id obj) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            InfoResult *infoResult = (InfoResult *)obj;
            if ([infoResult.code isEqualToString:@"0"]) {
                if ([self.sType isEqualToString:@"1"]||[self.sType isEqualToString:@"2"]) {
                    SubmitBySkillModel *skillModel = [[SubmitBySkillModel alloc] init];
                    skillModel = (SubmitBySkillModel *)[infoResult extraObj];
                    TrainResultThreeViewController *trainVC = [[TrainResultThreeViewController alloc]init];
                    trainVC.skillModel = skillModel;
                    trainVC.questionModel = _questionModel;
                    trainVC.answerArray = _array;
                    trainVC.answerArr = _answerArr;
                    if ([self.sType isEqualToString:@"1"]) {
                        trainVC.isAgain = YES;
                        trainVC.sId = _sId;
                        trainVC.skillListModel = _skillModel;
                        trainVC.sType = _sType;
                    }else if ([self.sType isEqualToString:@"2"]){
                        trainVC.isAgain = NO;
                    }
                    [self.navigationController pushViewController:trainVC animated:YES];
                }else if ([self.sType isEqualToString:@"0"]){
                    SubmitBySkillModel *skillModel = [[SubmitBySkillModel alloc] init];
                    skillModel = (SubmitBySkillModel *)[infoResult extraObj];
                    TrainResultFourViewController *trainVC = [[TrainResultFourViewController alloc]init];
                    trainVC.skillModel = skillModel;
                    trainVC.questionModel = _questionModel;
                    trainVC.answerArray = _array;
                    trainVC.answerArr = _answerArr;
                    trainVC.skillListModel = _skillModel;
                    trainVC.type = 0;
                    trainVC.sId = _sId;
                    trainVC.sType = _sType;
                    [self.navigationController pushViewController:trainVC animated:YES];
                }
            }
        } failed:^(id obj) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
    }else if (self.setType == 2){//2:重新训练
        [aCommon iToast:@"重新训练-提交答案"];
    }else if (self.setType == 3){//3:知识点题目列表
        // 1.4.21 提交答案-知识点习题训练
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [request userKSubmitAnswerWithKid:_kId andTakeTime:TakeTime andAnswerResult:jsonString success:^(id obj) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            InfoResult *infoResult = (InfoResult *)obj;
            if ([infoResult.code isEqualToString:@"0"]) {
                SubmitQuestionModel *submitModel = [[SubmitQuestionModel alloc] init];
                submitModel = (SubmitQuestionModel *)[infoResult extraObj];
                TrainResultTwoViewController *submitVC = [[TrainResultTwoViewController alloc]init];
                submitVC.submitModel = submitModel;
                submitVC.questionModel = _questionModel;
                submitVC.answerArray = _array;
                submitVC.kId = _kId;
                submitVC.kName = [UserDefaultsUtils valueWithKey:KNOWLEDGENAME];
                if (_fromType == 0) {
                    submitVC.fromType = 0;
                }else if (_fromType == 1) {
                    submitVC.fromType = 1;
                }
                [self.navigationController pushViewController:submitVC animated:YES];
            }
        } failed:^(id obj) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
    }else if (self.setType == 4){//4:查询大题
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [request userSubmitAnswerByQTypeWithTId:_sId andBigQId:_qId andTakeTime:TakeTime andAnswerResult:jsonString success:^(id obj) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            InfoResult *infoResult = (InfoResult *)obj;
            if ([infoResult.code isEqualToString:@"0"]) {
                SubmitBySkillModel *skillModel = [[SubmitBySkillModel alloc] init];
                skillModel = (SubmitBySkillModel *)[infoResult extraObj];
                TrainResultFourViewController *trainVC = [[TrainResultFourViewController alloc]init];
                trainVC.skillModel = skillModel;
                trainVC.questionModel = _questionModel;
                trainVC.answerArray = _array;
                trainVC.answerArr = _answerArr;
                trainVC.qListModel = _qListModel;
                trainVC.type = 1;
                [self.navigationController pushViewController:trainVC animated:YES];
            }
        } failed:^(id obj) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];

        }];
    }
   
}

- (void)middleBtnClick
{
    [self.view endEditing:YES];
    _isMiddleClick = !_isMiddleClick;
    if (_isMiddleClick) {
        _answerView.hidden = NO;
        [_answerView answerWithTrueOrFalse:(int)_danArr.count and:(int)_tianArr.count and:(int)_yuedanArr.count and:(int)_tingdanArr.count allArr:_answerArr];
    }else{
        _answerView.hidden = YES;
    }
}

- (void)base_navigation_LeftBarButtonPressed
{
    [self.view endEditing:YES];
    [self performSelector:@selector(left) withObject:nil afterDelay:0.7];
    self.view.window.userInteractionEnabled = NO;
}

- (void)left
{
    self.view.window.userInteractionEnabled = YES;
    
    [[SoundTools sharedSoundTools] playSoundWithName:@"ui_warning"];

    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"友情提示" message:@"确定退出训练吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 102;
    [alert show];
}

- (void)base_navigation_RightBarButtonPressed
{
    [self.view endEditing:YES];
    [self performSelector:@selector(right) withObject:nil afterDelay:0.7];
    self.view.window.userInteractionEnabled = NO;
}

- (void)right
{
    self.view.window.userInteractionEnabled = YES;
    _numQuestionCount = 0;
    for (NSString *str in _answerArr) {
        if ([str isEqualToString:@"0"]) {
            _numQuestionCount++;
        }
    }
    if (_numQuestionCount) {
        
        [[SoundTools sharedSoundTools] playSoundWithName:@"ui_warning"];

        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"您还有%d题未答",_numQuestionCount] message:@"还要交卷嘛~" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag = 101;
        [alert show];
    }else{
        [self submitAnswer];
    }
    
}

#pragma mark ---UIAlertViewDelegate----

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex) {
        if (alertView.tag == 101) {
            
            
            [self submitAnswer];
            
            
        }else if (alertView.tag == 102) {
            
            [self removeTimer];
            [self.navigationController popViewControllerAnimated:YES];
            if (bsound) {
                [self.soundplayer stop];
                self.soundplayer=nil;
                bsound = NO;
            }
            
        }else if (alertView.tag == 100){
            
            [self playVideo];
            
        }else if (alertView.tag == 103) {
            //1.4.36 视频播放&再次训练 付费控制
            LearningPlanRequest * request = [[LearningPlanRequest alloc]init];
            [request userPayCCWithVideoId:_videoId source:@"0" success:^(id obj)
             {
                 InfoResult *infoResult = (InfoResult *)obj;
                 if ([infoResult.code isEqualToString:@"0"]) {
                     
                     UserLoginModel *loginModel = [[UserLoginModel alloc] init];
                     loginModel = (UserLoginModel *)[infoResult extraObj];
                     
                     [UserDefaultsUtils saveValue:loginModel.ccAmount forKey:USER_CCAMOUNT];
                     
                     [self playMP4WithVideoId:_videoId videoTitle:_videoTitle imgUrlstring:_imgUrlstring videoURL:_videoURL];
                 }
             } failed:^(id obj) {
                 
             }];
        }
    }
}


#pragma mark ---TingliQuestionViewDelegate---

- (void)tingliQuestionViewDelegateWithButton:(UIView *)tap
{
    PLog(@"播放听力");
    
    ReadingComModel *listmodel = _tingArr[tap.tag];
    _soundIndex = (int)tap.tag;
    
    UIImageView *tingliView = (UIImageView *)tap;
    
    
    RequestCenter *requestCenter = [[RequestCenter alloc] init];
    if ((NSNull *)listmodel.qTitleMediaUrl != [NSNull null]) {
        
        [requestCenter downloadWithURL:[NSURL URLWithString:[listmodel.qTitleMediaUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] progress:^(float percent, NSString *path) {
            
            if (!bsound) {
                [tingliView startAnimating];
            }
            if (percent == 1) {
                if ([_soundUrl isEqualToString:listmodel.qTitleMediaUrl]) {
                    if ( bsound ) {
                        [self.soundplayer stop];
                        [tingliView stopAnimating];
                        bsound = NO;
                    }else{
                        [tingliView startAnimating];//开始播放动画
                        
                        //播放
                        NSURL *fileUrl=[NSURL fileURLWithPath:path];
                        
                        [self initPlayer];
                        NSError *error;
                        self.soundplayer=[[AVAudioPlayer alloc]initWithContentsOfURL:fileUrl error:&error];
                        if (error)
                        {
                            [aCommon iToast:@"请重新获取听力文件"];
                            [tingliView stopAnimating];
                            return;
                        }
                        [self.soundplayer setVolume:1];
                        [self.soundplayer prepareToPlay];
                        [self.soundplayer setDelegate:self];
                        [self.soundplayer play];
                        bsound = YES;
                    }
                }else{
                    if ( bsound ) {
                        [self.soundplayer stop];
                        [tingliView stopAnimating];
                        bsound = NO;
                    }
                    [tingliView startAnimating];//开始播放动画
                    
                    //播放
                    NSURL *fileUrl=[NSURL fileURLWithPath:path];
                    
                    [self initPlayer];
                    NSError *error;
                    self.soundplayer=[[AVAudioPlayer alloc]initWithContentsOfURL:fileUrl error:&error];
                    
                    if (error)
                    {
                        [aCommon iToast:@"请重新获取听力文件"];
                        [tingliView stopAnimating];
                        return;
                    }
                    [self.soundplayer setVolume:1];
                    [self.soundplayer prepareToPlay];
                    [self.soundplayer setDelegate:self];
                    [self.soundplayer play];
                    bsound = YES;
                }
                _soundUrl = listmodel.qTitleMediaUrl;
            }
            
        }];
    }else{
        [aCommon iToast:@"音频文件为空"];
    }
    
    
}

-(void)initPlayer{
    //初始化播放器的时候如下设置
    UInt32 sessionCategory = kAudioSessionCategory_MediaPlayback;
    AudioSessionSetProperty(kAudioSessionProperty_AudioCategory,
                            sizeof(sessionCategory),
                            &sessionCategory);
    
    UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
    AudioSessionSetProperty (kAudioSessionProperty_OverrideAudioRoute,
                             sizeof (audioRouteOverride),
                             &audioRouteOverride);
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    
    //默认情况下扬声器播放
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    [audioSession setActive:YES error:nil];
    audioSession = nil;
}

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    //播放结束后自动结束播放动画
    if (bsound) {
        TingliQuestionView *questionView;
        for (UIView *view in [_myScrollView subviews]) {
            if (view.tag){
                questionView = (TingliQuestionView *)view;
                [questionView.tingLiButton stopAnimating];
            }
        }
        bsound = NO;
    }
    [self.soundplayer stop];
    self.soundplayer=nil;
}

#pragma mark ---TingliQuestionViewDelegate----

- (void)tingliQuestionViewDelegateWithBigImage:(UIView *)tapView
{
    [[SoundTools sharedSoundTools] playSoundWithName:@"ui_click_in"];

    
    PLog(@"点击放大图片===听力");
    UIImageView *imageView = (UIImageView *)tapView;
    PicBrowseViewController *vc = [[PicBrowseViewController alloc] init];
    vc.image = imageView.image;
    [self.navigationController pushViewController:vc animated:NO];
}

//听力播放视频
- (void)tingliQuestionViewDelegateWithPlayVideo:(NSString *)btn
{
    PLog(@"听力播放视频");
    
    _videoId = btn;
    _videoTitle = @"听力播放视频";
    
    [self isReachable];
}

//听力单选
- (void)tingliQuestionViewDelegateWithDanAnswer:(NSString *)answer andTrueOrFalse:(NSString *)judge
{
    [_answerArr replaceObjectAtIndex:_page withObject:judge];
    
    //提交答案
    NSDictionary *page = _tingdanArr[_page-_danArr.count-_tianArr.count-_yuedanArr.count];
    QuestionListModel *data = [page valueForKey:@"title"];
    _choose = [NSMutableArray array];
    [_choose addObject:answer];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:data.qId forKey:@"qId"];
    [dict setValue:_choose forKey:@"options"];
    
    
    [_array replaceObjectAtIndex:_page withObject:dict];
}

//听力填空
- (void)tingliQuestionViewDelegateWithTianAnswer:(NSString *)answer andTrueOrFalse:(NSString *)judge andTag:(int)tag
{
    
    [_answerArr replaceObjectAtIndex:_page withObject:judge];
    
    
    //提交答案
    NSDictionary *page = _tingdanArr[_page-_danArr.count-_tianArr.count-_yuedanArr.count];
    QuestionListModel *data = [page valueForKey:@"title"];
    //    [_tianArray3 replaceObjectAtIndex:tag withObject:answer];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:_array[_page]];
    _tianArray3 = [[NSMutableArray alloc]initWithArray:dict[@"options"]];
    [_tianArray3 replaceObjectAtIndex:tag withObject:answer];
    [dict setValue:data.qId forKey:@"qId"];
    [dict setValue:_tianArray3 forKey:@"options"];
    
    
    [_array replaceObjectAtIndex:_page withObject:dict];
    
}

#pragma mark  ---YueduQuestionViewDelegate----

- (void)yueduQuestionViewDelegateWithBigImage:(UIView *)tapView
{
    
    [[SoundTools sharedSoundTools] playSoundWithName:@"ui_click_in"];

    
    PLog(@"点击方法图片==阅读");
    UIImageView *imageView = (UIImageView *)tapView;
    PicBrowseViewController *vc = [[PicBrowseViewController alloc] init];
    vc.image = imageView.image;
    [self.navigationController pushViewController:vc animated:NO];
}

//阅读播放视频
- (void)yueduQuestionViewDelegateWithPlayVideo:(NSString *)btn
{
    PLog(@"阅读播放视频");
    
    _videoId = btn;
    _videoTitle = @"阅读播放视频";
    //    _imgUrlstring =
    //    _videoURL =
    
    [self isReachable];
}

//阅读单选
- (void)yueduQuestionViewDelegateWithDanAnswer:(NSString *)answer andTrueOrFalse:(NSString *)judge
{
    [_answerArr replaceObjectAtIndex:_page withObject:judge];
    
    //提交答案
    NSDictionary *page = _yuedanArr[_page-_danArr.count-_tianArr.count];
    QuestionListModel *data = [page valueForKey:@"title"];
    _choose = [NSMutableArray array];
    [_choose addObject:answer];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:data.qId forKey:@"qId"];
    [dict setValue:_choose forKey:@"options"];
    
    
    [_array replaceObjectAtIndex:_page withObject:dict];
}

//阅读填空
- (void)yueduQuestionViewDelegateWithTianAnswer:(NSString *)answer andTrueOrFalse:(NSString *)judge andTag:(int)tag
{
    
        [_answerArr replaceObjectAtIndex:_page withObject:judge];
    
    
    //提交答案
    NSDictionary *page = _yuedanArr[_page-_danArr.count-_tianArr.count];
    QuestionListModel *data = [page valueForKey:@"title"];
    
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:_array[_page]];
    _tianArray2 = [[NSMutableArray alloc]initWithArray:dict[@"options"]];
    [_tianArray2 replaceObjectAtIndex:tag withObject:answer];
    [dict setValue:data.qId forKey:@"qId"];
    [dict setValue:_tianArray2 forKey:@"options"];
    
    
    [_array replaceObjectAtIndex:_page withObject:dict];
}

#pragma mark ---QuestionViewDelegate---

- (void)questionViewDelegateWithBigImage:(UIView *)tapView
{
    
    [[SoundTools sharedSoundTools] playSoundWithName:@"ui_click_in"];

    PLog(@"点击放大图片===单选");
    UIImageView *imageView = (UIImageView *)tapView;
    PicBrowseViewController *vc = [[PicBrowseViewController alloc] init];
    vc.image = imageView.image;
    [self.navigationController pushViewController:vc animated:NO];
}

//选择题答案
- (void)questionViewDelegateWithAnswer:(NSString *)answer andTrueOrFalse:(NSString *)judge
{
    [_answerArr replaceObjectAtIndex:_page withObject:judge];
    
    //提交答案
    QuestionListModel *data = _danArr[_page];
    _choose = [NSMutableArray array];
    [_choose addObject:answer];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:data.qId forKey:@"qId"];
    [dict setValue:_choose forKey:@"options"];
    
    
    [_array replaceObjectAtIndex:_page withObject:dict];
}

//播放视频
- (void)questionViewDelegateWithPlayVideo:(NSString *)btn
{
    PLog(@"单选视频");
    
    _videoId = btn;
    _videoTitle = @"单选视频";
    //    _imgUrlstring =
    //    _videoURL =
    
    [self isReachable];
}

#pragma mark  ----TianQuestionViewDelegate----

- (void)tianQuestionViewDelegateWithBigImage:(UIView *)tapView
{
    [[SoundTools sharedSoundTools] playSoundWithName:@"ui_click_in"];

    
    PLog(@"点击放大图片===填空");
    UIImageView *imageView = (UIImageView *)tapView;
    PicBrowseViewController *vc = [[PicBrowseViewController alloc] init];
    vc.image = imageView.image;
    [self.navigationController pushViewController:vc animated:NO];
}

//填空题答案
- (void)tianQuestionViewDelegateWithAnswer:(NSString *)answer andTrueOrFalse:(NSString *)judge andTag:(int)tag
{
   
    [_answerArr replaceObjectAtIndex:_page withObject:judge];
  
    
    //提交答案
    
    QuestionListModel *data = _tianArr[_page-_danArr.count];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:_array[_page]];
    _tianArray1 = [[NSMutableArray alloc]initWithArray:dict[@"options"]];
    [_tianArray1 replaceObjectAtIndex:tag withObject:answer];
    [dict setValue:data.qId forKey:@"qId"];
    [dict setValue:_tianArray1 forKey:@"options"];
    
    
    [_array replaceObjectAtIndex:_page withObject:dict];
    
    NSLog(@"%@",_array);
}

//播放视频
- (void)tianQuestionViewDelegateWithPlayVideo:(NSString *)btn
{
    PLog(@"填空视频");
    
    _videoId = btn;
    _videoTitle = @"填空视频";
    //    _imgUrlstring =
    //    _videoURL =
    
    [self isReachable];
}

#pragma mark - 视频播放（传参）
- (void)playMP4WithVideoId:(NSString *)videoId videoTitle:(NSString *)videoTitle imgUrlstring:(NSString *)imgUrlstring videoURL:(NSString *)videoURL
{
    
    [[SoundTools sharedSoundTools] playSoundWithName:@"ui_click_in"];

    
    DWCustomPlayerViewController *player = [[DWCustomPlayerViewController alloc] init];
    player.videoId = videoId;
    player.videoTitle = videoTitle;
    player.imgUrlstring = imgUrlstring;
    player.videoURL = videoURL;
    player.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:player animated:NO];
    
}

#pragma mark - 判断网络状态
- (void)isReachable
{
    Reachability* reach = [Reachability reachabilityWithHostname:@"www.apple.com"];
    // 判断网络状态
    if (reach.isReachableViaWiFi) { // 有wifi
        NSLog(@"有wifi");
        
        [self playVideo];
        
    } else if (reach.isReachableViaWWAN) { // 没有使用wifi, 使用手机自带网络进行上网
        NSLog(@"使用手机自带网络进行上网");
        
        [[SoundTools sharedSoundTools] playSoundWithName:@"ui_warning"];

        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"友情提示"
                                                        message:@"当前为非Wifi环境，是否继续使用流量播放？使用流量，可能会产生额外费用"
                                                       delegate:nil
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确定", nil];
        alert.delegate = self;
        alert.tag = 100;
        [alert show];
        
    } else { // 没有网络
        NSLog(@"没有网络");
        
        [[SoundTools sharedSoundTools] playSoundWithName:@"ui_warning"];

        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"友情提示"
                                                        message:@"当前没有网络,请检查您的网络状态！"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)playVideo
{
    if ([[UserDefaultsUtils valueWithKey:USER_VIPSTATUS] isEqualToString:@"1"]){
        [self playMP4WithVideoId:_videoId videoTitle:_videoTitle imgUrlstring:_imgUrlstring videoURL:_videoURL];
    }else{
        LearningPlanRequest * request = [[LearningPlanRequest alloc]init];
        [request userqueryVCCNumWithVideoId:_videoId success:^(id obj) {
            InfoResult *infoResult = (InfoResult *)obj;
            if ([infoResult.code isEqualToString:@"0"]) {
                UserLoginModel *model = [[UserLoginModel alloc] init];
                model = (UserLoginModel *)[infoResult extraObj];
                
                if ([model.vCCNum isEqualToString:@"0"]) {
                    [self playMP4WithVideoId:_videoId videoTitle:_videoTitle imgUrlstring:_imgUrlstring videoURL:_videoURL];
                }else{
                    
                    [[SoundTools sharedSoundTools] playSoundWithName:@"ui_warning"];

                    
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"友情提示" message:[NSString stringWithFormat:@"播放此视频需要消耗%@CC币\n确定播放吗?",model.vCCNum] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                    alert.tag = 103;
                    [alert show];
                }
                
            }
        } failed:^(id obj) {
            
        }];
    }
}


#pragma mark ----QuestionAnswerDelegate---
- (void)QuestionAnswerDelegateWithTag:(NSUInteger)tag
{
    _isMiddleClick = !_isMiddleClick;
    if (_isMiddleClick) {
        _answerView.hidden = NO;
    }else{
        _answerView.hidden = YES;
    }
    _page = (int)tag;
    [_myScrollView setContentOffset:CGPointMake(tag*MainScreenSize_W, 0) animated:NO];
//    [self base_changeNavigationTitleWithString:[NSString stringWithFormat:@"%ld/%d",tag+1,_questionAccount] andImage:@"nav_title"];
    [self base_changeNavigationTitleWithString:@"Test online" andSmallTitle:[NSString stringWithFormat:@"%ld-%d",tag+1,_questionAccount]];
    if ((_page+1)> (_danArr.count + _tianArr.count + _yuedanArr.count)) {
        _topicLabel.text = @"听力题";
    }else if ((_page+1)> (_danArr.count + _tianArr.count)){
        int temp = 0;
        int yueCount = _page+1 - (int)_danArr.count - (int)_tianArr.count;
        for (int n = 0; n < _yueArr.count; n ++ ) {
            ReadingComModel *listmodel = _yueArr[n];
            NSDictionary *dict = listmodel.childQuestions;
            if ([dict objectForKey:@"DXT"]) {
                QuestionDataModel *dataModel = [dict objectForKey:@"DXT"];
                if (dataModel.dxt.count) {
                    temp += dataModel.dxt.count;
                }
            }
            if ([dict objectForKey:@"TKT"]) {
                QuestionDataModel *dataModel = [dict objectForKey:@"TKT"];
                if (dataModel.tkt.count) {
                    temp += dataModel.tkt.count;
                }
            }
            if (temp >= yueCount) {
                if ([listmodel.questionType isEqualToString:@"0"]) {
                    _topicLabel.text = @"套题";
                }else {
                    _topicLabel.text = @"阅读理解题";
                }
                break;
            }
        }
    }else if ((_page+1)> _danArr.count){
        _topicLabel.text = @"To fill in the blank";
    }else {
        _topicLabel.text = @"To choose the right answer";
    }
    
}

#pragma mark ---键盘监听---

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    [UIView animateWithDuration:0.5 animations:^{
        _myScrollView.frame = CGRectMake(0.0f,0.0f,MainScreenSize_W,MainScreenSize_H - 114.0f);
    }];
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    [UIView animateWithDuration:0.5 animations:^{
        _myScrollView.frame = CGRectMake(0.0f,129.0f,MainScreenSize_W,MainScreenSize_H - 114.0f);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
