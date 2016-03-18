//
//  TopicKVideoViewController.m
//  MRobot
//
//  Created by mac on 15/11/6.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "TopicKVideoViewController.h"
#import "KVideoCollectionCell.h"
#import "DWCustomPlayerViewController.h"
#import "TopKVideoModel.h"
#import "TopKVideoListModel.h"
@interface TopicKVideoViewController ()
@property (strong, nonatomic) TopKVideoModel *typeQListModel;
@end

@implementation TopicKVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self base_changeNavigationTitleWithString:@"通用解题技巧"];
    
    self.view.backgroundColor = PView_BGColor;
}

- (void)_prepareNotificaitons
{
    
}

- (void)_prepareData
{
    // 1.4.38 题型更多视频列表
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    LearningPlanRequest *topQListRequest = [[LearningPlanRequest alloc] init];
    [topQListRequest usermoreQTypeQuestionListWithTId:self.tId success:^(id obj) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        InfoResult *infoResult = (InfoResult *)obj;
        if ([infoResult.code isEqualToString:@"0"]) {
            _typeQListModel = [[TopKVideoModel alloc]init];
            _typeQListModel = (TopKVideoModel *)[infoResult extraObj];
            
            _kVideoArr = [[NSArray alloc]initWithArray:_typeQListModel.resultArray];
            
            [_myCollectionView reloadData];
        }else{
            [aCommon iToast:@"加载失败!"];
        }
    } failed:^(id obj) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [aCommon iToast:@"系统未知错误!"];
    }];
    
}

- (void)_prepareUI
{
    
    CGRect rect = CGRectMake(MainSreenOrigin_X,MainSreenOrigin_Y,MainScreenSize_W,MainScreenSize_H);
    UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc]init];
    self.myCollectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:flowLayout];
    self.myCollectionView.backgroundColor =   PView_BGColor;
    [self.myCollectionView registerClass:[KVideoCollectionCell class] forCellWithReuseIdentifier:@"myCell"];
    self.myCollectionView.delegate = self;
    self.myCollectionView.dataSource = self;
    [self.view addSubview:self.myCollectionView];
    
}

#pragma mark ---
#pragma mark --- UICollectionViewDataSource ---

//collectionView里有多少个组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每一组有多少个cell
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _kVideoArr.count;
}

//自定义单元格
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    KVideoCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myCell" forIndexPath:indexPath];
    TopKVideoListModel *videoDataModel = [self.kVideoArr objectAtIndex:indexPath.row];
    cell.videoLabel.text = videoDataModel.tVideoName;
    [cell.videoImgView setImageWithURL:[NSURL URLWithString:videoDataModel.tVideoCoverUrl] placeholderImage:[UIImage imageNamed:@"video"]];
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout--
//设定全局的区内边距，如果想要设定指定区的内边距
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake( MainScreenSize_W/2, 75*SIZE_TIMES+45);
}

//设定全局的Cell尺寸，如果想要单独定义某个Cell的尺寸
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//设定全局的行间距，如果想要设定指定区内Cell的最小行距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0;
}


//设定全局的Cell间距，如果想要设定指定区内Cell的最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0;
}


#pragma mark --UICollectionViewDelegate--
//如果返回YES则向下执行，否则执行到这里为止
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//执行选择事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    [[SoundTools sharedSoundTools] playSoundWithName:@"ui_click_in"];

    TopKVideoListModel *videoDataModel = [self.kVideoArr objectAtIndex:indexPath.row];
    
    DWCustomPlayerViewController *player = [[DWCustomPlayerViewController alloc] init];
    player.videoId = videoDataModel.tVideoCCId;
    player.videoTitle = videoDataModel.tVideoName;
    player.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:player animated:NO];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
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
