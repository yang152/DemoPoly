//
//  InterstitialAdViewController.m
//  VLionADSDKDemo
//
//  Created by 1 on 2019/6/3.
//  Copyright © 2019 zhulin. All rights reserved.
//

#import "InterstitialAdViewController.h"
#import <VLionADSDK/VLNADSDK.h>

@interface InterstitialAdViewController() <VLNInterstitialAdDelegate>

@property (nonatomic, strong) VLNInterstitialAd *interstitialAd;

@property (nonatomic, strong) UIButton *adButton;

@end

@implementation InterstitialAdViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"插屏广告"];
    
    self.interstitialAd = [[VLNInterstitialAd alloc] initWithTagId:self.tagId];
    self.interstitialAd.delegate = self;
    [self.interstitialAd loadAdData];
    
    self.adButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.adButton.frame = CGRectMake(0, 0, 200, 40);
    [self.adButton setBackgroundColor:[UIColor blueColor]];
    self.adButton.center = self.view.center;
    [self.adButton setTitle:@"展示广告" forState:UIControlStateNormal];
    [self.adButton addTarget:self action:@selector(showAd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.adButton];
}

- (void)showAd {
    [self.interstitialAd presentFromRootViewController:self];
}

- (void)interstitialAdDidLoad:(VLNInterstitialAd *)interstitialAd {
    NSLog(@"interstitialAdDidLoad");
}

- (void)interstitialAd:(VLNInterstitialAd *)interstitialAd didFailWithError:(NSError *)error {
    NSLog(@"interstitialAd didFailWithError");
}

- (void)interstitialAdExposured:(VLNInterstitialAd *)interstitialAd {
    NSLog(@"interstitialAdExposured");
}

- (void)interstitialAdDidClick:(VLNInterstitialAd *)interstitialAd {
    NSLog(@"interstitialAdDidClick");
}

- (void)interstitialAdWillClose:(VLNInterstitialAd *)interstitialAd {
    NSLog(@"interstitialAdWillClose");
}

- (void)interstitialAdDidClose:(VLNInterstitialAd *)interstitialAd {
    NSLog(@"interstitialAdDidClose");
    [self.interstitialAd loadAdData];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}
@end

