//
//  ErrorKnowledgeCell.h
//  MRobot
//
//  Created by mac on 15/10/21.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import <UIKit/UIKit.h>
#define COLUMN 3
#define ROWHEIGHT 100

@protocol ErrorKnowledgeCellDelegate <NSObject>

- (void)errorKnowledgeCellChooseBtn:(NSInteger)btnTag;

@end

@interface ErrorKnowledgeCell : UITableViewCell

@property (weak, nonatomic) id <ErrorKnowledgeCellDelegate> delegate;

@end
