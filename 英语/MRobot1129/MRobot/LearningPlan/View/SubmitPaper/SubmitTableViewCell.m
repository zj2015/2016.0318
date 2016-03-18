//
//  SubmitTableViewCell.m
//  ERobot
//
//  Created by mac on 15/7/14.
//  Copyright (c) 2015年 BaiYu. All rights reserved.
//

#import "SubmitTableViewCell.h"


@interface  SubmitTableViewCell()
{
    UILabel *labelDate;
    UILabel *labelScore;
    UILabel *labelStuNameValue;
    UILabel *labelClassValue;
    UILabel *labelTeachinBookValue;
}
@end

@implementation SubmitTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        if ([reuseIdentifier isEqualToString:@"identifier6"]) {
            self.selectionStyle=UITableViewCellSelectionStyleNone;
//            self.backgroundColor = RgbColor(179, 61, 22);
            self.contentView.backgroundColor = PView_BGColor;

            labelDate = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0, MainScreenSize_W,25.0f)];
            [labelDate setBackgroundColor:[UIColor clearColor]];
            labelDate.textAlignment = 1;
            [labelDate setTextColor:[UIColor whiteColor]];
            [self.contentView addSubview:labelDate];
            
            
            UIView *backOrangeView = [[UIView alloc] initWithFrame:CGRectMake(0.0F,labelDate.frame.origin.y+labelDate.frame.size.height+75, MainScreenSize_W, 200)];
            [backOrangeView setBackgroundColor:RgbColor(167, 157, 110)];
            [self.contentView addSubview:backOrangeView];

            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0.0f,220, backOrangeView.frame.size.width, 1.0)];
            [lineView setBackgroundColor:RgbColor(121, 110, 77)];
            [lineView.layer setShadowColor:[UIColor blackColor].CGColor];
            [lineView.layer setShadowOpacity:0.8f];//设置阴影的透明度
            [lineView.layer setOpacity:0.8f];//设置View的透明度
            [lineView.layer setShadowOffset:CGSizeMake(4.0, 3.0)];//设置View Shadow的偏移量
            [self.contentView addSubview:lineView];
            
            
            labelScore = [[UILabel alloc] initWithFrame:CGRectMake((MainScreenSize_W-80)/2, labelDate.frame.origin.y+labelDate.frame.size.height+5, 100,100)];
            labelScore.layer.cornerRadius = 50;
            labelScore.layer.masksToBounds = YES;
            [labelScore setBackgroundColor:RgbColor(226, 78, 32)];
            [labelScore setTextColor:[UIColor whiteColor]];
            labelScore.textAlignment = 1;
            [labelScore setFont:[UIFont boldSystemFontOfSize:50]];
            [self.contentView addSubview:labelScore];
            
            
            UILabel *labelScoreStr = [[UILabel alloc] initWithFrame:CGRectMake(20, 75, 60, 20)];
            [labelScoreStr setTextAlignment:1];
            [labelScoreStr setTextColor:[UIColor whiteColor]];
            [labelScoreStr setBackgroundColor:[UIColor clearColor]];
            [labelScoreStr setText:@"Score"];
            [labelScore addSubview:labelScoreStr];
            
            
            UILabel *labelStuName = [[UILabel alloc] initWithFrame:CGRectMake(0, labelScore.frame.origin.y+labelScore.frame.size.height+5, MainScreenSize_W,30)];
            [labelStuName setBackgroundColor:[UIColor clearColor]];
            labelStuName.textAlignment = 1;
            [labelStuName setTextColor:[UIColor whiteColor]];
            [labelStuName setText:@"Student name:"];
            [self.contentView addSubview:labelStuName];
            
            
            labelStuNameValue = [[UILabel alloc] initWithFrame:CGRectMake(0, labelStuName.frame.origin.y+labelStuName.frame.size.height, MainScreenSize_W,50)];
            [labelStuNameValue setBackgroundColor:[UIColor clearColor]];
            labelStuNameValue.textAlignment = 1;
            [labelStuNameValue setTextColor:[UIColor whiteColor]];
            [labelStuNameValue setFont:[UIFont systemFontOfSize:30]];
            [self.contentView addSubview:labelStuNameValue];
            
            
            UILabel *labelClass = [[UILabel alloc] initWithFrame:CGRectMake(0, labelStuNameValue.frame.origin.y+labelStuNameValue.frame.size.height+10, MainScreenSize_W/2,30)];
            [labelClass setBackgroundColor:[UIColor clearColor]];
            [labelClass setText:@"Class"];
            [labelClass setTextColor:[UIColor whiteColor]];
            [labelClass setTextAlignment:1];
            
            [self.contentView addSubview:labelClass];
            
            
            UILabel *labelTeachinBook = [[UILabel alloc] initWithFrame:CGRectMake(MainScreenSize_W/2, labelClass.frame.origin.y, MainScreenSize_W/2,30)];
            [labelTeachinBook setBackgroundColor:[UIColor clearColor]];
            [labelTeachinBook setTextColor:[UIColor whiteColor]];
            [labelTeachinBook setTextAlignment:1];
            [labelTeachinBook setText:@"Teachin Book"];
            [self.contentView addSubview:labelTeachinBook];
            
            
            
            labelClassValue = [[UILabel alloc] initWithFrame:CGRectMake(0, labelClass.frame.origin.y+labelClass.frame.size.height+3, MainScreenSize_W/2,50)];
            [labelClassValue setBackgroundColor:[UIColor clearColor]];
            [labelClassValue setTextColor:[UIColor whiteColor]];
            [labelClassValue setTextAlignment:1];
            
            [self.contentView addSubview:labelClassValue];
            
            
            labelTeachinBookValue = [[UILabel alloc] initWithFrame:CGRectMake(MainScreenSize_W/2, labelClassValue.frame.origin.y, MainScreenSize_W/2,50)];
            [labelTeachinBookValue setBackgroundColor:[UIColor clearColor]];
            [labelTeachinBookValue setTextColor:[UIColor whiteColor]];
            [labelTeachinBookValue setTextAlignment:1];
            
            [self.contentView addSubview:labelTeachinBookValue];
            
            //            self.backgroundColor = [UIColor clearColor];
//            
//            if (!_bgView) {
//                _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenSize_W, self.frame.size.height)];
//                _bgView.backgroundColor = [UIColor whiteColor];
//                [self.contentView addSubview:_bgView];
//            }
//            
//            if (!_leftLabel) {
//                _leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, MainScreenSize_W/3 - 30, 44-10)];
//                _leftLabel.font = [UIFont systemFontOfSize:15];
//                [_bgView addSubview:_leftLabel];
//            }
//            
//            if (!_rightLabel) {
//                _rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(MainScreenSize_W/3, 5, MainScreenSize_W/3*2 - 30, 44-10)];
//                _rightLabel.textAlignment = NSTextAlignmentRight;
//                _rightLabel.font = [UIFont systemFontOfSize:15];
//                [_bgView addSubview:_rightLabel];
//            }
//            
//            if (!_lineView) {
//                //            _lineView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 43.5, MainScreenSize_W - 20, 0.5)];
//                //            _lineView.backgroundColor = [UIColor lightGrayColor];
//                //            [_bgView addSubview:_lineView];
//            }

            
        }else
        {
            self.selectionStyle=UITableViewCellSelectionStyleNone;
            self.backgroundColor = [UIColor clearColor];
            
            if (!_bgView) {
                _bgView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, MainScreenSize_W - 20, 44)];
                _bgView.backgroundColor = [UIColor whiteColor];
                [self.contentView addSubview:_bgView];
            }
            
            if (!_leftLabel) {
                _leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, MainScreenSize_W/3 - 30, 44-10)];
                _leftLabel.font = [UIFont systemFontOfSize:15];
                [_bgView addSubview:_leftLabel];
            }
            
            if (!_rightLabel) {
                _rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(MainScreenSize_W/3, 5, MainScreenSize_W/3*2 - 30, 44-10)];
                _rightLabel.textAlignment = NSTextAlignmentRight;
                _rightLabel.font = [UIFont systemFontOfSize:15];
                [_bgView addSubview:_rightLabel];
            }
            
            if (!_lineView) {
                _lineView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 43.5, MainScreenSize_W - 20, 0.5)];
                _lineView.backgroundColor = [UIColor lightGrayColor];
                [_bgView addSubview:_lineView];
            }

        }
        
        
    }
    return self;
}

- (void)addCellData:(NSString *)cellData andTitle:(NSString *)title
{
    _leftLabel.text = title;
    _rightLabel.text = cellData;
}
- (void)addCellDataNew:(NSArray *)cellDataArray andTitle:(NSArray *)titleArray
{
    
    if ([titleArray count]==3) {
        NSLog(@"cellDataArray=%@",cellDataArray);
        
        self.contentView.backgroundColor = PView_BGColor;
        [labelScore setText:[cellDataArray objectAtIndex:0]];
        [labelDate setText:[cellDataArray objectAtIndex:2]];
        [labelStuNameValue setText:[cellDataArray objectAtIndex:1]];
        
    }else if([titleArray count]==4)
    {
        NSLog(@"cellDataArray=%@",cellDataArray);
        
        self.contentView.backgroundColor = PView_BGColor;
        [labelScore setText:[cellDataArray objectAtIndex:0]];
         [labelStuNameValue setText:[cellDataArray objectAtIndex:1]];
        [labelClassValue setText:[cellDataArray objectAtIndex:2]];
        [labelDate setText:[cellDataArray objectAtIndex:3]];
        
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
