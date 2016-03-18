//
//  ErrorKnowledgeHeadView.m
//  MRobot
//
//  Created by mac on 15/10/21.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "ErrorKnowledgeHeadView.h"

@implementation ErrorKnowledgeHeadView

@synthesize knowledgeLab;
@synthesize errorLab;
@synthesize signImgView;
@synthesize errorPercentLab;

+ (instancetype)headViewWithTableView:(UITableView *)tableView withBlock:(ErrorKnowledgeHeadViewBlock)block
{
    static NSString *headIdentifier = @"header";
    
    ErrorKnowledgeHeadView *headView = [tableView dequeueReusableCellWithIdentifier:headIdentifier];
    if (headView == nil) {
        headView = [[ErrorKnowledgeHeadView alloc] initWithReuseIdentifier:headIdentifier with:block];
    }
    
    return headView;
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier with:(ErrorKnowledgeHeadViewBlock)block
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        _block = block;
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        knowledgeLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, MainScreenSize_W - 85, 44*SIZE_TIMES)];
        knowledgeLab.backgroundColor = [UIColor clearColor];
        knowledgeLab.font = [UIFont systemFontOfSize:15.0];
        [self.contentView addSubview:knowledgeLab];
        
        errorLab = [[UILabel alloc] initWithFrame:CGRectMake(MainScreenSize_W - 80, 5*SIZE_TIMES, 50, 18*SIZE_TIMES)];
        errorLab.backgroundColor = [UIColor clearColor];
        errorLab.textAlignment = NSTextAlignmentCenter;
        errorLab.font = [UIFont systemFontOfSize:14.0];
        errorLab.textColor = PView_RedColor;
        [self.contentView addSubview:errorLab];
        
        errorPercentLab = [[UILabel alloc] initWithFrame:CGRectMake(MainScreenSize_W - 80, 23*SIZE_TIMES, 50, 20*SIZE_TIMES)];
        errorPercentLab.backgroundColor = [UIColor clearColor];
        errorPercentLab.textAlignment = NSTextAlignmentCenter;
        errorPercentLab.font = [UIFont systemFontOfSize:13.0];
        errorPercentLab.text = @"错误率";
        errorPercentLab.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:errorPercentLab];
        
        signImgView = [[UIImageView alloc] initWithFrame:CGRectMake(MainScreenSize_W - 30, (50 - 15)/2*SIZE_TIMES, 15*SIZE_TIMES, 15*SIZE_TIMES)];
        [self.contentView addSubview:signImgView];
        
        UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 44*SIZE_TIMES-0.5, MainScreenSize_W, 0.5)];
        lineLab.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:lineLab];
        
        [self.contentView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTheErrorKnowledgeHeadView:)]];
        
    }
    return self;
}

- (void)clickTheErrorKnowledgeHeadView:(UITapGestureRecognizer *)tap
{
    _block(tap.view.tag);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
