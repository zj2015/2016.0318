//
//  SubmitWellTableViewCell.m
//  ERobot
//
//  Created by mac on 15/7/14.
//  Copyright (c) 2015年 BaiYu. All rights reserved.
//

#import "SubmitWellTableViewCell.h"
#import "TrainResultViewController.h"
@implementation SubmitWellTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        if (!_bgView) {
            _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenSize_W, 44)];
            _bgView.backgroundColor = [UIColor whiteColor];
//            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(choosePlayQuestion:)];
//            [_bgView addGestureRecognizer:tap];
            [self.contentView addSubview:_bgView];
        }
        
        if (!_lineView2) {
            _lineView2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, MainScreenSize_W - 20, 0.5)];
            _lineView2.backgroundColor = [UIColor lightGrayColor];
            [_bgView addSubview:_lineView2];
        }

        if (!_leftImageView) {
//            _leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 12, 10, 20)];
//            _leftImageView.image = [UIImage imageNamed:@"video-1"];
//            [_bgView addSubview:_leftImageView];
        }
        
        if (!_rightLabel) {
            _rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(_leftImageView.right + 10, 5, MainScreenSize_W - 110, 44-10)];
            _rightLabel.numberOfLines = 0;
            _rightLabel.font = [UIFont systemFontOfSize:15];
            [_bgView addSubview:_rightLabel];
        }
        
        if (!_lineView) {
//            _lineView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 43.5, MainScreenSize_W - 20, 0.5)];
//            _lineView.backgroundColor = [UIColor lightGrayColor];
//            [_bgView addSubview:_lineView];
        }
        
//        if (!_rightImageView) {
//            _rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(MainScreenSize_W - 60, 10, 25, 25)];
//            _rightImageView.image = [UIImage imageNamed:@"video-1"];
//            [_bgView2 addSubview:_rightImageView];
//        }
        
        if (!_bgView2) {
            _bgView2 = [[UIView alloc]initWithFrame:CGRectZero];
            [_bgView2 setBackgroundColor:[UIColor whiteColor]];
            [self.contentView addSubview:_bgView2];
        }
        
        if (!_rightImageView) {
            _rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(MainScreenSize_W - 60, 10, 25, 25)];
            _rightImageView.userInteractionEnabled = YES;
            _rightImageView.image = [UIImage imageNamed:@"video-1"];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(choosePlayQuestion:)];
            [_rightImageView addGestureRecognizer:tap];
            [_bgView2 addSubview:_rightImageView];
        }

    }
    return self;
}

- (void)addCellData:(NSString *)cellData
{
    _rightLabel.text = cellData;
}

- (void)addCellData:(NSString *)cellData andArray:(NSArray *)dataArr
{
    _rightLabel.text = cellData;
//    _rightHeight = [BaseAPIManager base_getHeightByContent:_rightLabel.text andFontSize:15 andFixedWidth:MainScreenSize_W - 110];
//    if (_rightHeight < 34) {
//        _rightHeight = 34;
//    }
//    _rightLabel.frame = CGRectMake(_leftImageView.right + 10, 5, MainScreenSize_W - 110, _rightHeight - 10);
    
    if (dataArr.count != 0) {
        
        int totalColumns = 8;
        CGFloat answerW = 30*SIZE_TIMES;
        CGFloat answerH = 30*SIZE_TIMES;
        CGFloat marginX = (MainScreenSize_W - 10 - totalColumns * answerW) / (totalColumns + 1)-2;
        CGFloat marginY = 10;
        
        int i = 0;
        UILabel *label = nil;
        //选择题
        for (; i < dataArr.count; i ++ ) {
            int row=i/8;
            int col=i%8;
            CGFloat answerX = marginX+5 + col * (answerW + marginX);
            CGFloat answerY = 10 + row * (answerH + marginY);
            label = [[UILabel alloc]initWithFrame:CGRectMake( answerX, answerY, answerW,answerH)];
            label.tag = i;
            label.layer.cornerRadius = 21.0;
            label.layer.masksToBounds = YES;
            label.text = [NSString stringWithFormat:@"%d",i + 1];
            label.textColor = [UIColor whiteColor];
            label.font = [UIFont boldSystemFontOfSize:17];
            label.backgroundColor = [UIColor colorWithRed:152/255.0f green:188/255.0f blue:53/255.0f alpha:1];
            label.textAlignment = NSTextAlignmentCenter;
            label.userInteractionEnabled = YES;
            [_bgView2 addSubview:label];
//            _bgView2.backgroundColor = PV
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseBadQuestion:)];
            [label addGestureRecognizer:tap];
            
        }
        CGFloat height = 0;
        if (dataArr.count%8) {
           
            height =  10+ (dataArr.count/8+1)*answerW+(dataArr.count/8+2)*marginY;
            self.bgView2.frame = CGRectMake(0, _bgView.bottom, MainScreenSize_W, height);
        }else if (dataArr.count == 0){
            
            self.bgView2.frame = CGRectMake(0, _bgView.bottom, MainScreenSize_W, height);
            
        }else{
            height =  10+(dataArr.count/8)*answerW+(dataArr.count/8+1)*marginY;
            
            self.bgView2.frame = CGRectMake(0, _bgView.bottom, MainScreenSize_W, height);
        }
        [_rightImageView setTop:(height - _rightImageView.height)/2.0];
        
    }
    
}

- (void)chooseBadQuestion:(UITapGestureRecognizer *)tap
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(chooseWhichQuestion:andTag:)]) {
        [self.delegate chooseWhichQuestion:tap andTag:_bgView.tag];
    }
}

- (void)choosePlayQuestion:(UITapGestureRecognizer *)tap
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(choosePlayVoice:)]) {
        [self.delegate choosePlayVoice:tap.view.tag];
    }
}

+ (CGFloat)heightForCell:(NSArray *)dataArr
{
    CGFloat height = 0;
    if (dataArr.count%8) {
        height =  10+ (dataArr.count/8+1)*30*SIZE_TIMES+(dataArr.count/8+2)*10;
    }else if (dataArr.count == 0){
        height =  0;
    }else{
        height =  10+(dataArr.count/8)*30*SIZE_TIMES+(dataArr.count/8+1)*10;
    }
    return height + 44;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
