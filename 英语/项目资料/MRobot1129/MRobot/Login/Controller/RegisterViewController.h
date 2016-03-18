//
//  RegisterViewController.h
//  MRobot
//
//  Created by mac on 15/8/27.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "BaseViewController.h"
#import "CustomButton.h"
#import "ZJAlertView.h"
@interface RegisterViewController : BaseViewController<UITextFieldDelegate,CustomButtonDelegate>
{
    UITextField * nameTextField;//用户名
    UITextField * numTextField;//手机号码
    UITextField * verTextField;//验证码
    UITextField * passWTextField;//密码
    UITextField * emailTextField;//邮箱
    UIButton * yanzhengBtn;
    UIButton * repeatSMSBtn;
    CustomButton * provinceBtn;
    CustomButton * cityBtn;
    CustomButton * areaBtn;
//    CustomButton * kindBtn;
    UIButton * registerBtn;
    
    int provinceNum;
    int cityNum;
    int areaNum;
    NSString * level;
    
    NSString * pId;
    NSString * cId;
    NSString * dId;
}

@property (copy, nonatomic) NSString *originalPhone;

@property (strong, nonatomic) NSMutableArray * proviceArray;
@property (strong, nonatomic) NSMutableArray * cityArray;
@property (strong, nonatomic) NSMutableArray * areaArray;

@property (nonatomic,retain) NSMutableArray * array;

@property (strong, nonatomic) UITextField * checkText;
@property (assign, nonatomic) BOOL isRegisterVC;//YES:注册界面 NO:重置密码界面

@end
