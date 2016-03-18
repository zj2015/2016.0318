//
//  QuestionAnswer.m
//  ECenter
//
//  Created by mac on 15/6/8.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "QuestionAnswer.h"

@implementation QuestionAnswer

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        _bgScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _bgScrollView.showsHorizontalScrollIndicator = NO;
        _bgScrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:_bgScrollView];
        
        _normalLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 30, 20)];
        _normalLabel1.font = [UIFont boldSystemFontOfSize:14];
        _normalLabel1.text = @"答对";
        [_bgScrollView addSubview:_normalLabel1];
        
        _trueLabel = [[UILabel alloc]initWithFrame:CGRectMake(_normalLabel1.right, 20, 40, 20)];
        _trueLabel.font = [UIFont boldSystemFontOfSize:14];
        _trueLabel.textAlignment = NSTextAlignmentCenter;
        _trueLabel.backgroundColor = [UIColor clearColor];
        _trueLabel.textColor = PView_GreenColor;
        [_bgScrollView addSubview:_trueLabel];
        
        _normalLabel1s = [[UILabel alloc]initWithFrame:CGRectMake(_trueLabel.right, 20, 30, 20)];
        _normalLabel1s.font = [UIFont boldSystemFontOfSize:14];
        _normalLabel1s.text = @"答错";
        [_bgScrollView addSubview:_normalLabel1s];
        
        _falseLabel = [[UILabel alloc]initWithFrame:CGRectMake(_normalLabel1s.right, 20, 40, 20)];
        _falseLabel.font = [UIFont boldSystemFontOfSize:14];
        _falseLabel.textAlignment = NSTextAlignmentCenter;
        _falseLabel.backgroundColor = [UIColor clearColor];
        _falseLabel.textColor = PView_RedColor;
        [_bgScrollView addSubview:_falseLabel];
        
        _normalLabel1d = [[UILabel alloc]initWithFrame:CGRectMake(_falseLabel.right, 20, 30, 20)];
        _normalLabel1d.font = [UIFont boldSystemFontOfSize:14];
        _normalLabel1d.text = @"未答";
        [_bgScrollView addSubview:_normalLabel1d];
        
        _noneLabel = [[UILabel alloc]initWithFrame:CGRectMake(_normalLabel1d.right, 20, 40, 20)];
        _noneLabel.font = [UIFont boldSystemFontOfSize:14];
        _noneLabel.textAlignment = NSTextAlignmentCenter;
        _noneLabel.backgroundColor = [UIColor clearColor];
        _noneLabel.textColor = [UIColor grayColor];
        [_bgScrollView addSubview:_noneLabel];
        
        _normalLabel2 = [[UILabel alloc]initWithFrame:CGRectZero];
        _normalLabel2.font = [UIFont boldSystemFontOfSize:14];
        _normalLabel2.text = @"选择题";
        [_bgScrollView addSubview:_normalLabel2];
        
        _normalLabel3 = [[UILabel alloc]initWithFrame:CGRectZero];
        _normalLabel3.font = [UIFont boldSystemFontOfSize:14];
        _normalLabel3.text = @"填空题";
        [_bgScrollView addSubview:_normalLabel3];
        
        _normalLabel4 = [[UILabel alloc]initWithFrame:CGRectZero];
        _normalLabel4.font = [UIFont boldSystemFontOfSize:14];
        _normalLabel4.text = @"阅读理解题";
        [_bgScrollView addSubview:_normalLabel4];
        
        _normalLabel5 = [[UILabel alloc]initWithFrame:CGRectZero];
        _normalLabel5.font = [UIFont boldSystemFontOfSize:14];
        _normalLabel5.text = @"听力题";
        [_bgScrollView addSubview:_normalLabel5];
        
    }
    return self;
}

- (void)answerWithTrueOrFalse:(int)danxuan and:(int)tiankong and:(int)yuedu and:(int)tingli allArr:(NSArray *)arr
{
    int trues = 0;
    int falses = 0;
    int normals = 0;
    
    int totalColumns = 8;
    CGFloat answerW = 35*SIZE_TIMES;
    CGFloat answerH = 35*SIZE_TIMES;
    CGFloat marginX = (MainScreenSize_W - totalColumns * answerW) / (totalColumns + 1)-2;
    CGFloat marginY = 10;
    int i = 0;
    UILabel *label = nil;
    
    if (danxuan) {
        _normalLabel2.frame = CGRectMake(10, _normalLabel1.bottom+30, MainScreenSize_W -20, 20);
    }

    //       选择题
    for (; i < danxuan; i ++ ) {
        int row=i/8;
        int col=i%8;
        CGFloat answerX = marginX+5 + col * (answerW + marginX);
        CGFloat answerY = 20 + row * (answerH + marginY);
        label = [[UILabel alloc]initWithFrame:CGRectMake( answerX, answerY+ _normalLabel2.bottom, answerW,answerH)];
        label.tag = i;
        label.layer.cornerRadius = 8.0;
        label.layer.masksToBounds = YES;
        label.text = [NSString stringWithFormat:@"%d",i + 1];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont boldSystemFontOfSize:17];
        if ([arr[i] isEqual:@"0"]) {
            label.backgroundColor = PView_LGrayColor;
            normals ++;
        }else if ([arr[i] isEqual:@"2"]) {
            label.backgroundColor = PView_RedColor;
            falses ++;
        }else {
            label.backgroundColor = PView_GreenColor;
            trues++;
        }
        label.textAlignment = NSTextAlignmentCenter;
        label.userInteractionEnabled = YES;
        [_bgScrollView addSubview:label];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseWhatTitle:)];
        [label addGestureRecognizer:tap];
        
        _bgScrollView.contentSize= CGSizeMake(0, label.bottom + 50);
    }
    
    if (danxuan) {
        _normalLabel2.frame = CGRectMake(10, _normalLabel1.bottom+30, MainScreenSize_W -20, 20);
        if (tiankong) {
            _normalLabel3.frame = CGRectMake(10, label.bottom+20, MainScreenSize_W -20, 20);
        }
    }else{
        if (tiankong) {
            _normalLabel3.frame = CGRectMake(10, _normalLabel1.bottom+30, MainScreenSize_W -20, 20);
        }
    }

    //填空题
    int j = 0;
    UILabel *label2 = nil;
    for (; j < tiankong; j ++ ) {
        int row=j/8;
        int col=j%8;
        CGFloat answerX = marginX+5 + col * (answerW + marginX);
        CGFloat answerY = 20 + row * (answerH + marginY);
        label2 = [[UILabel alloc]initWithFrame:CGRectZero];
        label2.frame = CGRectMake( answerX, answerY+_normalLabel3.bottom, answerW,answerH);
        label2.text = [NSString stringWithFormat:@"%d",j + i + 1];
        label2.textColor = [UIColor whiteColor];
        label2.font = [UIFont boldSystemFontOfSize:17];
        if ([arr[j+i] isEqual:@"0"]) {
            label2.backgroundColor = PView_LGrayColor;
            normals ++;
        }else if ([arr[j+i] isEqual:@"2"]) {
            label2.backgroundColor = PView_RedColor;
            falses ++;
        }else {
            label2.backgroundColor = PView_GreenColor;
            trues ++;
        }
        label2.tag = j+i;
        label2.layer.cornerRadius = 8.0;
        label2.layer.masksToBounds = YES;
        label2.userInteractionEnabled = YES;
        label2.textAlignment = NSTextAlignmentCenter;
        [_bgScrollView addSubview:label2];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseWhatTitle:)];
        [label2 addGestureRecognizer:tap];
        
        _bgScrollView.contentSize= CGSizeMake(0, label2.bottom + 50);
    }
    
    if (danxuan) {
        _normalLabel2.frame = CGRectMake(10, _normalLabel1.bottom+30, MainScreenSize_W -20, 20);
        if (tiankong) {
            _normalLabel3.frame = CGRectMake(10, label.bottom+20, MainScreenSize_W -20, 20);
            if (yuedu) {
                _normalLabel4.frame = CGRectMake(10, label2.bottom+20, MainScreenSize_W -20, 20);
            }
        }else{
            if (yuedu) {
                _normalLabel4.frame = CGRectMake(10, label.bottom+20, MainScreenSize_W -20, 20);
            }
        }
    }else{
        if (tiankong) {
            _normalLabel3.frame = CGRectMake(10, _normalLabel1.bottom+30, MainScreenSize_W -20, 20);
            if (yuedu) {
                _normalLabel4.frame = CGRectMake(10, label2.bottom+20, MainScreenSize_W -20, 20);
            }
        }else{
            if (yuedu) {
                _normalLabel4.frame = CGRectMake(10, _normalLabel1.bottom+30, MainScreenSize_W -20, 20);
            }
        }
    }
    
    //阅读理解题
    int m = 0;
    UILabel *label3 = nil;
    for (; m < yuedu; m ++ ) {
        int row=m/8;
        int col=m%8;
        CGFloat answerX = marginX+5 + col * (answerW + marginX);
        CGFloat answerY = 20 + row * (answerH + marginY);
        label3 = [[UILabel alloc]initWithFrame:CGRectZero];
        label3.frame = CGRectMake( answerX, answerY+_normalLabel4.bottom, answerW,answerH);
        label3.text = [NSString stringWithFormat:@"%d",m + j + i+ 1];
        label3.textColor = [UIColor whiteColor];
        label3.font = [UIFont boldSystemFontOfSize:17];
        if ([arr[m+j+i] isEqual:@"0"]) {
            label3.backgroundColor = PView_LGrayColor;
            normals ++;
        }else if ([arr[m+j+i] isEqual:@"2"]) {
            label3.backgroundColor = PView_RedColor;
            falses ++;
        }else {
            label3.backgroundColor = PView_GreenColor;
            trues ++;
        }
        label3.tag = m+j+i;
        label3.layer.cornerRadius = 8.0;
        label3.layer.masksToBounds = YES;
        label3.userInteractionEnabled = YES;
        label3.textAlignment = NSTextAlignmentCenter;
        [_bgScrollView addSubview:label3];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseWhatTitle:)];
        [label3 addGestureRecognizer:tap];
        
        _bgScrollView.contentSize= CGSizeMake(0, label3.bottom + 50);
    }
    
    if (danxuan) {
        _normalLabel2.frame = CGRectMake(10, _normalLabel1.bottom+30, MainScreenSize_W -20, 20);
        if (tiankong) {
            _normalLabel3.frame = CGRectMake(10, label.bottom+20, MainScreenSize_W -20, 20);
            if (yuedu) {
                _normalLabel4.frame = CGRectMake(10, label2.bottom+20, MainScreenSize_W -20, 20);
                if (tingli) {
                    _normalLabel5.frame = CGRectMake(10, label3.bottom+20, MainScreenSize_W -20, 20);
                }
            }else{
                if (tingli) {
                    _normalLabel5.frame = CGRectMake(10, label2.bottom+20, MainScreenSize_W -20, 20);
                }
            }
        }else{
            if (yuedu) {
                _normalLabel4.frame = CGRectMake(10, label.bottom+20, MainScreenSize_W -20, 20);
                if (tingli) {
                    _normalLabel5.frame = CGRectMake(10, label3.bottom+20, MainScreenSize_W -20, 20);
                }
            }else{
                if (tingli) {
                    _normalLabel5.frame = CGRectMake(10, label.bottom+20, MainScreenSize_W -20, 20);
                }
            }
        }
    }else{
        if (tiankong) {
            _normalLabel3.frame = CGRectMake(10, _normalLabel1.bottom+30, MainScreenSize_W -20, 20);
            if (yuedu) {
                _normalLabel4.frame = CGRectMake(10, label2.bottom+20, MainScreenSize_W -20, 20);
                if (tingli) {
                    _normalLabel5.frame = CGRectMake(10, label3.bottom+20, MainScreenSize_W -20, 20);
                }
            }else{
                if (tingli) {
                    _normalLabel5.frame = CGRectMake(10, label2.bottom+20, MainScreenSize_W -20, 20);
                }
            }
        }else{
            if (yuedu) {
                _normalLabel4.frame = CGRectMake(10, _normalLabel1.bottom+30, MainScreenSize_W -20, 20);
                if (tingli) {
                    _normalLabel5.frame = CGRectMake(10, label3.bottom+20, MainScreenSize_W -20, 20);
                }
            }else{
                if (tingli) {
                    _normalLabel5.frame = CGRectMake(10, _normalLabel1.bottom+30, MainScreenSize_W -20, 20);
                }
            }
        }
    }
    //听力题
    int n = 0;
    UILabel *label4 = nil;
    for (; n < tingli; n ++ ) {
        int row=n/8;
        int col=n%8;
        CGFloat answerX = marginX+5 + col * (answerW + marginX);
        CGFloat answerY = 20 + row * (answerH + marginY);
        label4 = [[UILabel alloc]initWithFrame:CGRectZero];
        label4.frame = CGRectMake( answerX, answerY+_normalLabel5.bottom, answerW,answerH);
        label4.text = [NSString stringWithFormat:@"%d",m + n + j + i + 1];
        label4.textColor = [UIColor whiteColor];
        label4.font = [UIFont boldSystemFontOfSize:17];
        if ([arr[m + n + j + i] isEqual:@"0"]) {
            label4.backgroundColor = PView_LGrayColor;
            normals ++;
        }else if ([arr[m + n + j + i] isEqual:@"2"]) {
            label4.backgroundColor = PView_RedColor;
            falses ++;
        }else {
            label4.backgroundColor = PView_GreenColor;
            trues ++;
        }
        label4.tag = m + n + j + i;
        label4.layer.cornerRadius = 8.0;
        label4.layer.masksToBounds = YES;
        label4.userInteractionEnabled = YES;
        label4.textAlignment = NSTextAlignmentCenter;
        [_bgScrollView addSubview:label4];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseWhatTitle:)];
        [label4 addGestureRecognizer:tap];
        
        _bgScrollView.contentSize= CGSizeMake(0, label4.bottom + 50);
    }
    
    _trueLabel.text = [NSString stringWithFormat:@"%d",trues];
    _falseLabel.text = [NSString stringWithFormat:@"%d",falses];
    _noneLabel.text = [NSString stringWithFormat:@"%d",normals];

    
}

- (void)chooseWhatTitle:(UITapGestureRecognizer *)tap
{
    PLog(@"======%ld",tap.view.tag);
    if (self.delegate && [self.delegate respondsToSelector:@selector(QuestionAnswerDelegateWithTag:)]) {
        [self.delegate QuestionAnswerDelegateWithTag:tap.view.tag];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
