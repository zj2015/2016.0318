//
//  SubmitWrongTViewController.m
//  MRobot
//
//  Created by mac on 15/9/21.
//  Copyright © 2015年 silysolong. All rights reserved.
//

#import "SubmitWrongTViewController.h"
#import "PicBrowseViewController.h"
#import "QuestionDataModel.h"
#import "ReadingComModel.h"
#import "QuestionListModel.h"
#import "SubmitQuestionModel.h"
#import "RequestCenter.h"
@interface SubmitWrongTViewController ()
{
    BOOL _isMiddleClick;
}
@end

@implementation SubmitWrongTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //    [self base_ExtendedLayout];
    
    _answerView = [[QuestionAnswer alloc]initWithFrame:CGRectMake(0, 70, MainScreenSize_W   , MainScreenSize_H)];
    _answerView.backgroundColor = [UIColor whiteColor];
    _answerView.delegate = self;
    _answerView.hidden = YES;
    [self.view addSubview:_answerView];
}

-(void)_prepareUI
{
    _yuedanArr = [NSMutableArray array];
    _tingdanArr = [NSMutableArray array];
    
    _errorCount = (int)_errorIdArray.count;
    QuestionDataModel *questionModel = [[QuestionDataModel alloc] init];
    questionModel = _questionModel;
    [self base_changeNavigationTitleWithString:[NSString stringWithFormat:@"%d/%d",1,_errorCount]  andImage:@"nav_title"];
    _danArr = [NSArray arrayWithArray:questionModel.dxt];
    _tianArr = [NSArray arrayWithArray:questionModel.tkt];
    _yueArr = [NSArray arrayWithArray:questionModel.ydljt];
    _tingArr = [NSArray arrayWithArray:questionModel.tlt];
    
    //阅读理解
    for (int i = 0; i < _yueArr.count; i ++ ) {
        ReadingComModel *listmodel = _yueArr[i];
        NSDictionary *dict = listmodel.childQuestions;
        if ([dict objectForKey:@"DXT"]) {
            QuestionDataModel *dataModel = [dict objectForKey:@"DXT"];
            for (QuestionListModel *arr in dataModel.dxt) {
                NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:arr,@"title",@"0",@"type", nil];
                [_yuedanArr addObject: dict];
            }
        }
        if ([dict objectForKey:@"TKT"]) {
            QuestionDataModel *dataModel = [dict objectForKey:@"TKT"];
            for (QuestionListModel *arr in dataModel.tkt) {
                NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:arr,@"title",@"1",@"type", nil];
                [_yuedanArr addObject: dict];
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
            }
        }
        if ([dict objectForKey:@"TKT"]) {
            QuestionDataModel *dataModel = [dict objectForKey:@"TKT"];
            for (QuestionListModel *arr in dataModel.tkt) {
                NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:arr,@"title",@"1",@"type", nil];
                [_tingdanArr addObject: dict];
            }
        }
        
    }
    
    _questionAccount = (int)_tianArr.count + (int)_danArr.count + (int)_yuedanArr.count + (int)_tingdanArr.count;
    
    [self _prepareView];
    
}

- (void)_prepareView
{
    self.view.backgroundColor = PView_BGColor;
    _topicLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 80, 100, 30)];
    _topicLabel.hidden = YES;
    _topicLabel.textAlignment = NSTextAlignmentLeft;
    _topicLabel.font = [UIFont boldSystemFontOfSize:16];
    _topicLabel.tag = 101;
    [self.view addSubview:_topicLabel];
    
    CGRect rect = CGRectMake(0.0f,_topicLabel.bottom+10,MainScreenSize_W,MainScreenSize_H - _topicLabel.bottom);
    _myScrollView = [[UIScrollView alloc]initWithFrame:rect];
    //题目的个数
    _myScrollView.contentSize= CGSizeMake(MainScreenSize_W*_errorCount, 0);
    _myScrollView.pagingEnabled = YES;
    _myScrollView.delegate = self;
    _myScrollView.tag = 111;
    _myScrollView.showsHorizontalScrollIndicator = NO;
    _myScrollView.showsVerticalScrollIndicator = NO;
    _myScrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_myScrollView];
    
    _titleArr = [NSMutableArray array];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    int i = 0;
    for (NSString * errorId in _errorIdArray) {
        //判断选择题，填空题，听力题,阅读理解
        
        //选择题
        for (QuestionListModel * listModel in _danArr) {
            if ([listModel.qId isEqualToString:errorId]) {
                NSArray *array = [[NSArray alloc]init];
                for (NSDictionary *dict in _optionsArr) {
                    if ([[dict objectForKey:@"qId"] isEqualToString:listModel.qId]) {
                        array = [[NSArray alloc]initWithArray:[dict objectForKey:@"options"]];
                        break;
                    }
                }
                SubmitQuestionView *questionView = [[SubmitQuestionView alloc]initWithFrame:CGRectMake(10 + i*MainScreenSize_W, 0 , MainScreenSize_W - 20, MainScreenSize_H - 114)];
                questionView.only = NO;
                questionView.delegate = self;
                questionView.tag = 0;
                [questionView addDanxuanData:listModel andAnswer:array];
                questionView.backgroundColor = PView_BGColor;
                [_myScrollView addSubview:questionView];
                [_titleArr addObject:@"选择题"];
                break;
            }
        }
        
        // 填空题
        for (QuestionListModel *listModel in _tianArr) {
            if ([listModel.qId isEqualToString:errorId]) {
                NSArray *array = [[NSArray alloc]init];
                for (NSDictionary *dict in _optionsArr) {
                    if ([[dict objectForKey:@"qId"] isEqualToString:listModel.qId]) {
                        array = [[NSArray alloc]initWithArray:[dict objectForKey:@"options"]];
                        break;
                    }
                }
                SubmitTianQuestionView *questionView = [[SubmitTianQuestionView alloc]initWithFrame:CGRectMake(10 + i*MainScreenSize_W, 0 , MainScreenSize_W - 20, MainScreenSize_H - 114)];
                [questionView addTianKongData:listModel andAnswer:array];
                questionView.delegate = self;
                questionView.tag = 0;
                questionView.backgroundColor = PView_BGColor;
                [_myScrollView addSubview:questionView];
                [_titleArr addObject:@"填空题"];
                break;
            }
        }
        
        //阅读理解题
        int yue = 0;
        int m = 0;
        for (ReadingComModel * listModel in _yueArr) {
            NSDictionary *dict = listModel.childQuestions;
            if ([dict objectForKey:@"DXT"]) {
                QuestionDataModel *dataModel = [dict objectForKey:@"DXT"];
                if (dataModel.dxt.count) {
                    yue += dataModel.dxt.count;
                }
            }
            if ([dict objectForKey:@"TKT"]) {
                QuestionDataModel *dataModel = [dict objectForKey:@"TKT"];
                if (dataModel.tkt.count) {
                    yue += dataModel.tkt.count;
                }
            }
            for (; m < yue ; m ++) {
                NSDictionary *dicts = _yuedanArr[m];
                QuestionListModel *listModel2 = [dicts valueForKey:@"title"];
                if ([listModel2.qId isEqualToString:errorId]) {
                    NSArray *array = [[NSArray alloc]init];
                    for (NSDictionary *dict in _optionsArr) {
                        if ([[dict objectForKey:@"qId"] isEqualToString:listModel2.qId]) {
                            array = [[NSArray alloc] initWithArray:[dict objectForKey:@"options"]];
                            break;
                        }
                    }
                    SubmitYueduQuestionView *questionView = [[SubmitYueduQuestionView alloc]initWithFrame:CGRectMake(10 + i*MainScreenSize_W, 0 , MainScreenSize_W - 20, MainScreenSize_H - 114)];
                    [questionView addYueDuData:listModel withPage:dicts andAnswer:array];
                    questionView.delegate = self;
                    questionView.tag = 0;
                    questionView.backgroundColor = PView_BGColor;
                    [_myScrollView addSubview:questionView];
                    [_titleArr addObject:@"阅读理解题"];
                    break;
                }
            }
        }
        
        //听力题
        int temp = 0;
        int ting = 0;
        int n = 0;
        for (ReadingComModel * listModel in _tingArr) {
            NSDictionary *dict = listModel.childQuestions;
            if ([dict objectForKey:@"DXT"]) {
                QuestionDataModel *dataModel = [dict objectForKey:@"DXT"];
                if (dataModel.dxt.count) {
                    ting += dataModel.dxt.count;
                }
            }
            if ([dict objectForKey:@"TKT"]) {
                QuestionDataModel *dataModel = [dict objectForKey:@"TKT"];
                if (dataModel.tkt.count) {
                    ting += dataModel.tkt.count;
                }
            }
            for (; n < ting ; n ++) {
                NSDictionary *dicts = _tingdanArr[n];
                QuestionListModel *listModels = [dicts valueForKey:@"title"];
                if ([listModels.qId isEqualToString:errorId]) {
                    NSArray *array = [[NSArray alloc]init];
                    for (NSDictionary *dict in _optionsArr) {
                        if ([[dict objectForKey:@"qId"] isEqualToString:listModels.qId]) {
                            array = [[NSArray alloc]initWithArray:[dict objectForKey:@"options"]];
                            break;
                        }
                    }
                    SubmitTingliQuestionView *questionView = [[SubmitTingliQuestionView alloc]initWithFrame:CGRectMake(10 + i*MainScreenSize_W, 0 , MainScreenSize_W - 20, MainScreenSize_H - 114)];
                    questionView.tag = i+1;
                    [questionView addTingLiData:listModel withPage:dicts withIndex:temp andAnswer:array];
                    questionView.delegate = self;
                    questionView.backgroundColor = PView_BGColor;
                    [_myScrollView addSubview:questionView];
                    [_titleArr addObject:@"听力题"];
                    break;
                }
            }
            temp ++ ;
        }
        
        i ++;
    }
    _page = _location - 1;
    [_myScrollView setContentOffset:CGPointMake(_page*MainScreenSize_W, 0) animated:NO];
    [self base_changeNavigationTitleWithString:[NSString stringWithFormat:@"%d/%d",_page+1,_errorCount]  andImage:@"nav_title"];
    
    _topicLabel.text = _titleArr[_page];

    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

#pragma mark --UIScrollViewDelegate--

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.tag == 111) {
        [self.view endEditing:YES];
    }
    
    _page = (scrollView.contentOffset.x+MainScreenSize_W*0.5)/MainScreenSize_W;
    [self base_changeNavigationTitleWithString:[NSString stringWithFormat:@"%d/%d",_page+1,_errorCount]  andImage:@"nav_title"];
    _topicLabel.text = _titleArr[_page];
    
    if ([self.soundplayer isPlaying]) {
        [self.soundplayer stop];
        bsound = NO;
    }
    
    if ([_topicLabel.text isEqualToString:@"听力题"]) {
        int temp = 0;
        int ting = 0;
        int n = 0;
        for (ReadingComModel * listModel in _tingArr) {
            NSDictionary *dict = listModel.childQuestions;
            if ([dict objectForKey:@"DXT"]) {
                QuestionDataModel *dataModel = [dict objectForKey:@"DXT"];
                if (dataModel.dxt.count) {
                    ting += dataModel.dxt.count;
                }
            }
            if ([dict objectForKey:@"TKT"]) {
                QuestionDataModel *dataModel = [dict objectForKey:@"TKT"];
                if (dataModel.tkt.count) {
                    ting += dataModel.tkt.count;
                }
            }
            for (; n < ting ; n ++) {
                NSDictionary *dicts = _tingdanArr[n];
                QuestionListModel *listModels = [dicts valueForKey:@"title"];
                if ([listModels.qId isEqualToString:_errorIdArray[_page]]) {
                    
                    SubmitTingliQuestionView *questionView;
                    for (UIView *view in [scrollView subviews]) {
                        if (view.tag){
                            questionView = (SubmitTingliQuestionView *)view;
                            if (bsound) {
                                if ([_soundUrl isEqualToString:listModel.qTitleMediaUrl]) {
                                    
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
            temp ++ ;
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
        SubmitTingliQuestionView *questionView;
        for (UIView *view in [self.view subviews]) {
            if (view.tag!=101){
                questionView = (SubmitTingliQuestionView *)view;
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

#pragma mark ---SubmitQuestionViewDelegate---

- (void)submitQuestionViewDelegateWithBigImage:(UIView *)tapView
{
    [[SoundTools sharedSoundTools] playSoundWithName:@"ui_click_in"];

    
    PLog(@"点击放大图片===单选");
    UIImageView *imageView = (UIImageView *)tapView;
    PicBrowseViewController *vc = [[PicBrowseViewController alloc] init];
    vc.image = imageView.image;
    [self.navigationController pushViewController:vc animated:NO];
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
    [self base_changeNavigationTitleWithString:[NSString stringWithFormat:@"%ld/%d",tag+1,_errorCount] andImage:@"nav_title"];
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
