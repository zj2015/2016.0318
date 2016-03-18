//
//  WeekHeadView.m
//  MRobot
//
//  Created by mac on 15/8/22.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "WeekHeadView.h"

static int i = 1;

@implementation WeekHeadView

- (instancetype)initWithFrame:(CGRect)frame withExamModel:(ExamProListModel*)examModel withCount:(NSInteger)count withBlock:(WeekHeadViewBlock)block
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        
        UIImageView *imageViewdiqiu = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f,self.frame.size.width, self.height - 25)];
        [imageViewdiqiu setBackgroundColor:[UIColor blueColor]];
        imageViewdiqiu.image = [UIImage imageNamed:@"diqiu"];
        [self addSubview:imageViewdiqiu];
        
        _block = block;

        _bigTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, MainScreenSize_W, 50)];
        _bigTitleLabel.font = [UIFont systemFontOfSize:17];
#if TARGET_VERSION_LITE ==1
        //target（中考校内版）需要执行的代码
        contentStr= [NSString stringWithFormat:@"当前中考学习计划结束还有 %.02d 周",(int)count-i];
        
#elif TARGET_VERSION_LITE ==2
        //target（中考校外版）需要执行的代码
        contentStr= [NSString stringWithFormat:@"当前中考学习计划结束还有 %.02d 周",(int)count-i];
        
#elif TARGET_VERSION_LITE ==3
        //target（高考校内版）需要执行的代码
        contentStr= [NSString stringWithFormat:@"当前高考学习计划结束还有 %.02d 周",(int)count-i];
        
#elif TARGET_VERSION_LITE ==4
        //target（高考校外版）需要执行的代码
        contentStr= [NSString stringWithFormat:@"当前高考学习计划结束还有 %.02d 周",(int)count-i];
#endif
        
        
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:contentStr];
        [str addAttribute:NSForegroundColorAttributeName value:RgbColor(185.0f, 35.0f, 42.0f) range:NSMakeRange(12, 3)];
        _bigTitleLabel.attributedText = str;
        [_bigTitleLabel setTextColor:[UIColor whiteColor]];
        _bigTitleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_bigTitleLabel];
        
//        _bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, _bigTitleLabel.bottom + 10, MainScreenSize_W, 3)];
//        _bgImageView.backgroundColor = RgbColor(208, 255, 239);
//        [self addSubview:_bgImageView];
//        
//        _progressImageView = [[UIImageView alloc]init];
//        _progressImageView.frame = CGRectMake(0, _bigTitleLabel.bottom + 10, MainScreenSize_W*i/count, 3);
//        _progressImageView.backgroundColor = RgbColor(35.0f, 172.0f, 113.0f);
//        [self addSubview:_progressImageView];
//    
//        _currentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _currentBtn.titleLabel.font = [UIFont boldSystemFontOfSize:9.0f];
//        [_currentBtn setTitleEdgeInsets:UIEdgeInsetsMake(-4.0f, 0.0f, 0.0f, 0.0f)];
//        
//        [_currentBtn setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
//        _currentBtn.frame = CGRectMake(MainScreenSize_W*i/count-30.0f/2, _bigTitleLabel.bottom-10, 30, 18);
//    
//        [_currentBtn setBackgroundImage:[UIImage imageNamed:@"currentPro"] forState:UIControlStateNormal];
//        [self addSubview:_currentBtn];
//        
//        
//        _progressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        
//        _progressBtn.titleLabel.font = [UIFont boldSystemFontOfSize:9.0f];
//        [_progressBtn setTitleEdgeInsets:UIEdgeInsetsMake(-4.0f, 0.0f, 0.0f, 0.0f)];
//        if (count == 0) {
//            [_progressBtn setTitle:@"1/8" forState:UIControlStateNormal];
//            _progressBtn.frame = CGRectMake(MainScreenSize_W*1/8-30.0f/2, _bigTitleLabel.bottom-10.0f, 30.0f, 18.0f);
//        }else{
//            [_progressBtn setTitle:[NSString stringWithFormat:@"%d/%ld",i,count] forState:UIControlStateNormal];
//            _progressBtn.frame = CGRectMake(MainScreenSize_W*i/count-30.0f/2, _bigTitleLabel.bottom-10.0f, 30.0f, 18.0f);
//            
//        }
//        
//        [_progressBtn setBackgroundImage:[UIImage imageNamed:@"currentPro"] forState:UIControlStateNormal];
//        [self addSubview:_progressBtn];
        
        
//        UILabel *lineLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, _progressImageView.bottom, MainScreenSize_W, 5.0f)];
//        lineLabel1.backgroundColor = PView_BGColor;
//        [self addSubview:lineLabel1];
        
        
        
        _forwardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _forwardBtn.frame = CGRectMake(10.0f, 80.0f, 20.0f, 20.0f);
        _forwardBtn.tag = 1;
        [_forwardBtn setImage:[UIImage imageNamed:@"left"] forState:UIControlStateNormal];
        [_forwardBtn addTarget:self action:@selector(clickTheBtn:) forControlEvents:UIControlEventTouchUpInside];
        _forwardBtn.userInteractionEnabled = NO;
        [self addSubview:_forwardBtn];
        
        
         UIButton *  _forwardBtnMask = [UIButton buttonWithType:UIButtonTypeCustom];
        _forwardBtnMask.frame = CGRectMake(10.0f, 80.0f, 60.0f, 60.0f);
        _forwardBtnMask.tag = 1;
//        [_forwardBtn setImage:[UIImage imageNamed:@"left"] forState:UIControlStateNormal];
        [_forwardBtnMask addTarget:self action:@selector(clickTheBtn:) forControlEvents:UIControlEventTouchUpInside];
//        _forwardBtnMask.backgroundColor = [UIColor yellowColor];
        [self addSubview:_forwardBtnMask];

        
        
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
         _backBtn.frame = CGRectMake(MainScreenSize_W - 30.0f, 80.0f, 20.0f, 20.0f);
        _backBtn.tag = 2;
        [_backBtn setImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(clickTheBtn:) forControlEvents:UIControlEventTouchUpInside];
        _backBtn.userInteractionEnabled = NO;
        [self addSubview:_backBtn];
        
        

        UIButton *  _forwardbackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _forwardbackBtn.frame = CGRectMake(MainScreenSize_W - 70.0f, 80.0f,60.0f, 60.0f);
        _forwardbackBtn.tag = 2;
        //        [_forwardBtn setImage:[UIImage imageNamed:@"left"] forState:UIControlStateNormal];
        [_forwardbackBtn addTarget:self action:@selector(clickTheBtn:) forControlEvents:UIControlEventTouchUpInside];
//        _forwardbackBtn.backgroundColor =  [UIColor yellowColor];
        [self addSubview:_forwardbackBtn];

    
        
        
//        _smallTitleLabel.text = [NSString stringWithFormat:@"%@",examModel.teachContent];
        
       
        
//        
//        _smallTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_forwardBtn.right, 77.0f, MainScreenSize_W - _forwardBtn.right * 2, 20.0f)];
//        _smallTitleLabel.textAlignment = NSTextAlignmentCenter;
//        
//        
//        _smallTitleLabel.text = [NSString stringWithFormat:@"%@%@",examModel.weekDesc,examModel.teachContent];
        
//        
//        UIImageView *imageViewSmall = [[UIImageView alloc] initWithFrame:CGRectMake(MainScreenSize_W/3, 50, MainScreenSize_W/3, MainScreenSize_W/3)];
//        imageViewSmall.image = [UIImage imageNamed:@"baiqiu"];
//        
//        [imageViewSmall setBackgroundColor:[UIColor clearColor]];
//        [self addSubview:imageViewSmall];
        
        NSLog(@"main width  = %f",MainScreenSize_W);
        
//        CGFloat progressW = 183*320/414.0f;
//        if (MainScreenSize_W > 320) {
//            progressW = progressW *1.1;
//        }
        CGFloat progressW = self.height - 47;
        progress = [[ProgressView alloc]initWithFrame:CGRectMake(self.frame.size.width/2.0f-progressW/2.0, 47, progressW, progressW)];
        progress.arcFinishColor = [UIColor redColor];
        progress.arcUnfinishColor = [UIColor redColor];
        progress.arcBackColor = [UIColor lightGrayColor];
        progress.alpha = 0.5;
        [self addSubview:progress];
        
        
        
//        WhiteCircle *whiteView = [[WhiteCircle alloc] initWithFrame:CGRectMake((MainScreenSize_W-MainScreenSize_W/2.5)/2, 50, MainScreenSize_W/2.5, MainScreenSize_W/2.5)];
//        [whiteView setBackgroundColor:[UIColor clearColor]];
//        whiteView.alpha = 0.3;
//        [self addSubview:whiteView];
        
//        CGFloat whitex = 10;
//        CGFloat whiteW = progress.width - whitex *2;
//        UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(whitex, whitex, whiteW, whiteW)];
//        whiteView.backgroundColor = [UIColor clearColor];
//        whiteView.layer.cornerRadius = whiteW/2.0;
//        whiteView.layer.masksToBounds = YES;
//        [progress addSubview:whiteView];
        
        
//        
//        UILabel *lineLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, self.height-0.5f, MainScreenSize_W, 0.5f)];
//        lineLabel2.backgroundColor = [UIColor whiteColor];
//        [self addSubview:lineLabel2];
        CGFloat smallW = 90*MainScreenSize_W/414.0f;
        _smallTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/2-smallW/2.0,52.0f, smallW, smallW)];
        [_smallTitleLabel setFont:[UIFont boldSystemFontOfSize:60]];
        if(MainScreenSize_H<560)
        {
            [_smallTitleLabel setFont:[UIFont boldSystemFontOfSize:40]];
//            [_smallTitleLabel setFrame:CGRectMake(_smallTitleLabel.frame.origin.x+5, _smallTitleLabel.frame.origin.y, _smallTitleLabel.frame.size.width, _smallTitleLabel.frame.size.height)];

//            [progress setFrame:CGRectMake(progress.frame.origin.x+10, progress.frame.origin.y-10, progress.frame.size.width*0.9, progress.size.height*0.9)];
            
        }
        [_smallTitleLabel setTextColor:[UIColor redColor]];
        [_smallTitleLabel setBackgroundColor:[UIColor clearColor]];
        _smallTitleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_smallTitleLabel];
        
        
        
        _smallSubTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/2-60*MainScreenSize_W/414.0f,_smallTitleLabel.bottom, 120*MainScreenSize_W/414.0f, 100.0f*MainScreenSize_W/414.0f)];
        [_smallSubTitleLabel setFont:[UIFont boldSystemFontOfSize:18]];
        if(MainScreenSize_H<560)
        {
            [_smallSubTitleLabel setFont:[UIFont boldSystemFontOfSize:14]];
//            [_smallSubTitleLabel setFrame:CGRectMake(_smallSubTitleLabel.frame.origin.x, _smallSubTitleLabel.frame.origin.y-10, _smallSubTitleLabel.frame.size.width, _smallSubTitleLabel.frame.size.height)];
            
        }
        [_smallSubTitleLabel setTextColor:[UIColor grayColor]];
        [_smallSubTitleLabel setBackgroundColor:[UIColor clearColor]];

        _smallTitleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_smallSubTitleLabel];
        
       
//        [_bigTitleLabel setBackgroundColor:[UIColor clearColor]];

        
    }
    return self;
}

- (void)clickTheBtn:(UIButton *)btn
{
    _block((int)btn.tag);
}

- (void)headDataWithModel:(ExamProListModel *)examModel withCount:(int)count withPage:(int)page
{
    if ([examModel.thisWeek isEqualToString:@"1"]) {
        
#if TARGET_VERSION_LITE ==1
        //target（中考校内版）需要执行的代码
        contentStr = [NSString stringWithFormat:@"当前中考学习计划结束还有 %.02d 周",count-page];
        
#elif TARGET_VERSION_LITE ==2
        //target（中考校外版）需要执行的代码
        contentStr = [NSString stringWithFormat:@"当前中考学习计划结束还有 %.02d 周",count-page];
        
#elif TARGET_VERSION_LITE ==3
        //target（高考校内版）需要执行的代码
        contentStr = [NSString stringWithFormat:@"当前高考学习计划结束还有 %.02d 周",count-page];
        
#elif TARGET_VERSION_LITE ==4
        //target（高考校外版）需要执行的代码
        contentStr = [NSString stringWithFormat:@"当前高考学习计划结束还有 %.02d 周",count-page];
#endif
    }
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:contentStr];
    [str addAttribute:NSForegroundColorAttributeName value:RgbColor(185.0f, 35.0f, 42.0f) range:NSMakeRange(12, 3)];
    _bigTitleLabel.attributedText = str;
    
    
    _progressImageView.frame = CGRectMake(0, _bigTitleLabel.bottom + 10, MainScreenSize_W*page/count, 3);
    
    if ([examModel.thisWeek isEqualToString:@"1"]) {
        [_currentBtn setTitle:[NSString stringWithFormat:@"%d",page] forState:UIControlStateNormal];
        _currentBtn.frame = CGRectMake(MainScreenSize_W*page/count-30.0f/2, _bigTitleLabel.bottom-10.0f, 30.0f, 18.0f);
        
        if (_currentBtn.right>MainScreenSize_W) {
            _currentBtn.frame = CGRectMake(MainScreenSize_W-26.0f, _bigTitleLabel.bottom-10.0f, 30.0f, 18.0f);
        }else if (_currentBtn.left < 0){
            _currentBtn.frame = CGRectMake(0.0f, _bigTitleLabel.bottom-10.0f, 30.0f, 18.0f);
        }
    }
    
    [_progressBtn setTitle:[NSString stringWithFormat:@"%d/%d",page,count] forState:UIControlStateNormal];
    _progressBtn.frame = CGRectMake(MainScreenSize_W*page/count-30.0f/2, _bigTitleLabel.bottom-10.0f, 30.0f, 18.0f);
    if (_progressBtn.right>MainScreenSize_W) {
        _progressBtn.frame = CGRectMake(MainScreenSize_W-26.0f, _bigTitleLabel.bottom-10.0f, 30.0f, 18.0f);
    }else if (_progressBtn.left < 0){
        _progressBtn.frame = _progressBtn.frame = CGRectMake(0.0f, _bigTitleLabel.bottom-10.0f, 30.0f, 18.0f);;
    }
    if (_currentBtn.left ==  _progressBtn.left ) {
       [_progressBtn setBackgroundImage:[UIImage imageNamed:@"currentPro"] forState:UIControlStateNormal];
    }else{
        [_progressBtn setBackgroundImage:[UIImage imageNamed:@"progress"] forState:UIControlStateNormal];
    }
    
     _smallTitleLabel.text = [NSString stringWithFormat:@"%d",page];
    NSMutableAttributedString *strSubTitle = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"of %d weeks",count]];
    
    
    [strSubTitle addAttribute:NSForegroundColorAttributeName value:RgbColor(0.0f, 0.0f, 0.0f) range:NSMakeRange(3, 2)];
//    [strSubTitle addAttribute:NSFontAttributeName value:@"bold" range:NSMakeRange(3, 2)];
    _smallSubTitleLabel.attributedText = strSubTitle;
    
    progress.percent = (float)page/(float)count;
//    progress.percent = 0.3;
    [progress setNeedsDisplay];
    
    [_smallSubTitleLabel sizeToFit];
    [_smallSubTitleLabel setLeft:(self.width - _smallSubTitleLabel.width)/2.0];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
