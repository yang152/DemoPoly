//
//  BannerADController.m
//  VLionADSDKDemo
//
//  Created by iOS on 2017/10/10.
//  Copyright © 2017年 zhulin. All rights reserved.
//

#import "BannerADController.h"
#import <VLionADSDK/VLNADSDK.h>

@interface BannerADController ()<VLNBannerViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) VLNBannerView *bannerView;

@property (nonatomic, strong) UIButton *adButton;

@end

@implementation BannerADController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *bg = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bg.image = [UIImage imageNamed:@"bg_activity"];
    [self.view addSubview:bg];
    
    self.title = @"Banner 广告";
    
    //广告容器
    self.bannerView = [[VLNBannerView alloc] initWithTagId:self.tagId];
    self.bannerView.delegate = self;
    self.bannerView.rootViewController = self;
//    [self.view addSubview:self.bannerView];
    [self.bannerView loadAdAndShow];
//    self.bannerView.frame = CGRectMake(0, 88, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.width*60/375.f);
    
    self.adButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.adButton.frame = CGRectMake(0, 0, 200, 40);
    [self.adButton setBackgroundColor:[UIColor blueColor]];
    self.adButton.center = self.view.center;
    [self.adButton setTitle:@"刷新广告" forState:UIControlStateNormal];
    [self.adButton addTarget:self action:@selector(refresh) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.adButton];
}


- (void)refresh
{
    [self.bannerView removeFromSuperview];
    [self.bannerView loadAdAndShow];
}

- (CGRect)bannerView:(VLNBannerView *)bannerView didLoadBannerImageSize:(CGSize)size {
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    return CGRectMake(0, 88, screenSize.width, size.height / size.width * (screenSize.width));
}

- (void)bannerViewDidLoad:(VLNBannerView *)bannerView {
    
    NSLog(@"BannerAd 加载成功");
    [self.view addSubview:self.bannerView];
}

- (void)bannerView:(VLNBannerView *)bannerView didFailWithError:(NSError *)error {
    NSLog(@"BannerAd 异常");
}

- (void)bannerViewExposured:(VLNBannerView *)bannerView {
    NSLog(@"BannerAd 曝光");
}

- (void)bannerViewDidClick:(VLNBannerView *)bannerView {
    NSLog(@"BannerAd 点击");
}

- (void)bannerViewDidClose:(VLNBannerView *)bannerView {
    NSLog(@"BannerAd 关闭");
    [self.bannerView removeFromSuperview];
}


- (void)dealloc {
    NSLog(@"BannerADController dealloc");
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

@end

