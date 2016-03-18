//
//  ZJAlertView.h
//  AlertViewDemo
//
//  Created by mac on 15/8/3.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ZJAlert)(NSString *why,int tag,int isSelect);//传值，why 可以传递你在alertView里面写的字， tag 传递你选中取消还是确定  ， isSelecte 传递你在alertView里面是否有什么特殊设置等等，

@interface ZJAlertView : UIView<UITableViewDelegate,UITableViewDataSource>

{
    ZJAlert _finish;
    UIView * _backView;
    UITableView *smallTableView;
    UIView *headView;
    UILabel *titleLabel;
    UILabel *titleLine;
    CGFloat alertHeight;
    NSString *cellData;
    int isSelect;
}

@property (strong, nonatomic) NSArray *numArray;
@property (copy, nonatomic) NSString *origPhone;
@property (strong, nonatomic) NSMutableArray *cellArray;

- (instancetype)initWithTitle:(NSString *)title andSelect:(NSString*)selected andContent:(NSArray *)contentArr  WithBlock:(ZJAlert)end;

@end
