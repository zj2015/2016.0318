//
//  MKActionView.h
//  MRobot
//
//  Created by mac on 15/9/20.
//  Copyright © 2015年 silysolong. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^MKActionViewBlock)(int tag);
@interface MKActionView : UIView

{
    MKActionViewBlock _block;
    UIView * _backView;
    CGFloat alertHeight;
}

- (instancetype)initWithTitleWithArr:(NSArray *)array WithBlock:(MKActionViewBlock)end;

@end
