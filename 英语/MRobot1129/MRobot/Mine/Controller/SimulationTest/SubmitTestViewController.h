//
//  SubmitTestViewController.h
//  MRobot
//
//  Created by mac on 15/10/19.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "BaseViewController.h"
#import "QuestionDataModel.h"
@interface SubmitTestViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NSString *score;

@property (strong, nonatomic) NSString * submitTitle;

@property (strong, nonatomic) UITableView * myTableView;

@property (strong, nonatomic) QuestionDataModel *questionModel;

@property (strong, nonatomic) NSMutableArray * questionArr;

@property (strong, nonatomic) NSArray * answerTrueArr;

@property (strong, nonatomic) NSArray * answerArr;

@end
