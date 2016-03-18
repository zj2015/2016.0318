//
//  LoginViewController.m
//  MRobot
//
//  Created by mac on 15/8/20.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "LoginViewController.h"
#import "MainViewController.h"
#import "StudyPlanViewController.h"
#import "RegisterViewController.h"
#import "UserLoginModel.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;

    if (self.isChangePassword == YES) {
        _accountField.text = @"";
        _telField.text = @"";
        _passwordField.text = @"";
    }else{
        if ([UserDefaultsUtils boolValueWithKey:ISINNER]) {
            _accountField.text = [UserDefaultsUtils valueWithKey:INNER_MYNAME];
            _telField.text = [UserDefaultsUtils valueWithKey:INNER_MYPHONE];
            _passwordField.text = [UserDefaultsUtils valueWithKey:INNER_MYPASSWORD];
        }else{
            _accountField.text = [UserDefaultsUtils valueWithKey:OUT_MYNAME];
            _telField.text = [UserDefaultsUtils valueWithKey:OUT_MYPHONE];
            _passwordField.text = [UserDefaultsUtils valueWithKey:OUT_MYPASSWORD];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITapGestureRecognizer * TapGesturRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureRecognizer)];
    [self.view addGestureRecognizer:TapGesturRecognizer];
    
    UIImageView *bgImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, MainScreenSize_W, MainScreenSize_H)];
    bgImgView.image = [UIImage imageNamed:@"loginBg"];
    [self.view addSubview:bgImgView];
    
    _logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 50*SIZE_TIMES, MainScreenSize_W - 40, 84*SIZE_TIMES)];
    [self.view addSubview:_logoImageView];
    
#if TARGET_VERSION_LITE ==1
    //target（中考校内版）需要执行的代码
    _logoImageView.image = [UIImage imageNamed:@"LOGO"];
    bgImgView.hidden = YES;
    
#elif TARGET_VERSION_LITE ==2
    //target（中考校外版）需要执行的代码
    _logoImageView.image = [UIImage imageNamed:@"LOGO"];
    bgImgView.hidden = YES;
    
#elif TARGET_VERSION_LITE ==3
    //target（高考校内版）需要执行的代码
    _logoImageView.image = [UIImage imageNamed:@"cclogo"];
    bgImgView.hidden = NO;
    
#elif TARGET_VERSION_LITE ==4
    //target（高考校外版）需要执行的代码
    _logoImageView.image = [UIImage imageNamed:@"cclogo"];
    bgImgView.hidden = NO;
#endif
    
    _telField = [[UITextField alloc]initWithFrame:CGRectMake(20, 180*SIZE_TIMES, MainScreenSize_W-40, 35*SIZE_TIMES)];
    _telField.borderStyle = UITextBorderStyleRoundedRect;
    _telField.keyboardType = UIKeyboardTypeNumberPad;
    _telField.returnKeyType =UIReturnKeyDone;
    _telField.delegate = self;
    _telField.placeholder = @"请输入您的手机号码";
    [self.view addSubview:_telField];
    
    UIView *leftView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40*SIZE_TIMES, 35*SIZE_TIMES)];
    UIImageView * leftImage1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40*SIZE_TIMES, 35*SIZE_TIMES)];
    leftImage1.image = [UIImage imageNamed:@"tel"];
    [leftView1 addSubview:leftImage1];
    _telField.leftView = leftView1;
    _telField.leftViewMode = UITextFieldViewModeAlways;
    
    _accountField = [[UITextField alloc]initWithFrame:CGRectMake(20, _telField.bottom + 10, MainScreenSize_W-40, 35*SIZE_TIMES)];
    _accountField.borderStyle = UITextBorderStyleRoundedRect;
    _accountField.returnKeyType =UIReturnKeyDone;
    _accountField.delegate = self;
    _accountField.placeholder = @"请输入您的姓名";
    [self.view addSubview:_accountField];
    
    UIView *leftView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40*SIZE_TIMES, 35*SIZE_TIMES)];
    UIImageView * leftImage2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40*SIZE_TIMES, 35*SIZE_TIMES)];
    leftImage2.image = [UIImage imageNamed:@"user"];
    [leftView2 addSubview:leftImage2];
    _accountField.leftView = leftView2;
    _accountField.leftViewMode = UITextFieldViewModeAlways;
    
    _passwordField = [[UITextField alloc]initWithFrame:CGRectMake(20, _accountField.bottom + 10, MainScreenSize_W-40, 35*SIZE_TIMES)];
    _passwordField.secureTextEntry = YES;
    _passwordField.returnKeyType =UIReturnKeyDone;
    _passwordField.delegate = self;
    _passwordField.borderStyle = UITextBorderStyleRoundedRect;
    _passwordField.placeholder = @"请输入您的密码";
    [self.view addSubview:_passwordField];
    
    UIView *leftView3 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40*SIZE_TIMES, 35*SIZE_TIMES)];
    UIImageView * leftImage3 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40*SIZE_TIMES, 35*SIZE_TIMES)];
    leftImage3.image = [UIImage imageNamed:@"password"];
    [leftView3 addSubview:leftImage3];
    _passwordField.leftView = leftView3;
    _passwordField.leftViewMode = UITextFieldViewModeAlways;
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(20, _passwordField.bottom + 20, (MainScreenSize_W-40) , 35*SIZE_TIMES);
    loginBtn.layer.masksToBounds = YES;
    loginBtn.layer.cornerRadius = 4;
    loginBtn.backgroundColor = RgbColor(169, 20, 24);
    loginBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [loginBtn setTitle:@"登  录" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [registerBtn setTitle:@"注  册" forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(registerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    
    UIButton *changePasswordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    changePasswordBtn.layer.masksToBounds = YES;
    changePasswordBtn.layer.cornerRadius = 4;
    changePasswordBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [changePasswordBtn setTitle:@"密码重置" forState:UIControlStateNormal];
    [changePasswordBtn addTarget:self action:@selector(changePasswordClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changePasswordBtn];
    
#if TARGET_VERSION_LITE ==1
    //target（中考校内版）需要执行的代码
    if ([UserDefaultsUtils boolValueWithKey:ISINNER]) {
        registerBtn.hidden = YES;
        changePasswordBtn.frame = CGRectMake(0, MainScreenSize_H - 40*SIZE_TIMES, MainScreenSize_W , 40*SIZE_TIMES);
        changePasswordBtn.layer.borderWidth = 0.5;
        changePasswordBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        changePasswordBtn.backgroundColor = RgbColor(254, 254, 254);
        [changePasswordBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }else{
        //target（中考校外版）需要执行的代码
        registerBtn.hidden = NO;
        registerBtn.frame = CGRectMake((MainScreenSize_W - 130*SIZE_TIMES*2)/3, MainScreenSize_H - 40*SIZE_TIMES, 130*SIZE_TIMES , 35*SIZE_TIMES);
        registerBtn.layer.masksToBounds = YES;
        registerBtn.layer.cornerRadius = 4;
        registerBtn.layer.borderWidth = 0.5;
        registerBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        registerBtn.backgroundColor = RgbColor(254, 254, 254);
        [registerBtn setTitleColor:PView_GreenColor forState:UIControlStateNormal];
        
        changePasswordBtn.frame = CGRectMake((MainScreenSize_W - 130*SIZE_TIMES*2)/3*2+ 130*SIZE_TIMES, MainScreenSize_H - 40*SIZE_TIMES, 130*SIZE_TIMES , 35*SIZE_TIMES);
        changePasswordBtn.backgroundColor = [UIColor lightGrayColor];
    }
    
#elif TARGET_VERSION_LITE ==2
    //target（中考校外版）需要执行的代码
    registerBtn.hidden = NO;
    registerBtn.layer.masksToBounds = YES;
    registerBtn.layer.cornerRadius = 4;
    registerBtn.layer.borderWidth = 0.5;
    registerBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    registerBtn.backgroundColor = RgbColor(254, 254, 254);
    [registerBtn setTitleColor:PView_GreenColor forState:UIControlStateNormal];
    
#elif TARGET_VERSION_LITE ==3
    //target（高考校内版）需要执行的代码
    if ([UserDefaultsUtils boolValueWithKey:ISINNER]) {
        registerBtn.hidden = YES;
        changePasswordBtn.frame = CGRectMake(0, MainScreenSize_H - 40*SIZE_TIMES, MainScreenSize_W , 40*SIZE_TIMES);
        changePasswordBtn.layer.borderWidth = 0.5;
        changePasswordBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        changePasswordBtn.backgroundColor = RgbColor(254, 254, 254);
        [changePasswordBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }else{
        //target（高考校外版）需要执行的代码
        registerBtn.hidden = NO;
        registerBtn.frame = CGRectMake((MainScreenSize_W - 130*SIZE_TIMES*2)/3, MainScreenSize_H - 40*SIZE_TIMES, 130*SIZE_TIMES , 35*SIZE_TIMES);
        registerBtn.layer.masksToBounds = YES;
        registerBtn.layer.cornerRadius = 4;
        registerBtn.layer.borderWidth = 0.5;
        registerBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        registerBtn.backgroundColor = RgbColor(254, 254, 254);
        [registerBtn setTitleColor:PView_GreenColor forState:UIControlStateNormal];
        
        changePasswordBtn.frame = CGRectMake((MainScreenSize_W - 130*SIZE_TIMES*2)/3*2+ 130*SIZE_TIMES, MainScreenSize_H - 40*SIZE_TIMES, 130*SIZE_TIMES , 35*SIZE_TIMES);
        changePasswordBtn.backgroundColor = [UIColor lightGrayColor];
    }
    
#elif TARGET_VERSION_LITE ==4
    //target（高考校外版）需要执行的代码
    registerBtn.hidden = NO;
    [registerBtn setTitleColor:[UIColor colorWithRed:173/255.0 green:25/255.0 blue:41/255.0 alpha:1] forState:UIControlStateNormal];
    
#endif
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(keyboardWasHidden:) name:UIKeyboardDidHideNotification object:nil];
    
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

- (void)changePasswordClick:(UIButton *)btn
{
    
    [[SoundTools sharedSoundTools] playSoundWithName:@"ui_click_in"];

    
    RegisterViewController *resisetVC = [[RegisterViewController alloc]init];
    resisetVC.isRegisterVC = NO;
    [self.navigationController pushViewController:resisetVC animated:YES];
}

- (void)click:(UIButton *)btn
{
    [self.view endEditing:YES];
    if ([aCommon isBlankString:_telField.text]) {
        [aCommon iToast:@"手机号码不能为空"];
    }else if ([aCommon isBlankString:_accountField.text]) {
        [aCommon iToast:@"姓名不能为空"];
    }else  if ([aCommon isBlankString:_passwordField.text]){
        [aCommon iToast:@"密码不能为空"];
    }else{
        [self login];
    }
    
}

- (void)login
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    LearningPlanRequest *request = [[LearningPlanRequest alloc]init];
    [request userUserLoginWithAccount:[_accountField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] andTel:_telField.text andPassword:_passwordField.text success:^(id obj) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        InfoResult *infoResult = (InfoResult *)obj;
        if ([infoResult.code isEqualToString:@"0"]) {
            UserLoginModel *loginModel = [[UserLoginModel alloc] init];
            loginModel = (UserLoginModel *)[infoResult extraObj];
            
            if ([UserDefaultsUtils boolValueWithKey:ISINNER]) {
                [UserDefaultsUtils saveValue:_accountField.text forKey:INNER_MYNAME];
                [UserDefaultsUtils saveValue:_telField.text forKey:INNER_MYPHONE];
                [UserDefaultsUtils saveValue:_passwordField.text forKey:INNER_MYPASSWORD];
            }else{
                [UserDefaultsUtils saveValue:_accountField.text forKey:OUT_MYNAME];
                [UserDefaultsUtils saveValue:_telField.text forKey:OUT_MYPHONE];
                [UserDefaultsUtils saveValue:_passwordField.text forKey:OUT_MYPASSWORD];
            }
            
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
            
            MainViewController *mainViewController = [[MainViewController alloc]init];
            [UserDefaultsUtils saveBoolValue:NO withKey:WHETHERTHECANCELLATION];
            self.view.window.rootViewController = mainViewController;
            
        }else if ([infoResult.code isEqualToString:@"30017"]){
            UserLoginModel *loginModel = [[UserLoginModel alloc] init];
            loginModel = (UserLoginModel *)[infoResult extraObj];
            [UserDefaultsUtils saveValue:loginModel.token forKey:USER_TOKEN];
            PLog(@"$%@",[UserDefaultsUtils valueWithKey:USER_TOKEN]);
            // 更改学习计划
            StudyPlanViewController *planViewController = [[StudyPlanViewController alloc]init];
            planViewController.planType = 0;
            [UserDefaultsUtils saveBoolValue:YES withKey:WHETHERTHECANCELLATION];
            [self.navigationController pushViewController:planViewController animated:YES];
            
        }else{
            [aCommon iToast:infoResult.desc];
        }
        
    } failed:^(id obj) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (void)registerBtnClick:(UIButton *)btn
{
    
    [[SoundTools sharedSoundTools] playSoundWithName:@"ui_click_in"];

    
    RegisterViewController *resisetVC = [[RegisterViewController alloc]init];
    resisetVC.isRegisterVC = YES;
    [self.navigationController pushViewController:resisetVC animated:YES];
    
}

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

- (void) keyboardWasShown:(NSNotification *) notif{
        
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

- (UIStatusBarStyle)preferredStatusBarStyle
{
    if (iOS7) {
        return UIStatusBarStyleLightContent;
    }else
    {
        return UIStatusBarStyleDefault;
    }
    
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
