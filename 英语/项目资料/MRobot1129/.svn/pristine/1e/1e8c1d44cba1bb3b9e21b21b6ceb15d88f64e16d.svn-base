//
//  ErrorKnowledgeCell.m
//  MRobot
//
//  Created by mac on 15/10/21.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "ErrorKnowledgeCell.h"

@implementation ErrorKnowledgeCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        NSArray *imgNameArr = @[@"zhishidian",@"cuotiji",@"retest"];
        NSArray *markNameArr = @[@"知识点解析",@"我的错题集",@"重新训练"];
        
        for (int i=0; i<3; i++) {
            int row = i / COLUMN;
            int column = i % COLUMN;
            
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(MainScreenSize_W/3*column, ROWHEIGHT*row, MainScreenSize_W/3, ROWHEIGHT)];
            view.backgroundColor = [UIColor clearColor];
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake((MainScreenSize_W/3-40*SIZE_TIMES)/2, 15*SIZE_TIMES, 40*SIZE_TIMES, 40*SIZE_TIMES);
            btn.tag = i;
            [btn addTarget:self action:@selector(chooseBtnClick:)forControlEvents:UIControlEventTouchUpInside];
            [btn setBackgroundImage:[UIImage imageNamed:[imgNameArr objectAtIndex:i]]
                           forState:UIControlStateNormal];
            [view addSubview:btn];
            
            UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 60*SIZE_TIMES, MainScreenSize_W/3, 20*SIZE_TIMES)];
            lbl.textAlignment = NSTextAlignmentCenter;
            lbl.font = [UIFont systemFontOfSize:13.0f];
            lbl.backgroundColor = [UIColor clearColor];
            lbl.text = [markNameArr objectAtIndex:i];
            [view addSubview:lbl];
            
            [self.contentView addSubview:view];
        }
        
        UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, ROWHEIGHT*SIZE_TIMES - 0.5, MainScreenSize_W, 0.5)];
        lineLab.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:lineLab];
        
    }
    return self;
}

- (void)chooseBtnClick:(UIButton *)btn
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(errorKnowledgeCellChooseBtn:)]) {
        [self.delegate errorKnowledgeCellChooseBtn:btn.tag];
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
