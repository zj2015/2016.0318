//
//  MainViewController.m
//  BaseDemo
//
//  Created by 张娇娇 on 15/7/22.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "MainViewController.h"
#import "LearnPlanViewController.h"
//#import "KnowledgeLearnViewController.h"
#import "KnowledgeSelectViewController.h"
#import "TopicParseViewController.h"
#import "MineViewController.h"
#import "LoginViewController.h"
#import "BaseNavigationController.h"
#import "UserLoginModel.h"

@interface MainViewController ()

/**
 *  自定义的tabbar
 */
@property (nonatomic, strong) LearnPlanViewController *learnPlan;
@property (nonatomic, strong) KnowledgeSelectViewController *knowledge;
@property (nonatomic, strong) TopicParseViewController *topic;
@property (nonatomic, strong) MineViewController *mine;

// 装载子视图控制器
- (void)loadViewControllers;

// 自定义tabBar视图
- (void)customTabBarView;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBar.hidden = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 装载子视图控制器
    [self loadViewControllers];
    
    // 自定义tabBar视图
    [self customTabBarView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (_isAutoLogin) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        LearningPlanRequest *request = [[LearningPlanRequest alloc]init];
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
            }else{
                
                BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:[[LoginViewController alloc]init]];
                self.view.window.rootViewController = nav;
                [aCommon iToast:infoResult.desc];
            }
        } failed:^(id obj) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
        
    }
}


/**
 *  初始化所有的子控制器
 */
- (void)loadViewControllers
{
    // 1.学习规划 页面
    LearnPlanViewController *learnPlan = [[LearnPlanViewController alloc] init];
    BaseNavigationController *learnNavigation = [[BaseNavigationController alloc] initWithRootViewController:learnPlan];
    self.learnPlan = learnPlan;
    
    // 2. 知识点学习 界面
    KnowledgeSelectViewController *knowledge = [[KnowledgeSelectViewController alloc] init];
    BaseNavigationController *knowledgeNavigation = [[BaseNavigationController alloc] initWithRootViewController:knowledge];
    self.knowledge = knowledge;
    
    // 3.题型解析 界面
    TopicParseViewController *topic = [[TopicParseViewController alloc] init];
    BaseNavigationController *topicNavigation = [[BaseNavigationController alloc] initWithRootViewController:topic];
    self.topic = topic;
    
    // 4.我的 界面
    MineViewController *mine = [[MineViewController alloc] init];
    BaseNavigationController *mineNavigation = [[BaseNavigationController alloc] initWithRootViewController:mine];
    self.mine = mine;
    
    NSArray *viewControllers = @[learnNavigation, knowledgeNavigation, topicNavigation, mineNavigation];
    [self setViewControllers:viewControllers animated:YES];
}

/**
 *  初始化一个子控制器
 *
 *  @param childVc           需要初始化的子控制器
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */
- (void)customTabBarView
{
    // 自定义tabBar背景视图 tabBar高49
    _tabBarBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, MainScreenSize_H-49, MainScreenSize_W, 49)];
    _tabBarBG.userInteractionEnabled = YES;
//    _tabBarBG.backgroundColor = [UIColor whiteColor];
        _tabBarBG.backgroundColor = PView_BGColor;
    [self.view addSubview:_tabBarBG];
    
    UIImageView *lineView = [[UIImageView alloc]initWithFrame:CGRectMake(0.0, 0.0, MainScreenSize_W, 0.5)];
//    lineView.backgroundColor = RgbColor(169, 109, 15);
    lineView.backgroundColor = PView_BGColor;
    [_tabBarBG addSubview:lineView];
    
    int total = 0;
    NSArray *imgs = nil;
    NSArray *titles = nil;
   
    total = 4;
    // 整理数据
    imgs   = @[@"menu_xxgh", @"menu_zsdjx", @"menu_txjx", @"menu_my"];
    titles = @[@"学习规划", @"知识点学习", @"题型解析", @"我的"];
    
    
    // 选中视图  _tabBarBG.height 是调用了 UIViewExt实现
    _selectView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, MainScreenSize_W/total, 49.0)];
    
//    _selectView.backgroundColor = [UIColor colorWithRed:255/255.0f green:162/255.0f blue:16/255.0f alpha:1.0];
//    _selectView.backgroundColor = [UIColor colorWithRed:76/255.0f green:76/255.0f blue:78/255.0f alpha:1.0];
    _selectView.backgroundColor = [UIColor clearColor];

    [_tabBarBG addSubview:_selectView];
    
    int x = 0;
    _itemArr = [NSMutableArray array];
    for (int index = 0; index < total; index++) {
        
        ItemView *itemView = [[ItemView alloc] initWithFrame:CGRectMake(x, _tabBarBG. height/2.0-45.0/2, MainScreenSize_W/total, 45)];
        itemView.tag = index;
        itemView.delegate = self; // 设置委托
        itemView.item.image = [UIImage imageNamed:imgs[index]];
        itemView.title.text = titles[index];
        [_tabBarBG addSubview:itemView];
        if (index == 0) {
            itemView.title.textColor = [UIColor whiteColor];
            itemView.item.image = [UIImage imageNamed:@"menu_xxgh_Sel"];
            
        }else{
            itemView.title.textColor = [UIColor grayColor];
        }
        x += MainScreenSize_W/total;
        [_itemArr addObject:itemView];
    }
}

#pragma mark - ItemView Delegate
- (void)didItemView:(ItemView *)itemView atIndex:(NSInteger)index
{
    
    [[SoundTools sharedSoundTools] playSoundWithName:@"ui_page"];

    
//    if (index == 1 || index == 2) {
//        [aCommon iToast:@"功能开发中"];
//    }else{
        self.selectedIndex = index;
        int total = 0;
        NSArray *imgss = nil;
        NSArray *imgs = nil;
        
        total = 4;
    
#if TARGET_VERSION_LITE ==1
    //target（中考校内版）需要执行的代码
    // 整理数据
    imgss   = @[@"menu_xxgh", @"menu_zsdjx", @"menu_txjx", @"menu_my"];
    imgs   = @[@"menu_xxgh_Sel", @"menu_zsdjx_sel", @"menu_txjx_sel", @"menu_my_sel"];
    
#elif TARGET_VERSION_LITE ==2
    //target（中考校外版）需要执行的代码
    // 整理数据
    imgss   = @[@"menu_xxgh", @"menu_zsdjx", @"menu_txjx", @"menu_my"];
    imgs   = @[@"menu_xxgh_Sel", @"menu_zsdjx_sel", @"menu_txjx_sel", @"menu_my_sel"];
    
#elif TARGET_VERSION_LITE ==3
    //target（高考校内版）需要执行的代码
    // 整理数据
    imgss   = @[@"xxgh", @"zsdxx", @"txjx", @"menu_my"];
    imgs   = @[@"xxgh2", @"zsdxx2", @"txjx2", @"menu_my_sel"];
    
#elif TARGET_VERSION_LITE ==4
    //target（高考校外版）需要执行的代码
    // 整理数据
    imgss   = @[@"xxgh", @"zsdxx", @"txjx", @"menu_my"];
    imgs   = @[@"xxgh2", @"zsdxx2", @"txjx2", @"menu_my_sel"];
    
#endif
    
        // 移动选中视图的位置
        for (int i = 0; i < total; i ++) {
            ItemView *dem = _itemArr[i];
            dem.item.image = [UIImage imageNamed:imgss[i]];
            dem.title.textColor = [UIColor grayColor];
        }
        itemView.item.image = [UIImage imageNamed:imgs[index]];
        itemView.title.textColor = [UIColor whiteColor];
//        [UIView beginAnimations:nil context:NULL];
        _selectView.frame = CGRectMake(MainScreenSize_W/total*index, 0.0, MainScreenSize_W/total, 49.0);
        
//        [UIView commitAnimations];
//    }
}

#pragma mark - Public Method
- (void)showOrHiddenTabBarView:(BOOL)isHidden
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    if (isHidden) {
        _tabBarBG.top = MainScreenSize_H;
    }else {
        _tabBarBG.bottom = MainScreenSize_H;
    }
    [UIView commitAnimations];
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    return (interfaceOrientation == UIInterfaceOrientationPortrait);
//}
//
//- (BOOL)shouldAutorotate
//{
//    return NO;
//}
//
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
//    return UIInterfaceOrientationPortrait;
//}

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
