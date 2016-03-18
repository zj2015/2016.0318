//
//  RegisterViewController.m
//  MRobot
//
//  Created by mac on 15/8/27.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "RegisterViewController.h"
#import "StudyPlanViewController.h"
#import "ProvinceDataModel.h"
#import "ProvinceListModel.h"
#import "CityDataModel.h"
#import "DistrictDataModel.h"
#import <SMS_SDK/SMS_SDK.h>
#import "UserLoginModel.h"
#import "LoginViewController.h"
@interface RegisterViewController ()

{
    NSTimer* _timer1;
    NSTimer* _timer2;
    NSTimer* _timer3;

    UIAlertView* _alert;
    UIAlertView* _alert1;
    UIAlertView* _alert2;
    UIAlertView* _alert3;
    int count;
    
}

@property (strong, nonatomic) ProvinceListModel *listModel;

@property (strong, nonatomic) ProvinceDataModel *provinceModel;

@property (strong, nonatomic) CityDataModel *cityModel;

@property (strong, nonatomic) DistrictDataModel *areaModel;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.isRegisterVC == YES) {
        [self base_changeNavigationTitleWithString:@"注册"];
    }else{
        [self base_changeNavigationTitleWithString:@"密码重置"];
    }
    
    _originalPhone = @"";
    pId = @"";
    cId = @"";
    dId = @"";

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];

    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(keyboardWasHidden:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)base_navigation_LeftBarButtonPressed
{
    [_timer2 invalidate];
    [_timer1 invalidate];
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  省市区的请求数据
 */
- (void)_prepareData
{
    LearningPlanRequest *request = [[LearningPlanRequest alloc]init];
    [request userRequestWithLocationSuccess:^(id obj) {
        InfoResult *infoResult = (InfoResult *)obj;
        if ([infoResult.code isEqualToString:@"0"]) {
            _listModel = [[ProvinceListModel alloc] init];
            _listModel = (ProvinceListModel *)[infoResult extraObj];
            
            _proviceArray = [[NSMutableArray alloc]init];
            for (int i = 0; i < _listModel.provinceList.count ; i ++ ) {
                ProvinceDataModel *dataModel = [_listModel.provinceList objectAtIndex:i];
                [_proviceArray addObject:dataModel.province];
            }
            
            
        }
    } failed:^(id obj) {
        
    }];
}

/**
 *  注册界面UI
 */
- (void)_prepareUI
{
    nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 20 + 64 , MainScreenSize_W-20, 35*SIZE_TIMES)];
    nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    nameTextField.delegate = self;
    nameTextField.placeholder = @" 请输入姓名";
    [self.view addSubview:nameTextField];
    
    numTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, nameTextField.bottom + 10, MainScreenSize_W-20, 35*SIZE_TIMES)];
    numTextField.borderStyle = UITextBorderStyleRoundedRect;
    numTextField.keyboardType = UIKeyboardTypeNumberPad;
    numTextField.delegate = self;
    numTextField.placeholder = @" 请输入您的手机号";
    [self.view addSubview:numTextField];
    
    verTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, numTextField.bottom + 10, (MainScreenSize_W-30)*2/3, 35*SIZE_TIMES)];
    verTextField.borderStyle = UITextBorderStyleRoundedRect;
    verTextField.keyboardType = UIKeyboardTypeNumberPad;
    verTextField.delegate = self;
    verTextField.placeholder = @" 请输入手机验证码";
    [self.view addSubview:verTextField];
    
    yanzhengBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    yanzhengBtn.frame = CGRectMake(verTextField.right+10, verTextField.top, (MainScreenSize_W-30)/3, 35*SIZE_TIMES);
    yanzhengBtn.layer.cornerRadius = 4.0;
    yanzhengBtn.layer.masksToBounds = YES;
    yanzhengBtn.userInteractionEnabled = YES;
    yanzhengBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    yanzhengBtn.backgroundColor = RgbColor(35, 173, 92);
    [yanzhengBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    [yanzhengBtn addTarget:self action:@selector(getVerificationCode:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:yanzhengBtn];
    
    repeatSMSBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    repeatSMSBtn.frame = CGRectMake(verTextField.right+10, verTextField.top, (MainScreenSize_W-30)/3, 35*SIZE_TIMES);
    repeatSMSBtn.hidden = YES;
    repeatSMSBtn.layer.cornerRadius = 4.0;
    repeatSMSBtn.layer.masksToBounds = YES;
    repeatSMSBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [repeatSMSBtn setTitle:@"重新获取" forState:UIControlStateNormal];
    repeatSMSBtn.backgroundColor = RgbColor(35, 173, 92);
    [repeatSMSBtn addTarget:self action:@selector(CannotGetSMS) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:repeatSMSBtn];
    
    if (self.isRegisterVC == YES) {
        passWTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, verTextField.bottom + 10, MainScreenSize_W-20, 35*SIZE_TIMES)];
        passWTextField.borderStyle = UITextBorderStyleRoundedRect;
        passWTextField.delegate = self;
        passWTextField.secureTextEntry = YES;
        passWTextField.placeholder = @" 请输入密码";
        [self.view addSubview:passWTextField];
        
        emailTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, passWTextField.bottom + 10, MainScreenSize_W-20, 35*SIZE_TIMES)];
        emailTextField.borderStyle = UITextBorderStyleRoundedRect;
        emailTextField.delegate = self;
        emailTextField.placeholder = @" 请输入邮箱";
        [self.view addSubview:emailTextField];
        
        provinceBtn = [[CustomButton alloc]initWithFrame:CGRectMake(10, emailTextField.bottom + 10, MainScreenSize_W - 20, 35*SIZE_TIMES)];
        provinceBtn.leftLabel.text = @"请选择省";
        provinceBtn.delegate = self;
        provinceBtn.tag = 101;
        [self.view addSubview:provinceBtn];
        
        cityBtn = [[CustomButton alloc]initWithFrame:CGRectMake(10, provinceBtn.bottom + 10, (MainScreenSize_W-30)/2, 35*SIZE_TIMES)];
        cityBtn.leftLabel.text = @"请选择市";
        cityBtn.delegate = self;
        cityBtn.tag = 102;
        [self.view addSubview:cityBtn];
        
        areaBtn = [[CustomButton alloc]initWithFrame:CGRectMake(cityBtn.right + 10, cityBtn.top, (MainScreenSize_W-30)/2, 35*SIZE_TIMES)];
        areaBtn.leftLabel.text = @"请选择区";
        areaBtn.delegate = self;
        areaBtn.tag = 103;
        [self.view addSubview:areaBtn];
        
        //    kindBtn = [[CustomButton alloc]initWithFrame:CGRectMake(10, cityBtn.bottom + 10, MainScreenSize_W - 20, 35*SIZE_TIMES)];
        //    kindBtn.leftLabel.text = @"请选择中考班级类型";
        //    kindBtn.delegate = self;
        //    kindBtn.tag = 104;
        //    [self.view addSubview:kindBtn];
        
        registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        registerBtn.frame = CGRectMake(10, MainScreenSize_H - 45*SIZE_TIMES, MainScreenSize_W - 20, 40*SIZE_TIMES);
        registerBtn.layer.cornerRadius = 4.0;
        registerBtn.layer.masksToBounds = YES;
        registerBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        registerBtn.backgroundColor = RgbColor(35, 173, 92);
        [registerBtn setTitle:@"立即注册" forState:UIControlStateNormal];
        [registerBtn addTarget:self action:@selector(registerButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:registerBtn];
    }else{
        registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        registerBtn.frame = CGRectMake(10, MainScreenSize_H - 45*SIZE_TIMES, MainScreenSize_W - 20, 40*SIZE_TIMES);
        registerBtn.layer.cornerRadius = 4.0;
        registerBtn.layer.masksToBounds = YES;
        registerBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        registerBtn.backgroundColor = RgbColor(35, 173, 92);
        [registerBtn setTitle:@"密码重置" forState:UIControlStateNormal];
        [registerBtn addTarget:self action:@selector(registerButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:registerBtn];
        
    }
}

/**
 *  验证码
 */
- (void)getVerificationCode:(UIButton *)btn
{
    if ([aCommon isBlankString:numTextField.text] ){
        [aCommon iToast:@"请输入您的手机号码~"];
    }else if ( numTextField.text.length == 11 ) {
        PLog(@"验证码按钮事件");
        [self.view endEditing:YES];
        _array=[NSMutableArray array];
        //获取支持的地区列表
        [SMS_SDK getZone:^(enum SMS_ResponseState state, NSArray *array) {
            if (1==state)
            {
                PLog(@"获取区号成功");
                //区号数据
                _array=[NSMutableArray arrayWithArray:array];
            }
            else if (0==state)
            {
                PLog(@"获取区号失败");
            }
        }];
        
        for (int i=0; i<_array.count; i++) {
            NSDictionary* dict1=[_array objectAtIndex:i];
            NSString* code1=[dict1 valueForKey:@"zone"];
            if ([code1 isEqualToString:@"86"]) {
                NSString* rule1=[dict1 valueForKey:@"rule"];
                NSPredicate* pred=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",rule1];
                BOOL isMatch=[pred evaluateWithObject:numTextField.text];
                if (!isMatch) {
                    
                    [[SoundTools sharedSoundTools] playSoundWithName:@"ui_warning"];

                    
                    //手机号码不正确
                    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"友情提示", nil) message:NSLocalizedString(@"手机号码不合法", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"确定", nil) otherButtonTitles:nil, nil];
                    [alert show];
                    return;
                }
                break;
            }
        }
        
        NSString* str=[NSString stringWithFormat:@"%@:%@ %@",NSLocalizedString(@"确定将验证码发送至该号码", nil),@"+86",numTextField.text];
        
        [[SoundTools sharedSoundTools] playSoundWithName:@"ui_warning"];

        
        UIAlertView* alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"友情提示", nil) message:str delegate:self cancelButtonTitle:NSLocalizedString(@"取消", nil) otherButtonTitles:NSLocalizedString(@"确定", nil), nil];
        _alert = alert;
        [alert show];
    }else {
        [aCommon iToast:@"输入合法的手机号码哦~"];
    }
    
}

#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == _alert) {
        if (1==buttonIndex)
        {
            [self getVerifyCode];
        }
        if (0==buttonIndex) {
            PLog(@"点击了取消按钮");
        }
    }
    if (alertView==_alert1)
    {
        if (1==buttonIndex)
        {
            PLog(@"重发验证码");
            yanzhengBtn.hidden=NO;
            repeatSMSBtn.hidden=YES;
            count = 0;
            
            [self getVerifyCode];
        }
    }
    
    if (alertView==_alert2) {
        if (0==buttonIndex)
        {
            [self.navigationController popViewControllerAnimated:YES];
            yanzhengBtn.hidden=NO;
            repeatSMSBtn.hidden=YES;
            [_timer2 invalidate];
            [_timer1 invalidate];
            count = 0;
        }
        if (1==buttonIndex) {
            ;
        }
    }
    if (alertView == _alert3) {
        if (buttonIndex == 0) {
            /**
             重置成功进入登录界面
             */
            LoginViewController *loginVC = [[LoginViewController alloc]init];
            loginVC.isChangePassword = YES;
            [self.navigationController pushViewController:loginVC animated:YES];
            
            [[SoundTools sharedSoundTools] playSoundWithName:@"ui_click_in"];

        }
    }
}

#pragma mark - 获取验证码
-(void)getVerifyCode
{
    [_timer2 invalidate];
    [_timer1 invalidate];
    //显示“重新获取”按钮
    _timer1 = [NSTimer scheduledTimerWithTimeInterval:60
                                               target:self
                                             selector:@selector(showRepeatButton)
                                             userInfo:nil
                                              repeats:YES];
    //倒计时
    _timer2 = [NSTimer scheduledTimerWithTimeInterval:1
                                               target:self
                                             selector:@selector(updateTime)
                                             userInfo:nil
                                              repeats:YES];
    [SMS_SDK getVerificationCodeBySMSWithPhone:numTextField.text zone:@"86" result:^(SMS_SDKError *error) {
        
        if (!error) {
            PLog(@"获取验证码成功");
        } else {
            PLog(@"错误吗：%zi,错误描述：%@",error.errorCode,error.errorDescription);
            [aCommon iToast:error.errorDescription];
            yanzhengBtn.hidden=YES;
            repeatSMSBtn.hidden=NO;
            count = 0;
        }
        
    }];
    
}

-(void)updateTime
{
    count++;
    if (count>=60) {
        [_timer2 invalidate];
        return;
    }
    //PLog(@"更新时间");
    yanzhengBtn.backgroundColor = [UIColor lightGrayColor];
    yanzhengBtn.userInteractionEnabled = NO;
    [yanzhengBtn setTitle:[NSString stringWithFormat:@"倒计时%i%@",60-count,NSLocalizedString(@"秒", nil)] forState:UIControlStateNormal];
}

-(void)showRepeatButton{
    yanzhengBtn.hidden=YES;
    repeatSMSBtn.hidden=NO;
    [_timer1 invalidate];
    return;
}

#pragma mark -重新获取验证码
-(void)CannotGetSMS
{
    if ( [aCommon isBlankString:numTextField.text] ){
        [aCommon iToast:@"请输入您的手机号码~"];
    }else if ( numTextField.text.length == 11 ) {
        PLog(@"验证码按钮事件");
        [self.view endEditing:YES];
        _array=[NSMutableArray array];
        //获取支持的地区列表
        [SMS_SDK getZone:^(enum SMS_ResponseState state, NSArray *array) {
            if (1==state)
            {
                PLog(@"获取区号成功");
                //区号数据
                _array=[NSMutableArray arrayWithArray:array];
            }
            else if (0==state)
            {
                PLog(@"获取区号失败");
            }
        }];
        
        for (int i=0; i<_array.count; i++) {
            NSDictionary* dict1=[_array objectAtIndex:i];
            NSString* code1=[dict1 valueForKey:@"zone"];
            if ([code1 isEqualToString:@"86"]) {
                NSString* rule1=[dict1 valueForKey:@"rule"];
                NSPredicate* pred=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",rule1];
                BOOL isMatch=[pred evaluateWithObject:numTextField.text];
                if (!isMatch) {
                    [[SoundTools sharedSoundTools] playSoundWithName:@"ui_warning"];

                    //手机号码不正确
                    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"友情提示", nil) message:NSLocalizedString(@"手机号码不合法", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"确定", nil) otherButtonTitles:nil, nil];
                    [alert show];
                    return;
                }
                break;
            }
        }
        [[SoundTools sharedSoundTools] playSoundWithName:@"ui_warning"];

        NSString* str=[NSString stringWithFormat:@"%@:%@ %@",NSLocalizedString(@"重新发送验证码至该号码", nil) ,@"+86",numTextField.text];
        UIAlertView* alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"友情提示", nil) message:str delegate:self cancelButtonTitle:NSLocalizedString(@"取消", nil) otherButtonTitles:NSLocalizedString(@"确定", nil), nil];
        _alert1=alert;
        [alert show];
    }else {
        [aCommon iToast:@"输入合法的手机号码哦~"];
    }
}

#pragma mark - UITextFieldDelegate 验证码输入结束判断验证码是否正确
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [self.view endEditing:YES];
    if (self.isRegisterVC == YES) {
        if ([textField.text isEqual: verTextField.text] && (verTextField.text.length == 4))
        {
            //验证号码
            //验证成功后 获取通讯录 上传通讯录
            //
            
            [SMS_SDK commitVerifyCode:verTextField.text result:^(enum SMS_ResponseState state) {
                if (1==state) {
                    PLog(@"验证成功");
                    [aCommon iToast:@"验证成功"];
                    
                    //解决等待时间乱跳的问题
                    [_timer2 invalidate];
                    [_timer1 invalidate];
                    
                    yanzhengBtn.backgroundColor = RgbColor(35, 173, 92);
                    [yanzhengBtn setTitle:@"验证成功" forState:UIControlStateNormal];
                    _originalPhone = numTextField.text;
                    
                }
                else if(0==state)
                {
                    PLog(@"验证失败");
                    [aCommon iToast:@"验证失败"];
                    yanzhengBtn.hidden=YES;
                    repeatSMSBtn.hidden=NO;
                    verTextField.text = @"";
                    verTextField.placeholder = @" 请输入手机验证码";
                }
            }];
            
        }else if ([textField.text isEqual: verTextField.text] && (verTextField.text.length == 0)){
            
        }else if ([textField.text isEqual: verTextField.text]){
            [aCommon iToast:@"验证码错误"];
            yanzhengBtn.hidden=YES;
            repeatSMSBtn.hidden=NO;
            verTextField.text = @"";
            verTextField.placeholder = @" 请输入手机验证码";
        }
    }else{
        
    }
    
    return YES;
}

/**
 *  注册按钮
 */
- (void)registerButtonEvent:(UIButton *)btn
{
    if ([btn.titleLabel.text isEqualToString:@"立即注册"]) {
        PLog(@"注册按钮事件");
        if ([aCommon isBlankString:nameTextField.text]) {
            [aCommon iToast:@"请输入您的姓名~"];
        }else if ( nameTextField.text.length > 20 ){
            [aCommon iToast:@"姓名不能超过20位"];
        }else if ([_originalPhone isEqualToString:@""]){
            [aCommon iToast:@"请获取验证码~"];
        }else if (![_originalPhone isEqualToString:numTextField.text]) {
            [aCommon iToast:@"修改手机号,要重新获取验证码~"];
        }else if (passWTextField.text.length < 6 || passWTextField.text.length>20) {
            [aCommon iToast:@"密码6-20位的组合~"];
        }else if (emailTextField.text.length == 0) {
            [aCommon iToast:@"请输入您的邮箱~"];
        }else if (![aCommon validateEmail:emailTextField.text]) {
            [aCommon iToast:@"输入邮箱不合法~"];
        }else if (pId.length==0) {
            [aCommon iToast:@"请选择省~"];
        }else if (cId.length==0) {
            [aCommon iToast:@"请选择市~"];
        }else if (dId.length==0) {
            [aCommon iToast:@"请选择区~"];
        }else{
            if ([cId isEqualToString:@" "]) {
                cId = @"";
            }
            if ([dId isEqualToString:@" "]) {
                dId = @"";
            }
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            LearningPlanRequest *request = [[LearningPlanRequest alloc]init];
            [request userUserRegistWithTel:[numTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]  andPassword:passWTextField.text andNickName:[nameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] andPId:pId andCId:cId andDId:dId email:emailTextField.text success:^(id obj) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                InfoResult *infoResult = (InfoResult *)obj;
                if ([infoResult.code isEqualToString:@"0"]) {
                    [self showSucessHUD:@"注册成功~"];
                    
                    if ([UserDefaultsUtils boolValueWithKey:ISINNER]) {
                        [UserDefaultsUtils saveValue:nameTextField.text forKey:INNER_MYNAME];
                        [UserDefaultsUtils saveValue:numTextField.text forKey:INNER_MYPHONE];
                        [UserDefaultsUtils saveValue:passWTextField.text forKey:INNER_MYPASSWORD];
                    }else{
                        [UserDefaultsUtils saveValue:nameTextField.text forKey:OUT_MYNAME];
                        [UserDefaultsUtils saveValue:numTextField.text forKey:OUT_MYPHONE];
                        [UserDefaultsUtils saveValue:passWTextField.text forKey:OUT_MYPASSWORD];
                    }
                    
                    UserLoginModel *loginModel = [[UserLoginModel alloc] init];
                    loginModel = (UserLoginModel *)[infoResult extraObj];
                    
                    [UserDefaultsUtils saveValue:loginModel.token forKey:USER_TOKEN];
                    [UserDefaultsUtils saveValue:loginModel.uId forKey:USER_ID];
                    [UserDefaultsUtils saveValue:loginModel.uName forKey:USER_NAME];
                    [UserDefaultsUtils saveValue:loginModel.uCampus forKey:USER_CAMPUS];
                    [UserDefaultsUtils saveValue:loginModel.uClass forKey:USER_CLASS];
                    [UserDefaultsUtils saveValue:loginModel.uAvatar forKey:USER_AVATAR];
                    [UserDefaultsUtils saveValue:loginModel.schoolID forKey:USER_SCHOOLID];
                    [UserDefaultsUtils saveValue:loginModel.classID forKey:USER_CLASSID];
                    [UserDefaultsUtils saveValue:loginModel.sTime forKey:USER_STIME];
                    [UserDefaultsUtils saveValue:loginModel.ccAmount forKey:USER_CCAMOUNT];
                    [UserDefaultsUtils saveValue:loginModel.vipEndDate forKey:USER_VIPENDDATE];
                    [UserDefaultsUtils saveValue:loginModel.vipStatus forKey:USER_VIPSTATUS];
                    [UserDefaultsUtils saveValue:loginModel.expiresIn forKey:USER_EXPIREIN];
                    [UserDefaultsUtils saveValue:loginModel.level forKey:USER_LEVEL];
                    [UserDefaultsUtils saveValue:loginModel.aCCNum forKey:USER_ACCNUM];
                    /**
                     注册成功进入界面
                     */
                    StudyPlanViewController *planViewController = [[StudyPlanViewController alloc]init];
                    planViewController.planType = 0;
                    [UserDefaultsUtils saveBoolValue:YES withKey:WHETHERTHECANCELLATION];
                    [self.navigationController pushViewController:planViewController animated:YES];
                    [[SoundTools sharedSoundTools] playSoundWithName:@"ui_click_in"];

                }else{
                    [aCommon iToast:infoResult.desc];
                }
                
            } failed:^(id obj) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            }];
        }
    }else if ([btn.titleLabel.text isEqualToString:@"密码重置"]){
        _originalPhone = numTextField.text;
        
        if ([aCommon isBlankString:nameTextField.text]) {
            [aCommon iToast:@"请输入您的姓名~"];
        }else if ( nameTextField.text.length > 20 ){
            [aCommon iToast:@"姓名不能超过20位"];
        }else if ([_originalPhone isEqualToString:@""]){
            [aCommon iToast:@"请获取验证码~"];
        }else if (![_originalPhone isEqualToString:numTextField.text]) {
            [aCommon iToast:@"修改手机号,要重新获取验证码~"];
        }else{
            //验证号码
            //验证成功后 获取通讯录 上传通讯录
            //
            
            [SMS_SDK commitVerifyCode:verTextField.text result:^(enum SMS_ResponseState state) {
                if (1==state) {
                    PLog(@"验证成功");
                    
                    //解决等待时间乱跳的问题
                    [_timer2 invalidate];
                    [_timer1 invalidate];
                    
                    yanzhengBtn.backgroundColor = RgbColor(35, 173, 92);
                    [yanzhengBtn setTitle:@"验证成功" forState:UIControlStateNormal];
                    _originalPhone = numTextField.text;
                    
                    
                    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    LearningPlanRequest *request = [[LearningPlanRequest alloc]init];
                    [request userRequestupdatePassWordWithAccount:[nameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] andTel:[numTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] success:^(id obj) {
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        NSDictionary *resultDic = (NSDictionary *)obj;
                        if ([[resultDic objectForKey:@"code"] isEqualToString:@"0"]) {
                            
                            [[SoundTools sharedSoundTools] playSoundWithName:@"ui_warning"];

                            NSString *msg = [NSString stringWithFormat:@"密码重置成功！当前密码为：%@。 请牢记你的密码。",[resultDic objectForKey:@"data"]];
                            _alert3 = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                            _alert3.delegate = self;
                            [_alert3 show];
                            
                        }else{
                            [aCommon iToast:[resultDic objectForKey:@"desc"]];
                        }
                        
                    } failed:^(id obj) {
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                    }];
                }
                else if(0==state)
                {
                    PLog(@"验证失败");
                    [aCommon iToast:@"验证失败"];
                    yanzhengBtn.hidden=YES;
                    repeatSMSBtn.hidden=NO;
                    verTextField.text = @"";
                    verTextField.placeholder = @" 请输入手机验证码";
                }
            }];
        }
    }
}

#pragma mark ------CustomButtonDelegate-------
/**
 *  省市区的选择，以及等级的选择
 *
 *  @param btn tag值
 */
- (void)chooseDifferentCategoriesWithTag:(NSInteger)tag
{
    [self.view endEditing:YES];
    switch (tag) {
        case 101:
        {
            if (_proviceArray.count) {
                ZJAlertView *alert = [[ZJAlertView alloc]initWithTitle:@"请选择省" andSelect:provinceBtn.leftLabel.text andContent:_proviceArray WithBlock:^(NSString *why, int tag, int isSelect) {
                    if (tag == 0 && why.length !=0 ) {
                        provinceBtn.leftLabel.text = why;
                        cityBtn.leftLabel.text = @"请选择市";
                        areaBtn.leftLabel.text = @"请选择区";
                        _provinceModel = [_listModel.provinceList objectAtIndex:isSelect];
                        pId = _provinceModel.pId;
                        cId = @"";
                        dId = @"";
                    }
                }];
                [self.view addSubview:alert];
            }else{
                [aCommon iToast:@"无数据~"];
            }
            
        }
            break;
        case 102:
        {
            
            if ([provinceBtn.leftLabel.text isEqualToString:@"请选择省"]) {
                [aCommon iToast:@"你前面没选好哦~"];
            }else{
                
                _cityArray = [[NSMutableArray alloc]init];
                for (int i = 0; i < _provinceModel.cityList.count ; i ++ ) {
                    CityDataModel *dataModel = [_provinceModel.cityList objectAtIndex:i];
                    [_cityArray addObject:dataModel.city];
                }
                if (_cityArray.count) {
                    ZJAlertView *alert = [[ZJAlertView alloc]initWithTitle:@"请选择市" andSelect:cityBtn.leftLabel.text andContent:_cityArray WithBlock:^(NSString *why, int tag, int isSelect) {
                        if (tag == 0 && why.length !=0 ) {
                            cityBtn.leftLabel.text = why;
                            areaBtn.leftLabel.text = @"请选择区";
                            _cityModel = [_provinceModel.cityList objectAtIndex:isSelect];
                            cId = _cityModel.cId;
                            dId = @"";
                        }
                    }];
                    [self.view addSubview:alert];
                }else{
                    [aCommon iToast:@"无数据~"];
                    cId = @" ";
                    dId = @" ";
                }
                
            }
           
        }
            break;
        case 103:
        {
            if ([cityBtn.leftLabel.text isEqualToString:@"请选择市"]) {
                [aCommon iToast:@"你前面没选好哦~"];
            }else{
                
                _areaArray = [[NSMutableArray alloc]init];
                for (int i = 0; i < _cityModel.districtList.count ; i ++ ) {
                    DistrictDataModel *dataModel = [_cityModel.districtList objectAtIndex:i];
                    [_areaArray addObject:dataModel.district];
                }
                if (_areaArray.count) {
                    ZJAlertView *alert = [[ZJAlertView alloc]initWithTitle:@"请选择区" andSelect:areaBtn.leftLabel.text andContent:_areaArray WithBlock:^(NSString *why, int tag, int isSelect) {
                        if (tag == 0 && why.length !=0 ) {
                            areaBtn.leftLabel.text = why;
                            _areaModel = [_cityModel.districtList objectAtIndex:isSelect];
                            dId = _areaModel.dId;
                        }
                    }];
                    [self.view addSubview:alert];
                }else{
                    [aCommon iToast:@"无数据~"];
                    dId = @" ";
                }
            }
        }
            break;

        default:
            break;
    }
}

-(void)tapGestureRecognizer
{
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.10f delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.view.frame =CGRectMake(0, 0, MainScreenSize_W, MainScreenSize_H);
    } completion:^(BOOL finished)
     {
         
     }];
}

#pragma mark - UITextviewdelegate 实现代理方法
//开始编辑输入框的时候，软键盘出现，执行此事件
//-(void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    CGRect frame = textField.frame;
//    int offset = frame.origin.y + 32 +textField.frame.size.height - (self.view.frame.size.height - 216.0);//键盘高度216
//    
//    NSTimeInterval animationDuration = 0.30f;
//    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
//    [UIView setAnimationDuration:animationDuration];
//    
//    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
//    if(offset > 0)
//        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
//    
//    [UIView commitAnimations];
//}

#pragma mark 开始编辑UITextField，本人试过这个方法在keyboardWillShow之前被调用

-(void)textFieldDidBeginEditing:(UITextField*)textField{
    
    _checkText = textField;//设置被点击的对象
    
    
}

//当用户按下return键或者按回车键，keyboard消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

- (void) keyboardWasShown:(NSNotification *) notif

{
    
    if (nil == _checkText) {
        
        return;
        
    }
    
    NSDictionary *userInfo = [notif userInfo];
    
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect = [aValue CGRectValue];
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    
    NSTimeInterval animationDuration;
    
    [animationDurationValue getValue:&animationDuration];
    
    CGRect textFrame = _checkText.frame;//当前UITextField的位置
    
    float textY = textFrame.origin.y + textFrame.size.height;//得到UITextField下边框距离顶部的高度
    
    float bottomY = self.view.frame.size.height - textY;//得到下边框到底部的距离
    
    if(bottomY >=keyboardRect.size.height ){//键盘默认高度,如果大于此高度，则直接返回
        
        return;
        
    }
    
    float moveY = keyboardRect.size.height - bottomY;
    
    [self moveInputBarWithKeyboardHeight:moveY withDuration:animationDuration];
}

- (void) keyboardWasHidden:(NSNotification *) notif

{
    
    NSDictionary* userInfo = [notif userInfo];
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    
    NSTimeInterval animationDuration;
    
    [animationDurationValue getValue:&animationDuration];
    
    [self moveInputBarWithKeyboardHeight:0.0 withDuration:animationDuration];
    
}

#pragma mark 移动view

-(void)moveInputBarWithKeyboardHeight:(float)_CGRectHeight withDuration:(NSTimeInterval)_NSTimeInterval{

    CGRect rect = self.view.frame;
    
    NSTimeInterval animationDuration = 0.20f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    rect.origin.y = -_CGRectHeight;//view往上移动
    
    self.view.frame = rect;
    
    [UIView commitAnimations];
    
    
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];//在视图控制器消除时，移除键盘事件的通知
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
