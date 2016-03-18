//
//  SubmitBadTableViewCell.h
//  ERobot
//
//  Created by mac on 15/7/14.
//  Copyright (c) 2015年 BaiYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SubmitBadTableViewCellDelegate <NSObject>

- (void)submitBadTableViewCellDelegateWithTap:(UIView *)tapView withIndexRow:(int)row withWrongID:(NSString *)wrongId;

@end


@interface SubmitBadTableViewCell : UITableViewCell

@property (strong, nonatomic) UIView *bgView;

@property (strong, nonatomic) UIImageView *lineView;

@property (strong, nonatomic) NSArray *wrongIdArr;

@property (weak, nonatomic) id<SubmitBadTableViewCellDelegate>delegate;

- (void)addCellData:(NSArray *)cellData;

@end
