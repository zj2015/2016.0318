//
//  MineViewController.h
//  MRobot
//
//  Created by mac on 15/8/19.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "BaseViewController.h"

@interface MineViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UITableView *myTableView;

@end
