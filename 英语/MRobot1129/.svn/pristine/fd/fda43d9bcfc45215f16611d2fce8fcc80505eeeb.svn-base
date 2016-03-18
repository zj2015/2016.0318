//
//  PicBrowseViewController.m
//  Elibrary
//
//  Created by zjb on 15/6/11.
//  Copyright (c) 2015年 zjb. All rights reserved.
//

#import "PicBrowseViewController.h"

@interface PicBrowseViewController ()

@end

@implementation PicBrowseViewController
@synthesize image;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    photoView = [[VIPhotoView alloc] initWithFrame:self.view.bounds andImage:self.image];
    photoView.autoresizingMask = (1 << 6) -1;
    
    [self.view addSubview:photoView];
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backview:) name:@"BackNotification" object:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
}

- (void)backview:(NSNotification *)notification{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.navigationController popViewControllerAnimated:NO];
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
