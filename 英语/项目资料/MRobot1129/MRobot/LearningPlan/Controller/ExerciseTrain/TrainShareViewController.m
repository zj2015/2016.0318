//
//  TrainShareViewController.m
//  MRobot
//
//  Created by mac on 15/8/22.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "TrainShareViewController.h"
#import "PICircularProgressView.h"
@interface TrainShareViewController ()

@end

@implementation TrainShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self base_changeNavigationTitleWithString:@"成绩分享"];
    [self base_createRightNavigationBarButtonWithFrontImage:@"share" andSelectedImageName:nil andBackGroundImageName:@"share" andTitle:nil andSize:CGSizeMake(30, 30)];
    
}

- (void)base_navigation_RightBarButtonPressed
{
    //截屏
    [self startScreen];
    //分享
    [self showUMShare];
}

-(void)_prepareUI
{
    UIImageView *logoImgView = [[UIImageView alloc] initWithFrame:CGRectMake((MainScreenSize_W - 195)/2, 70, 195, 59)];
    logoImgView.image = [UIImage imageNamed:@"LOGO"];
    [self.view addSubview:logoImgView];
    
    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake((MainScreenSize_W - 200)/2, 140, 200, 20)];
    nameLab.text = [NSString stringWithFormat:@"%@  %@",[UserDefaultsUtils valueWithKey:USER_CAMPUS],[UserDefaultsUtils valueWithKey:USER_NAME]];
//    nameLab.text = @"sadasdasdasdas";
    nameLab.textColor = [UIColor colorWithRed:138/255.0 green:4/255.0 blue:16/255.0 alpha:1];
    nameLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:nameLab];
    
    UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 165, MainScreenSize_W-20, 1)];
    lineLab.backgroundColor = [UIColor colorWithRed:221/255.0 green:220/255.0 blue:221/255.0 alpha:1];
    [self.view addSubview:lineLab];
    
    PICircularProgressView *progressView = [[PICircularProgressView alloc] initWithFrame:CGRectMake((MainScreenSize_W - 65)/2, 175.0f, 65.0f, 65.0f)];
    progressView.progressFillColor = [UIColor colorWithRed:170/255.0 green:22/255.0 blue:24/255.0 alpha:1];
    progressView.innerBackgroundColor = [UIColor colorWithRed:251/255.0 green:157/255.0 blue:160/255.0 alpha:0.5];
    progressView.outerBackgroundColor = [UIColor whiteColor];
    progressView.textColor = [UIColor colorWithRed:170/255.0 green:22/255.0 blue:24/255.0 alpha:1];
    progressView.progress = ([self.score floatValue])/100;
    progressView.text = self.score;
    [self.view addSubview:progressView];
    
    UILabel *scoreLab = [[UILabel alloc] initWithFrame:CGRectMake((MainScreenSize_W - 65)/2 + 50, 210, 10, 10)];
    scoreLab.text = @"分";
    scoreLab.textColor = [UIColor grayColor];
    scoreLab.font = [UIFont systemFontOfSize:11];
    [self.view addSubview:scoreLab];
    
    UILabel *maxScoreLab = [[UILabel alloc] initWithFrame:CGRectMake((MainScreenSize_W - 200)/2, 245, 200, 20)];
    maxScoreLab.text = [NSString stringWithFormat:@"我的最高分：%@分",self.highScore];
    maxScoreLab.textAlignment = NSTextAlignmentCenter;
    maxScoreLab.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:maxScoreLab];
    
    UILabel *beatLab = [[UILabel alloc] initWithFrame:CGRectMake((MainScreenSize_W - 200)/2, 270, 200, 20)];
    beatLab.text = [NSString stringWithFormat:@"击败了%@的对手",self.beatPercent];
    beatLab.textAlignment = NSTextAlignmentCenter;
    beatLab.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:beatLab];
    
    UILabel *secLineLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 297, MainScreenSize_W-20, 1)];
    secLineLab.backgroundColor = [UIColor colorWithRed:221/255.0 green:220/255.0 blue:221/255.0 alpha:1];
    [self.view addSubview:secLineLab];
    
    UILabel *tipsLab = [[UILabel alloc] initWithFrame:CGRectMake((MainScreenSize_W - 300)/2, 305, 300, 20)];
    tipsLab.text = @"安装学习机器人,扫描以下二维码:";
    tipsLab.textAlignment = NSTextAlignmentCenter;
    tipsLab.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:tipsLab];
    
    NSArray *scanTitleArr = @[@"For IOS",@"For Android"];
    for (int i = 0; i < 2; i++) {
        UIImageView *scanImgView = [[UIImageView alloc] initWithFrame:CGRectMake((MainScreenSize_W - 3*50)/2+ 2*i*50, 340, 50, 50)];
        scanImgView.image = [UIImage imageNamed:@"leixing"];
        [self.view addSubview:scanImgView];
        
        UILabel *scanLab = [[UILabel alloc] initWithFrame:CGRectMake((MainScreenSize_W - 2*70 - 30)/2 + i*70 + i*30, 390, 70, 20)];
        scanLab.text = scanTitleArr[i];
        scanLab.textColor = [UIColor grayColor];
        scanLab.textAlignment = NSTextAlignmentCenter;
        scanLab.font = [UIFont systemFontOfSize:11];
        [self.view addSubview:scanLab];
    }
    
    UILabel *addressLab = [[UILabel alloc] initWithFrame:CGRectMake((MainScreenSize_W - 300)/2, 420, 300, 20)];
    addressLab.text = @"下载地址:http://www.cc.com/app";
    addressLab.textAlignment = NSTextAlignmentCenter;
    addressLab.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:addressLab];
    
    [self performSelector:@selector(startScreen) withObject:nil afterDelay:0.0];
    
    [self showUMShare];
}

- (void)showUMShare
{
    NSString *shareText = @"CC英语，让孩子放心就读10年的英语学校，http://www.cc-english.com";             //分享内嵌文字
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *imgFilePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"ScreenPic.jpg"];
    NSLog(@"imgFilePath=%@",imgFilePath);
    
    //分享图文样式到微信朋友圈显示字数比较少，只显示分享标题
    [UMSocialData defaultData].extConfig.title = @"CC英语";
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"CC英语，让孩子放心就读10年的英语学校，http://www.cc-english.com";
    UIImage *shareImage = [UIImage imageWithContentsOfFile:imgFilePath];          //分享内嵌图片
    NSArray *shareList = @[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ,UMShareToQzone,UMShareToTencent,UMShareToSms,UMShareToEmail];
    //调用快速分享接口
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:UmengAppkey
                                      shareText:shareText
                                     shareImage:shareImage
                                shareToSnsNames:shareList
                                       delegate:self];
    
}

//实现回调方法（可选）：
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        PLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}

- (void)startScreen
{
    PLog(@"截图");
    
    UIImage *screenImg = [self captureScreen];
    NSData *imageData = UIImageJPEGRepresentation(screenImg, 1.0);
    [self Seva:imageData];//将其存到沙盒中
    
    UIImageWriteToSavedPhotosAlbum([self captureScreen], nil, nil, nil);//将截图保存在本地相册
}

- (UIImage *)captureScreen {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(MainScreenSize_W, MainScreenSize_H), YES, 0);     //设置截屏大小
    [[self.view layer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRef imageRef = viewImage.CGImage;
    //    CGRect rect = CGRectMake(166, 211, 426, 320);//这里可以设置想要截图的区域
    CGRect rect = CGRectMake(0*4, 64, MainScreenSize_W*4, MainScreenSize_H*4);//这里可以设置想要截图的区域
    CGImageRef imageRefRect =CGImageCreateWithImageInRect(imageRef, rect);
    UIImage *sendImage = [[UIImage alloc] initWithCGImage:imageRefRect];
    return sendImage;
}

-(void)Seva: (NSData *)data{
    //此处首先指定了图片存取路径（默认写到应用程序沙盒 中）
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    
    //并给文件起个文件名
    NSString *imgFilePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"ScreenPic.jpg"];
    
    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:imgFilePath];
    if (blHave) {
        
    }
    //此处的方法是将图片写到Documents文件中 如果写入成功会弹出一个警告框,提示图片保存成功
    BOOL result = [data writeToFile:imgFilePath atomically:YES];
    if (result) {
        PLog(@"success");
    }else {
        PLog(@"no success");
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
