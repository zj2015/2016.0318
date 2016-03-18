//
//  BaseViewController.m
//  BaseDemo
//
//  Created by xiefei on 15/7/1.
//  Copyright (c) 2015年 xiefei. All rights reserved.
//

#import "BaseViewController.h"
#import "MainViewController.h"
#import "LoginViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航兰的颜色
    [self base_changeNavigationBarBackgroudImage:@"navigationBg"];
    if (self.navigationController.viewControllers.count > 1) {
        [self base_createLeftNavigationBarButtonWithFrontImage:nil andSelectedImageName:nil andBackGroundImageName:@"back" andTitle:nil andSize:CGSizeMake(24/2, 41/2)];
    }
    
    self.view.backgroundColor = PView_BGColor;
    
//    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
//    bgImageView.backgroundColor = [UIColor redColor];
//    bgImageView.image = [UIImage imageNamed:@"tableBG"];
//    bgImageView.userInteractionEnabled = YES;
//    [self.view addSubview:bgImageView];
    
    // Do any additional setup after loading the view.
    [self _prepareUI];
    [self _prepareData];
    [self _prepareNotificaitons];

}

- (void)_prepareUI
{
    
}

- (void)_prepareNotificaitons
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkNetworkConnection:) name:k_NOTI_NETWORK_ERROR object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(againLogin) name:k_NOTI_AGAIN_LOGIN object:nil];
}

- (void)checkNetworkConnection:(NSNotification *)noti
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

//重新登录
- (void)againLogin
{
    
    [[SoundTools sharedSoundTools] playSoundWithName:@"ui_click_in"];

    
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:loginVC animated:NO];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:k_NOTI_NETWORK_ERROR object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:k_NOTI_AGAIN_LOGIN object:nil];
}

- (void)_prepareData
{
    
}

//  在IOS7 的情况下 会自动留边整体向下64像素，如果调用此方法 则不需要获取offset 高度适配了
-(void)base_ExtendedLayout{
    
    if ([UIDevice currentDevice].systemVersion.floatValue>=7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

-(void)base_navigation_LeftBarButtonPressed
{
    
    [[SoundTools sharedSoundTools] playSoundWithName:@"ui_click_out"];
    
    PLog(@"父类方法：%s",__FUNCTION__);
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)base_navigation_RightBarButtonPressed
{
    PLog(@"父类方法：%s",__FUNCTION__);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.navigationController.viewControllers.count >= 2) {
        MainViewController *mainVC = (MainViewController *)self.tabBarController;
        [mainVC showOrHiddenTabBarView:YES];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.navigationController.viewControllers.count <= 1) {
        MainViewController *mainVC = (MainViewController *)self.tabBarController;
        [mainVC showOrHiddenTabBarView:NO];
    }
}

/*
 修改导航条背景图
 */
-(void)base_changeNavigationBarBackgroudImage:(NSString *)ImgName{
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:ImgName]]];
    
}

/*
 修改导航条背景颜色
 */
-(void)base_changeNavigationBarBackgroudColor:(UIColor *)color
{
     self.navigationController.navigationBar.barTintColor = color;
}

/**
 * 设置导航栏的标题
 */
-(void)base_changeNavigationTitleWithString:(NSString *)title{
    UILabel * tempLabel = [[UILabel alloc] init];
    tempLabel.frame = CGRectMake(0, 0, 180, 30);
    tempLabel.backgroundColor = [UIColor clearColor];
    tempLabel.adjustsFontSizeToFitWidth = YES;
    tempLabel.font = [UIFont boldSystemFontOfSize:20.0];
    tempLabel.text = title;
    tempLabel.textAlignment = NSTextAlignmentCenter;
    tempLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = tempLabel;
}

/**
 * 修改导航栏的标题
 *  @param title     主标题
 *  @param smallTitle 小标题
 */
-(void)base_changeNavigationTitleWithString:(NSString *)title andSmallTitle:(NSString *)smallTitle
{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 180, 44)];
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 180, 25)];
    titleLab.text = title;
    titleLab.textColor = [UIColor whiteColor];
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    titleLab.textAlignment = NSTextAlignmentCenter;
    [titleView addSubview:titleLab];
    
    UILabel *smallTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, 180, 19)];
    smallTitleLab.text = smallTitle;
    smallTitleLab.textColor = [UIColor whiteColor];
    smallTitleLab.font = [UIFont boldSystemFontOfSize:13];
    smallTitleLab.textAlignment = NSTextAlignmentCenter;
    [titleView addSubview:smallTitleLab];
    
    self.navigationItem.titleView = titleView;
}

/**
 * 图片 修改设置导航栏的标题
 */
-(void)base_changeNavigationTitleWithImage:(NSString *)imageName{
    
    UIImage * tempImage = [UIImage imageNamed:imageName];
    UIImageView * tempImageView = [[UIImageView alloc] initWithImage:tempImage];
    tempImageView.frame = CGRectMake(0, 0, 180, 30);
    tempImageView.userInteractionEnabled = YES;
    tempImageView.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = tempImageView;
    
}

-(void)base_changeNavigationTitleWithString:(NSString *)title andImage:(NSString *)imageName
{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(middleBtnClick)];
    [bgView addGestureRecognizer:tap];
    
    UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 20, 20)];
    image.image = [UIImage imageNamed:imageName];
    [bgView addSubview:image];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, image.bottom, 50,20)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:12];
    label.text = title;
    [bgView addSubview:label];
    
    self.navigationItem.titleView = bgView;
}

- (void)middleBtnClick
{
    PLog(@"点击中间的按钮");
}

#pragma mark ---
#pragma mark --- 导航条自定义按钮 ---
/*
 size 按钮的尺寸
 frontImageName 常态下的图片
 selectedImageName 选中状态的图片
 isLeft 是否显示在导航条左边
 target 按钮点击事件的接收者
 event 按钮点击事件方法
 title 按钮图片上显示文字（没有传nil）
 谨记 设置的尺寸 要与图片的大小一致，否则选中的时候会很奇怪
 */

-(void)base_createUIBarButtonWithSize:(CGSize)size andFrontImageName:(NSString*) frontImageName andSelectedImageName:(NSString *) selectedImageName andBackGroundImageName:(NSString *)backgroundImageName isLeft:(BOOL)isLeft target:(id)target event:(SEL)selector title:(NSString*)title{
    
    UIButton *myBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [myBackButton setFrame:CGRectMake(10,-5,size.width,size.height)];
    if (title){
         myBackButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
        [myBackButton setTitle:title forState:UIControlStateNormal];
        [myBackButton setTitle:title forState:UIControlStateSelected];
        [myBackButton setTitle:title forState:UIControlStateHighlighted];
        // 这里的设置很关键 不同的状态 不同的颜色
        [myBackButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [myBackButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [myBackButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    }
    
    if (backgroundImageName) {
        [myBackButton setBackgroundImage:[UIImage imageNamed:backgroundImageName] forState:UIControlStateNormal];
    }else{
        //按钮的常态背景图
        [myBackButton setImage:[UIImage imageNamed:frontImageName] forState:UIControlStateNormal];
        //按钮选中背景图
        if (selectedImageName){
            [myBackButton setImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateHighlighted];
            [myBackButton setImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];
        }
    }
    
    
    [myBackButton setEnabled:YES];
    [myBackButton addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * buttonItem = [[UIBarButtonItem alloc] initWithCustomView:myBackButton];
    if (isLeft){
        self.navigationItem.leftBarButtonItem = buttonItem;
    }else{
        self.navigationItem.rightBarButtonItem = buttonItem;
    }
}

// 自定义-导航栏-左边（返回）按钮
-(void)base_createLeftNavigationBarButtonWithFrontImage:(NSString *) frontImageName andSelectedImageName:(NSString *)selectedImageName andBackGroundImageName:(NSString *)backgroundImageName andTitle:(NSString *)title{
    
    [self base_createUIBarButtonWithSize:NAVIGATION_LEFT_BARBUTTON_SIZE
                       andFrontImageName:frontImageName
                    andSelectedImageName:selectedImageName
                  andBackGroundImageName:backgroundImageName
                                  isLeft:YES
                                  target:self
                                   event:@selector(base_navigation_LeftBarButtonPressed)
                                   title:title];
}

// 自定义-导航栏-右边 按钮
-(void)base_createRightNavigationBarButtonWithFrontImage:(NSString *) frontImageName andSelectedImageName:(NSString *)selectedImageName andBackGroundImageName:(NSString *)backgroundImageName andTitle:(NSString *)title{
    
    [self base_createUIBarButtonWithSize:NAVIGATION_RIGHT_BARBUTTON_SIZE
                       andFrontImageName:frontImageName
                    andSelectedImageName:selectedImageName
                  andBackGroundImageName:backgroundImageName
                                  isLeft:NO
                                  target:self
                                   event:@selector(base_navigation_RightBarButtonPressed)
                                   title:title];
}

// 自定义-导航栏-左边（返回）按钮
-(void)base_createLeftNavigationBarButtonWithFrontImage:(NSString *) frontImageName andSelectedImageName:(NSString *)selectedImageName andBackGroundImageName:(NSString *)backgroundImageName andTitle:(NSString *)title andSize:(CGSize)size{
    
    
    [self base_createUIBarButtonWithSize:size
                       andFrontImageName:frontImageName
                    andSelectedImageName:selectedImageName
                  andBackGroundImageName:backgroundImageName
                                  isLeft:YES
                                  target:self
                                   event:@selector(base_navigation_LeftBarButtonPressed)
                                   title:title];
    
}

// 自定义-导航栏-右边 按钮
-(void)base_createRightNavigationBarButtonWithFrontImage:(NSString *) frontImageName andSelectedImageName:(NSString *)selectedImageName andBackGroundImageName:(NSString *)backgroundImageName andTitle:(NSString *)title andSize:(CGSize)size{
    
    
    [self base_createUIBarButtonWithSize:size
                       andFrontImageName:frontImageName
                    andSelectedImageName:selectedImageName
                  andBackGroundImageName:backgroundImageName
                                  isLeft:NO
                                  target:self
                                   event:@selector(base_navigation_RightBarButtonPressed)
                                   title:title];
}

- (void)showSucessHUD:(NSString *)message//操作成功的提示
{
    MBProgressHUD *progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    progressHUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark"]];
    
    // Set custom view mode
    progressHUD.mode = MBProgressHUDModeCustomView;
    
    progressHUD.labelText = message;
    [self.view addSubview:progressHUD];
    [progressHUD show:YES];
    [progressHUD hide:YES afterDelay:1];
}

//一般的提示
- (void)showAlertHUD:(NSString *)message
{
    // Set custom view mode
    MBProgressHUD *progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    progressHUD.mode = MBProgressHUDModeText;
    progressHUD.margin = 10.f;
    progressHUD.detailsLabelText = message;
    
    progressHUD.yOffset = -15.0f;
    [self.view addSubview:progressHUD];
    [progressHUD show:YES];
    [progressHUD hide:YES afterDelay:1.3f];
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
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
