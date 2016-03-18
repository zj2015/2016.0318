//
//  VolumeTestViewController.h
//  MRobot
//
//  Created by mac on 15/9/8.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "BaseViewController.h"

@interface VolumeTestViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UITableView * myTableView;

@property (strong, nonatomic) NSMutableArray * simulationArr;

@property (nonatomic,assign) int pageIndex;//分页页码

@end
