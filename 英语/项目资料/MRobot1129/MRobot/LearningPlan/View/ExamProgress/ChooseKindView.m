//
//  ChooseKindView.m
//  MRobot
//
//  Created by mac on 15/8/21.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "ChooseKindView.h"

@implementation ChooseKindView

- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title withImageArr:(NSArray *)imagesArr withTitleArr:(NSArray *)titlesArr withBlock:(ChooseKindViewBlock)block
{
    self = [super initWithFrame:frame];
    if (self) {
        _block = block;
//        self.backgroundColor = [UIColor colorWithHex:0xDCDCDC alpha:1.0];
        self.backgroundColor =  [UIColor colorWithRed:76/255.0f green:76/255.0f blue:78/255.0f alpha:1];
        int total = (int)titlesArr.count;
        
        UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(1, 1, MainScreenSize_W - 12, 35)];
        titleLabel.backgroundColor = [UIColor colorWithRed:76/255.0f green:76/255.0f blue:78/255.0f alpha:1];
        titleLabel.font = [UIFont systemFontOfSize:17];
        titleLabel.text = title;
        titleLabel.textAlignment = 1;
        [self addSubview:titleLabel];
        
        
        for (int i=0; i<total; i++) {
            
            int column = i % total;
            
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake((MainScreenSize_W - 11)/total*column + 1, titleLabel.bottom + 1, (MainScreenSize_W - 11)/total - 1, 80)];
            view.tag = i+1;
            view.backgroundColor = PView_BGColor;
//            view.backgroundColor = [UIColor blueColor];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizer:)];
            [view addGestureRecognizer:tap];
            
          
            CGFloat imageWidth = 50;
            if (MainScreenSize_W>320) {
                imageWidth = 80;
            }
            UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(((MainScreenSize_W - 11)/total-imageWidth)/2, 4, imageWidth, imageWidth)];
            image.backgroundColor = [UIColor clearColor];
            image.image = [UIImage imageNamed:imagesArr[i]];
            NSLog(@"imagesArr=%@ i:%d",imagesArr[i],i);
            [view addSubview:image];
            
            UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, image.bottom + 5, (MainScreenSize_W - 10)/total, 20)];
            lbl.textAlignment = NSTextAlignmentCenter;
            lbl.font = [UIFont systemFontOfSize:12.0f];
            lbl.text = [titlesArr objectAtIndex:i];
            [view addSubview:lbl];
            
            [self addSubview:view];
        }
        
        
        
    }
    return self;
}

- (void)tapGestureRecognizer:(UITapGestureRecognizer *)tap
{
    _block((int)tap.view.tag);    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
