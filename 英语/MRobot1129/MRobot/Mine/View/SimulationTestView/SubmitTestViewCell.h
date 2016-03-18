//
//  SubmitTestViewCell.h
//  MRobot
//
//  Created by mac on 15/10/20.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SubmitTestViewCellDelegate <NSObject>

- (void)chooseWhichQuestion:(UITapGestureRecognizer *)index andTag:(NSInteger)indexPath;

@end

@interface SubmitTestViewCell : UITableViewCell

@property (strong, nonatomic) UIView *bgView;

@property (strong, nonatomic) UILabel *rightLabel;

@property (strong, nonatomic) UIImageView *lineView;

@property (strong, nonatomic) UIView *bgView2;

@property (strong, nonatomic) UILabel *wrongLabel;

@property (strong, nonatomic) UIImageView *lineView2;

@property (assign, nonatomic) NSInteger titleCount;

@property (assign, nonatomic) CGFloat rightHeight;

@property (assign, nonatomic) id<SubmitTestViewCellDelegate>delegate;

- (void)addCellData:(NSArray *)cellData andArray:(NSArray *)answerArr andLastCount:(NSInteger)lastCount;

+ (CGFloat)heightForCell:(NSArray *)dataArr;

@end
