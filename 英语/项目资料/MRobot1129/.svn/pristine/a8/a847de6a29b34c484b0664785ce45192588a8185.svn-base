//
//  SubmitTestViewCell.m
//  MRobot
//
//  Created by mac on 15/10/20.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "SubmitTestViewCell.h"

@implementation SubmitTestViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        if (!_bgView) {
            _bgView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, MainScreenSize_W - 20, 44)];
            _bgView.backgroundColor = [UIColor whiteColor];
            [self.contentView addSubview:_bgView];
        }
        
        if (!_lineView2) {
            _lineView2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, MainScreenSize_W - 20, 0.5)];
            _lineView2.backgroundColor = [UIColor lightGrayColor];
            [_bgView addSubview:_lineView2];
        }
        
        if (!_rightLabel) {
            _rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, MainScreenSize_W - 30, 44-10)];
            _rightLabel.numberOfLines = 0;
            _rightLabel.font = [UIFont systemFontOfSize:15];
            [_bgView addSubview:_rightLabel];
        }
        
        if (!_lineView) {
            _lineView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 43.5, MainScreenSize_W - 20, 0.5)];
            _lineView.backgroundColor = [UIColor lightGrayColor];
            [_bgView addSubview:_lineView];
        }
        
        if (!_bgView2) {
            _bgView2 = [[UIView alloc]initWithFrame:CGRectZero];
            [_bgView2 setBackgroundColor:PView_BGColor];
            [self.contentView addSubview:_bgView2];
        }
        
    }
    return self;
}

- (void)AllClear
{
    for (UIView *view in self.bgView2.subviews) {
        view.hidden = YES;
    }
}

- (void)addCellData:(NSArray *)cellData andArray:(NSArray *)answerArr andLastCount:(NSInteger)lastCount
{
    [self AllClear];
    
    NSDictionary * dict = cellData[lastCount];
    _rightLabel.text = dict[@"0"];
    
    NSArray *Qarray = [[NSArray alloc]initWithArray:dict[@"1"]];
    
    int totalColumns = 8;
    CGFloat answerW = 30*SIZE_TIMES;
    CGFloat answerH = 30*SIZE_TIMES;
    CGFloat marginX = (MainScreenSize_W - 10 - totalColumns * answerW) / (totalColumns + 1)-2;
    CGFloat marginY = 10;
    
    int m = 0;
    for (int j = 0;j < cellData.count; j++) {
        NSDictionary *questDict = cellData[j];
        NSArray *array = [[NSArray alloc]initWithArray:questDict[@"1"]];
        if (j == (int)lastCount) {
            break;
        }
        m += array.count;
    }
    
    int i = 0;
    UILabel *label = nil;
    //选择题
    for (; i < Qarray.count; i ++ ) {
        int row=i/8;
        int col=i%8;
        CGFloat answerX = marginX+5 + col * (answerW + marginX);
        CGFloat answerY = 10 + row * (answerH + marginY);
        label = [[UILabel alloc]initWithFrame:CGRectMake( answerX, answerY, answerW,answerH)];
        label.tag = i + m;
        label.layer.cornerRadius = 5.0;
        label.layer.masksToBounds = YES;
        label.text = [NSString stringWithFormat:@"%d",i + 1 + m];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont boldSystemFontOfSize:17];
        if ([answerArr[i+m] isEqualToString:@"0"]) {
            label.backgroundColor = PView_LGrayColor;
        }else if ([answerArr[i+m] isEqualToString:@"1"]){
            label.backgroundColor = PView_GreenColor;
        }else if ([answerArr[i+m] isEqualToString:@"2"]){
            label.backgroundColor = PView_RedColor;
        }
        label.textAlignment = NSTextAlignmentCenter;
        label.userInteractionEnabled = YES;
        [_bgView2 addSubview:label];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseBadQuestion:)];
        [label addGestureRecognizer:tap];
    }
    CGFloat height = 0;
    if (Qarray.count%8) {
        
        height =  10+ (Qarray.count/8+1)*answerW+(Qarray.count/8+2)*marginY;
        self.bgView2.frame = CGRectMake(10, _bgView.bottom, MainScreenSize_W - 20, height);
    }else if (Qarray.count == 0){
        
        self.bgView2.frame = CGRectMake(10, _bgView.bottom, MainScreenSize_W - 20, height);
        
    }else{
        height =  10+(Qarray.count/8)*answerW+(Qarray.count/8+1)*marginY;
        
        self.bgView2.frame = CGRectMake(10, _bgView.bottom, MainScreenSize_W - 20, height);
    }
    
}

- (void)chooseBadQuestion:(UITapGestureRecognizer *)tap
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(chooseWhichQuestion:andTag:)]) {
        [self.delegate chooseWhichQuestion:tap andTag:_bgView.tag];
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
