//
//  LoginViewController.h
//  MRobot
//
//  Created by mac on 15/8/20.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "BaseViewController.h"

@interface LoginViewController : BaseViewController<UITextFieldDelegate>

@property (strong, nonatomic) UIImageView * logoImageView;

@property (strong, nonatomic) UITextField * telField;

@property (strong, nonatomic) UITextField * accountField;

@property (strong, nonatomic) UITextField * passwordField;

@property (strong, nonatomic) UITextField * checkText;

@property (assign, nonatomic) BOOL isChangePassword;

@end
