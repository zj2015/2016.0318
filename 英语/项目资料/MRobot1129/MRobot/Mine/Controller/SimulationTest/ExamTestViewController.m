//
//  ExamTestViewController.m
//  MRobot
//
//  Created by mac on 15/9/11.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "ExamTestViewController.h"
#import "QuestionDataModel.h"
#import "ReadingComModel.h"
#import "QuestionListModel.h"
#import "SubmitQuestionModel.h"
#import "SubmitByPaperModel.h"
#import "RequestCenter.h"
#import "PicBrowseViewController.h"
#import "SBJSON.h"
#import "SubmitTestViewController.h"

@interface ExamTestViewController ()
{
    BOOL _isMiddleClick;
}
@property (strong, nonatomic) QuestionDataModel *questionModel;
@property (strong,nonatomic)NSTimer *timer;

@end

@implementation ExamTestViewController

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
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    LearningPlanRequest *request = [[LearningPlanRequest  alloc]init];
//    1.4.17 试卷题目列表
    [request userQuestionListByPaperWithPaperId:_paperId success:^(id obj) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
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
    } failed:^(id obj) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (void)_prepareView
{
    if (_questionAccount) {
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MainScreenSize_W, 40)];
        bgView.backgroundColor = PView_BGColor;
        [self.view addSubview:bgView];
        
        _topicLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 30)];
        _topicLabel.hidden = YES;
        _topicLabel.textAlignment = NSTextAlignmentLeft;
        _topicLabel.font = [UIFont boldSystemFontOfSize:16];
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
        }else{
            _topicLabel.text = @"听力题";
        }
        [bgView addSubview:_topicLabel];
        
        _timeView = [[UIImageView alloc]initWithFrame:CGRectMake(MainScreenSize_W - 120 , 18 , 15, 15)];
        _timeView.image = [UIImage imageNamed:@"clock"];
        [bgView addSubview:_timeView];
        
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(_timeView.right + 5, 15, 100, 20)];
        _timeLabel.text = @"00时00分00秒";
        _timeLabel.textColor = [UIColor grayColor];
        _timeLabel.font = [UIFont boldSystemFontOfSize:12];
        _time = _timeNumber;
        [bgView addSubview:_timeLabel];
        
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
        
        _answerView = [[ExamAnswerView alloc]initWithFrame:CGRectMake(0, 64, MainScreenSize_W, MainScreenSize_H - 64)];
        _answerView.backgroundColor = [UIColor whiteColor];
        _answerView.userInteractionEnabled = YES;
        _answerView.delegate = self;
        _answerView.hidden = YES;
        [self.view addSubview:_answerView];
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        for (int i = 0; i < _questionAccount; i ++) {
            
            //判断选择题，填空题，听力题,阅读理解
            if ((i+1)> (_danArr.count + _tianArr.count + _yuedanArr.count)) {
                //听力题
                SimuHearingView *questionView = [[SimuHearingView alloc]initWithFrame:CGRectMake(10 + i*MainScreenSize_W, 0 , MainScreenSize_W - 20, MainScreenSize_H - 114)];
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
                        [questionView addTingLiData:_tingArr[o] withPage:_tingdanArr[m] withIndex:o];
                        break;
                    }
                }
                questionView.delegate = self;
                myPage ++ ;
                questionView.backgroundColor = PView_BGColor;
                [_myScrollView addSubview:questionView];
                m ++;
            }else if ((i+1)> (_danArr.count + _tianArr.count)){
                //阅读理解题
                SimuReadingView *questionView = [[SimuReadingView alloc]initWithFrame:CGRectMake(10 + i*MainScreenSize_W, 0 , MainScreenSize_W - 20, MainScreenSize_H - 114)];
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
            }else if ((i+1)> _danArr.count){
                //填空题
                SimuBlanksView *questionView = [[SimuBlanksView alloc]initWithFrame:CGRectMake(10 + i*MainScreenSize_W, 0 , MainScreenSize_W - 20, MainScreenSize_H - 114)];
                [questionView addTianKongData:_tianArr[j]];
                questionView.delegate = self;
                questionView.tag = 0;
                questionView.backgroundColor = PView_BGColor;
                myPage ++ ;
                [_myScrollView addSubview:questionView];
                j ++;
                
            }else {
                //选择题
                SimuTheRadioView *questionView = [[SimuTheRadioView alloc]initWithFrame:CGRectMake(10 + i*MainScreenSize_W, 0 , MainScreenSize_W - 20, MainScreenSize_H - 114)];
                questionView.delegate = self;
                questionView.tag = 0;
                [questionView addDanxuanData:_danArr[i]];
                questionView.backgroundColor = PView_BGColor;
                myPage ++ ;
                [_myScrollView addSubview:questionView];
            }
            
            
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self addTimer];
        [self performSelector:@selector(titles) withObject:self afterDelay:0.3];
    }else {
        [aCommon iToast:@"没有数据"];
    }
    self.view.backgroundColor = PView_BGColor;
}

- (void)titles
{
    [self base_changeNavigationTitleWithString:[NSString stringWithFormat:@"%d/%d",1,_questionAccount] andImage:@"nav_title"];
    [self base_createRightNavigationBarButtonWithFrontImage:@"more2" andSelectedImageName:@"more2" andBackGroundImageName:@"more2" andTitle:@"交卷" andSize:CGSizeMake(40, 30)];
}

-(void)addTimer
{
    _timer=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(nextTime) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
}

-(void)removeTimer
{
    [self.timer invalidate];
    self.timer=nil;
}

-(void)nextTime
{
    _timeNumber++;
    int hour = _timeNumber/3600.0;
    int min = (int)_timeNumber%3600/60;
    int temp = (int)_timeNumber%3600%60;
    _timeLabel.text = [NSString stringWithFormat:@"%02d时%02d分%02d秒",hour,min,temp];
    
}

#pragma mark --UIScrollViewDelegate--
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
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
        [self base_changeNavigationTitleWithString:[NSString stringWithFormat:@"%d/%d",_page+1,_questionAccount] andImage:@"nav_title"];
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
                if (temp>oral) {
                    
                    SimuHearingView *questionView;
                    for (UIView *view in [scrollView subviews]) {
                        if (view.tag){
                            questionView = (SimuHearingView *)view;
                            
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
    NSString *TakeTime = [NSString stringWithFormat:@"%.0f",_timeNumber*1000.0];
    
    [_answerDict setValue:_array forKey:@"result"];
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    NSString *jsonString = [writer stringWithObject:_answerDict];
    jsonString = [jsonString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self removeTimer];
    if (bsound) {
        [self.soundplayer stop];
        self.soundplayer=nil;
        bsound = NO;
    }
    
    // 1.4.18 提交答案-试卷
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    LearningPlanRequest *request = [[LearningPlanRequest alloc] init];
    [request userSubmitAnswerByPaperWithPaperId:_paperId andTakeTime:TakeTime andAnswerResult:jsonString success:^(id obj) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        InfoResult *infoResult = (InfoResult *)obj;
        if ([infoResult.code isEqualToString:@"0"]) {
            SubmitByPaperModel *paperModel = [[SubmitByPaperModel alloc] init];
            paperModel = (SubmitByPaperModel *)[infoResult extraObj];
            
            SubmitTestViewController * submitVC = [[SubmitTestViewController alloc]init];
            submitVC.score = paperModel.score;
            
            NSMutableArray *arr = [[NSMutableArray alloc]init];
            if (_danArr.count) {
                [arr addObject:@{@"0":@"选择题",
                                 @"1":_danArr}];
            }
            if (_tianArr.count) {
                [arr addObject:@{@"0":@"填空题",
                                 @"1":_tianArr}];
            }
            if (_yuedanArr.count) {
                [arr addObject:@{@"0":@"阅读理解",
                                 @"1":_yuedanArr}];
            }
            if (_tingdanArr.count) {
                [arr addObject:@{@"0":@"听力题",
                                 @"1":_tingdanArr}];
            }
            
            submitVC.questionArr = arr;
            submitVC.answerArr = _array;
            submitVC.answerTrueArr = _answerArr;
            submitVC.submitTitle = _submitTitle;
            submitVC.questionModel = _questionModel;
            [self.navigationController pushViewController:submitVC animated:YES];
            
        }
    } failed:^(id obj) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
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

    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"友情提示" message:@"确定退出模拟考试吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
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
    if (alertView.tag == 101) {
        if (buttonIndex) {
            
            [self submitAnswer];
            
        }
    }else if (alertView.tag == 102) {
        if (buttonIndex) {
            [self removeTimer];
            [self.navigationController popViewControllerAnimated:YES];
            if (bsound) {
                [self.soundplayer stop];
                self.soundplayer=nil;
                bsound = NO;
            }
        }
    }
}

#pragma mark ---SimuTheRadioViewDelegate---

- (void)simuTheRadioViewDelegateWithPlayVideo:(NSString *)btn
{
    // 播放视频 无
}

- (void)simuTheRadioViewDelegateWithBigImage:(UIView *)tapView
{
    
    [[SoundTools sharedSoundTools] playSoundWithName:@"ui_click_in"];

    
    PLog(@"点击放大图片===单选");
    UIImageView *imageView = (UIImageView *)tapView;
    PicBrowseViewController *vc = [[PicBrowseViewController alloc] init];
    vc.image = imageView.image;
    [self.navigationController pushViewController:vc animated:NO];
}

//选择题答案
- (void)simuTheRadioViewDelegateWithAnswer:(NSString *)answer andTrueOrFalse:(NSString *)judge
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

#pragma mark  ----SimuBlanksViewDelegate----

- (void)simuBlanksViewDelegateWithPlayVideo:(NSString *)btn
{
    // 无视频按钮
}

- (void)simuBlanksViewDelegateWithBigImage:(UIView *)tapView
{
    [[SoundTools sharedSoundTools] playSoundWithName:@"ui_click_in"];

    PLog(@"点击放大图片===填空");
    UIImageView *imageView = (UIImageView *)tapView;
    PicBrowseViewController *vc = [[PicBrowseViewController alloc] init];
    vc.image = imageView.image;
    [self.navigationController pushViewController:vc animated:NO];
}

//填空题答案
- (void)simuBlanksViewDelegateWithAnswer:(NSString *)answer andTrueOrFalse:(NSString *)judge andTag:(int)tag
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
}


#pragma mark ---SimuHearingViewDelegate----

- (void)tingliQuestionViewDelegateWithPlayVideo:(NSString *)btn
{
    // 播放视频 无
}


- (void)simuHearingViewDelegateWithButton:(UIView *)tap
{
    PLog(@"播放听力");
    
    ReadingComModel *listmodel = _tingArr[tap.tag];
    _soundIndex = (int)tap.tag;
    
    UIImageView *tingliView = (UIImageView *)tap;
    
    
    RequestCenter *requestCenter = [[RequestCenter alloc] init];
    if ((NSNull *)listmodel.qTitleMediaUrl != [NSNull null]) {
        [requestCenter downloadWithURL:[NSURL URLWithString:[listmodel.qTitleMediaUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] progress:^(float percent, NSString *path) {
            PLog(@"percent = %f",percent);
            PLog(@"path = %@",path);
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
        SimuHearingView *questionView;
        for (UIView *view in [_myScrollView subviews]) {
            if (view.tag){
                questionView = (SimuHearingView *)view;
                [questionView.tingLiButton stopAnimating];
            }
        }
        bsound = NO;
    }
    [self.soundplayer stop];
    self.soundplayer=nil;
}

- (void)simuHearingViewDelegateWithBigImage:(UIView *)tapView
{
    
    [[SoundTools sharedSoundTools] playSoundWithName:@"ui_click_in"];

    
    PLog(@"点击放大图片===听力");
    UIImageView *imageView = (UIImageView *)tapView;
    PicBrowseViewController *vc = [[PicBrowseViewController alloc] init];
    vc.image = imageView.image;
    [self.navigationController pushViewController:vc animated:NO];
}

//听力单选
- (void)simuHearingViewDelegateWithDanAnswer:(NSString *)answer andTrueOrFalse:(NSString *)judge
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
- (void)simuHearingViewDelegateWithTianAnswer:(NSString *)answer andTrueOrFalse:(NSString *)judge andTag:(int)tag
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

#pragma mark  ---SimuReadingViewDelegate----

- (void)simuReadingViewDelegateWithBigImage:(UIView *)tapView
{
    [[SoundTools sharedSoundTools] playSoundWithName:@"ui_click_in"];

    
    PLog(@"点击方法图片==阅读");
    UIImageView *imageView = (UIImageView *)tapView;
    PicBrowseViewController *vc = [[PicBrowseViewController alloc] init];
    vc.image = imageView.image;
    [self.navigationController pushViewController:vc animated:NO];
}

//阅读单选
- (void)simuReadingViewDelegateWithDanAnswer:(NSString *)answer andTrueOrFalse:(NSString *)judge
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
- (void)simuReadingViewDelegateWithTianAnswer:(NSString *)answer andTrueOrFalse:(NSString *)judge andTag:(int)tag
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

#pragma mark ---ExamAnswerViewDelegate---
// 答案
- (void)ExamAnswerViewDelegateWithTag:(NSUInteger)tag
{
    _isMiddleClick = !_isMiddleClick;
    if (_isMiddleClick) {
        _answerView.hidden = NO;
    }else{
        _answerView.hidden = YES;
    }
    _page = (int)tag;
    [_myScrollView setContentOffset:CGPointMake(tag*MainScreenSize_W, 0) animated:NO];
    [self base_changeNavigationTitleWithString:[NSString stringWithFormat:@"%ld/%d",tag+1,_questionAccount] andImage:@"nav_title"];
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
        _topicLabel.text = @"填空题";
    }else {
        _topicLabel.text = @"选择题";
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
        _myScrollView.frame = CGRectMake(0.0f,114.0f,MainScreenSize_W,MainScreenSize_H - 114.0f);
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
