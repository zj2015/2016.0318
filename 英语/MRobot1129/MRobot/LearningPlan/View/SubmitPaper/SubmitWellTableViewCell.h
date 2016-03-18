//
//  SubmitWellTableViewCell.h
//  ERobot
//
//  Created by mac on 15/7/14.
//  Copyright (c) 2015年 BaiYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SubmitWellTableViewCellDelegate <NSObject>

- (void)choosePlayVoice:(NSInteger)indexpath;//播放

- (void)chooseWhichQuestion:(UITapGestureRecognizer *)index andTag:(NSInteger)indexPath;

@end

@interface SubmitWellTableViewCell : UITableViewCell

@property (strong, nonatomic) UIView *bgView;

@property (strong, nonatomic) UIImageView *leftImageView;

@property (strong, nonatomic) UILabel *rightLabel;

@property (strong, nonatomic) UIImageView *lineView;

@property (strong, nonatomic) UIImageView *rightImageView;

@property (strong, nonatomic) UIView *bgView2;

@property (strong, nonatomic) UILabel *wrongLabel;

@property (strong, nonatomic) UIImageView *lineView2;

@property (assign, nonatomic) NSInteger titleCount;

@property (assign, nonatomic) CGFloat rightHeight;

@property (assign, nonatomic) id<SubmitWellTableViewCellDelegate>delegate;

- (void)addCellData:(NSString *)cellData andArray:(NSArray *)dataArr;

- (void)addCellData:(NSString *)cellData;

+ (CGFloat)heightForCell:(NSArray *)dataArr;

@end
