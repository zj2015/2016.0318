//
//  StudyPlanViewController.m
//  MRobot
//
//  Created by mac on 15/9/16.
//  Copyright © 2015年 silysolong. All rights reserved.
//

#import "StudyPlanViewController.h"
#import "LoginViewController.h"
#import "UserLoginModel.h"
#import "InfoResult.h"
#import "MainViewController.h"
#import "BaseNavigationController.h"
@interface StudyPlanViewController ()

@end

// zzh_xf
@implementation StudyPlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self base_changeNavigationTitleWithString:@"更改学习计划"];
    
    if (_planType) {
        [self base_createLeftNavigationBarButtonWithFrontImage:nil andSelectedImageName:nil andBackGroundImageName:@"back" andTitle:nil andSize:CGSizeMake(40, 30)];
    }else{
        [self base_createLeftNavigationBarButtonWithFrontImage:nil andSelectedImageName:nil andBackGroundImageName:nil andTitle:nil andSize:CGSizeMake(0, 0)];
    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)base_navigation_LeftBarButtonPressed
{
    
    [[SoundTools sharedSoundTools] playSoundWithName:@"ui_click_out"];

    if (_planType) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        
    }
}

- (void)_prepareUI
{
    
    UIButton *normalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    normalBtn.frame = CGRectMake(50*SIZE_TIMES, 100*SIZE_TIMES, MainScreenSize_W - 100*SIZE_TIMES, 40*SIZE_TIMES);
    normalBtn.tag = 101;
    normalBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [normalBtn addTarget:self action:@selector(changeTheClass:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:normalBtn];
    
    UIButton *topBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    topBtn.frame = CGRectMake(50*SIZE_TIMES, normalBtn.bottom + 20*SIZE_TIMES, MainScreenSize_W - 100*SIZE_TIMES, 40*SIZE_TIMES);
    topBtn.tag = 102;
    topBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [topBtn addTarget:self action:@selector(changeTheClass:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topBtn];
    
#if TARGET_VERSION_LITE ==1
    //target（中考校内版）需要执行的代码
    [normalBtn setTitle:@"中考普通班" forState:UIControlStateNormal];
    [topBtn setTitle:@"中考进阶班" forState:UIControlStateNormal];
    
#elif TARGET_VERSION_LITE ==2
    //target（中考校外版）需要执行的代码
    [normalBtn setTitle:@"中考普通班" forState:UIControlStateNormal];
    [topBtn setTitle:@"中考进阶班" forState:UIControlStateNormal];
    
#elif TARGET_VERSION_LITE ==3
    //target（高考校内版）需要执行的代码
    [normalBtn setTitle:@"高考普通班" forState:UIControlStateNormal];
    [topBtn setTitle:@"高考进阶班" forState:UIControlStateNormal];
    
#elif TARGET_VERSION_LITE ==4
    //target（高考校外版）需要执行的代码
    [normalBtn setTitle:@"高考普通班" forState:UIControlStateNormal];
    [topBtn setTitle:@"高考进阶班" forState:UIControlStateNormal];
#endif
    
    if (_planType) {
        if ([[UserDefaultsUtils valueWithKey:USER_LEVEL] isEqualToString:@"0"]) {
            //普通班
            normalBtn.backgroundColor = [UIColor lightGrayColor];
            topBtn.backgroundColor = RgbColor(35, 174, 92);
            normalBtn.userInteractionEnabled = NO;
        }else if ([[UserDefaultsUtils valueWithKey:USER_LEVEL] isEqualToString:@"1"]){
            //进阶班
            normalBtn.backgroundColor = RgbColor(35, 174, 92);
            topBtn.backgroundColor = [UIColor lightGrayColor];
            topBtn.userInteractionEnabled = NO;
        }else{
            normalBtn.backgroundColor = RgbColor(35, 174, 92);
            topBtn.backgroundColor = RgbColor(35, 174, 92);
        }
    }else{
        normalBtn.backgroundColor = RgbColor(35, 174, 92);
        topBtn.backgroundColor = RgbColor(35, 174, 92);
    }
    
}

- (void)changeTheClass:(UIButton *)button
{
    if (_planType) {
        NSString *name = nil;
        
#if TARGET_VERSION_LITE ==1
        //target（中考校内版）需要执行的代码
        if (button.tag == 101) {
            name = @"确定要修改为中考普通班";
        }else if (button.tag == 102){
            name = @"确定要修改为中考进阶班";
        }
        
#elif TARGET_VERSION_LITE ==2
        //target（中考校外版）需要执行的代码
        if (button.tag == 101) {
            name = @"确定要修改为中考普通班";
        }else if (button.tag == 102){
            name = @"确定要修改为中考进阶班";
        }
        
#elif TARGET_VERSION_LITE ==3
        //target（高考校内版）需要执行的代码
        if (button.tag == 101) {
            name = @"确定要修改为高考普通班";
        }else if (button.tag == 102){
            name = @"确定要修改为高考进阶班";
        }
        
#elif TARGET_VERSION_LITE ==4
        //target（高考校外版）需要执行的代码
        if (button.tag == 101) {
            name = @"确定要修改为高考普通班";
        }else if (button.tag == 102){
            name = @"确定要修改为高考进阶班";
        }
#endif
        [[SoundTools sharedSoundTools] playSoundWithName:@"ui_warning"];

        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"友情提示" message:name delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag = button.tag;
        [alert show];
    }else{
        [self requestWithAlert:button.tag];
    }
    
}

- (void)requestWithAlert:(NSInteger)tag
{
    switch (tag) {
        case 101:
        {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            LearningPlanRequest *request = [[LearningPlanRequest alloc]init];
            [request userRequestChangePlanWithlevel:@"0" success:^(id obj) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                InfoResult *infoResult = (InfoResult *)obj;
                if ([infoResult.code isEqualToString:@"0"]) {
                    if (_planType) {
                        [aCommon iToast:@"已经更改为普通班~"];
                    }else{
                        [aCommon iToast:@"已经选定普通班~"];
                    }
                    [self login];
                }
            } failed:^(id obj) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            }];
            
        }
            break;
        case 102:
        {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            LearningPlanRequest *request = [[LearningPlanRequest alloc]init];
            [request userRequestChangePlanWithlevel:@"1" success:^(id obj) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                InfoResult *infoResult = (InfoResult *)obj;
                if ([infoResult.code isEqualToString:@"0"]) {
                    if (_planType) {
                        [aCommon iToast:@"已经更改为进阶班~"];
                    }else{
                        [aCommon iToast:@"已经选定进阶班~"];
                    }
                   
                    [self login];
                    
                }
            } failed:^(id obj) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            }];
        }
            break;
        default:
            break;
    }
}

- (void)login
{
    NSString *myName = nil;
    NSString *myPhone = nil;
    NSString *myPassword = nil;
    if ([UserDefaultsUtils boolValueWithKey:ISINNER]) {
        myName = [UserDefaultsUtils valueWithKey:INNER_MYNAME];
        myPhone = [UserDefaultsUtils valueWithKey:INNER_MYPHONE];
        myPassword = [UserDefaultsUtils valueWithKey:INNER_MYPASSWORD];
    }else{
        myName = [UserDefaultsUtils valueWithKey:OUT_MYNAME];
        myPhone = [UserDefaultsUtils valueWithKey:OUT_MYPHONE];
        myPassword = [UserDefaultsUtils valueWithKey:OUT_MYPASSWORD];
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    LearningPlanRequest *request = [[LearningPlanRequest alloc]init];
    [request userUserLoginWithAccount:myName andTel:myPhone andPassword:myPassword success:^(id obj) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        InfoResult *infoResult = (InfoResult *)obj;
        if ([infoResult.code isEqualToString:@"0"]) {
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
            
            MainViewController *mainViewController = [[MainViewController alloc]init];
            [UserDefaultsUtils saveBoolValue:NO withKey:WHETHERTHECANCELLATION];
            self.view.window.rootViewController = mainViewController;
            
        }else{
            [aCommon iToast:infoResult.desc];
            BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:[[LoginViewController alloc]init]];
            self.view.window.rootViewController = nav;
        }
    } failed:^(id obj) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}

#pragma mark ---UIAlertViewDelegate---
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex) {
        [self requestWithAlert:alertView.tag];
    }
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
