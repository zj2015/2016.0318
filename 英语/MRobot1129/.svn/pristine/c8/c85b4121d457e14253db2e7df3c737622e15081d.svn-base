//
//  ItemView.h
//  Movie
//
//  Created by shangke on 14-9-25.
//  Copyright (c) 2014年 shangke. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ItemView;
@protocol ItemViewDelegate <NSObject>

@optional
- (void)didItemView:(ItemView *)itemView atIndex:(NSInteger)index;

@end

@interface ItemView : UIView

@property (nonatomic, readonly) UIImageView *item;
@property (nonatomic, readonly) UILabel     *title;
@property (nonatomic, assign) id <ItemViewDelegate> delegate;

@end
