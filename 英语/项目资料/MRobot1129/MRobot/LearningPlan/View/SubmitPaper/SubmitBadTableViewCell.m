//
//  SubmitBadTableViewCell.m
//  ERobot
//
//  Created by mac on 15/7/14.
//  Copyright (c) 2015年 BaiYu. All rights reserved.
//

#import "SubmitBadTableViewCell.h"

@implementation SubmitBadTableViewCell

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
        
        if (!_lineView) {
            _lineView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 43.5, MainScreenSize_W - 20, 0.5)];
            _lineView.backgroundColor = [UIColor lightGrayColor];
            [_bgView addSubview:_lineView];
        }
        
        
    }
    return self;
}

- (void)addCellData:(NSArray *)cellData
{
    _wrongIdArr = [[NSArray alloc]initWithArray:cellData];
    
    int totalColumns = 8;
    CGFloat answerW = 30*SIZE_TIMES;
    CGFloat answerH = 30*SIZE_TIMES;
    CGFloat marginX = (MainScreenSize_W - 10 - totalColumns * answerW) / (totalColumns + 1)-2;
    CGFloat marginY = 10;
    
    int i = 0;
    UILabel *label = nil;
    //选择题
    for (; i < cellData.count; i ++ ) {
        int row=i/8;
        int col=i%8;
        CGFloat answerX = marginX+5 + col * (answerW + marginX);
        CGFloat answerY = 10 + row * (answerH + marginY);
        label = [[UILabel alloc]initWithFrame:CGRectMake( answerX, answerY, answerW,answerH)];
        label.tag = i;
        label.layer.cornerRadius = 5.0;
        label.layer.masksToBounds = YES;
        label.text = [NSString stringWithFormat:@"%d",i + 1];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont boldSystemFontOfSize:17];
        label.backgroundColor = PView_RedColor;
        label.textAlignment = NSTextAlignmentCenter;
        label.userInteractionEnabled = YES;
        [_bgView addSubview:label];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseBadQuestion:)];
        [label addGestureRecognizer:tap];
        PLog(@"%d",i);
    }
    
    if (cellData.count%8) {
        _bgView.frame = CGRectMake(10, 0, MainScreenSize_W - 20, (cellData.count/8+1)*answerW+(cellData.count/8+2)*marginY);
    }else{
        _bgView.frame = CGRectMake(10, 0, MainScreenSize_W - 20, (cellData.count/8)*answerW+(cellData.count/8+1)*marginY);
    }
    _lineView.frame = CGRectMake(0, _bgView.height - 0.5, MainScreenSize_W - 20, 0.5);
    
}

- (void)chooseBadQuestion:(UITapGestureRecognizer *)tap
{
    UILabel *label = (UILabel *)tap.view;
    label.backgroundColor = [UIColor lightGrayColor];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(submitBadTableViewCellDelegateWithTap:withIndexRow:withWrongID:)]) {
        [self.delegate submitBadTableViewCellDelegateWithTap:tap.view withIndexRow:(int)_bgView.tag  withWrongID:_wrongIdArr[tap.view.tag]];
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
