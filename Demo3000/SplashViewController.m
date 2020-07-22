//
//  SplashViewController.m
//  VlionAdSDK_3000
//
//  Created by yangting on 2020/7/17.
//  Copyright © 2020 杨挺. All rights reserved.
//

#import "SplashViewController.h"
#import <VLionADSDK/VLNAdSDK.h>

@interface SplashViewController ()<VLNSplashAdDelegate>
@property (nonatomic, strong) IBOutlet UIImageView *bottomView;

@property (nonatomic, strong) VLNSplashAd *splashAd;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) int scheduledTime;
@property (weak, nonatomic) IBOutlet UILabel *timeLb;
@property (weak, nonatomic) IBOutlet UIView *skipView;
@end

@implementation SplashViewController

- (void)dealloc
{
    [self.timer invalidate];
    self.timer = nil;
    NSLog(@"%@-------dealloc", self.class);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor clearColor];
    
    self.bottomView.backgroundColor = [UIColor redColor];
    
    self.bottomView.frame = CGRectMake(0, UIScreen.mainScreen.bounds.size.height - UIScreen.mainScreen.bounds.size.width/3, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.width/3);
    self.skipView.frame = CGRectMake(UIScreen.mainScreen.bounds.size.width - 100, 44, 100, 30);
    self.timeLb.frame = self.skipView.bounds;
    
    self.scheduledTime = 20;
    self.timeLb.text = [NSString stringWithFormat:@"%ds", self.scheduledTime];
    
    __weak SplashViewController *wVC = self;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        wVC.scheduledTime--;
        
        if (wVC.scheduledTime <= 0) {
            if (wVC.willCloseB) {
                wVC.willCloseB(wVC);
            }
            
            if (self.didCloseB) {
                self.didCloseB(self);
            }
            
        }
        else {
            wVC.timeLb.text = [NSString stringWithFormat:@"%ds", self.scheduledTime];
        }
    }];
    
    self.splashAd = [[VLNSplashAd alloc] initWithTagId:@"23799"];
    self.splashAd.delegate = self;
    [self.splashAd loadAd];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapA:)];
    [self.skipView addGestureRecognizer:tap];
    
}

- (void)tapA:(UITapGestureRecognizer *)tap {
    NSLog(@"触发点击自定义跳过");
    
    if (self.willCloseB) {
        self.willCloseB(self);
    }
    if (self.didCloseB) {
        self.didCloseB(self);
    }
}

- (void)showWithSplashAd:(VLNSplashAd *)splashAd {
    [splashAd showWithViewController:self bottomView:self.bottomView skipView:self.skipView];
}


#pragma mark --VLNSplashAdDelegate

/**
 开屏广告成功展示.
 */
- (void)splashAdDidLoad:(VLNSplashAd *)splashAd {
    [self.splashAd showWithViewController:self bottomView:self.bottomView skipView:self.skipView exposureDuration:self.scheduledTime];
}

/**
 开屏广告展示失败.
 @param error :失败error
 */
- (void)splashAd:(VLNSplashAd *)splashAd didFailWithError:(NSError *)error {
    NSLog(@"%@", error);
//    if (self.willCloseB) {
//        self.willCloseB(self);
//    }
}

/**
 开屏广告曝光回调
 */
- (void)splashAdExposured:(VLNSplashAd *)splashAd {
    
}

/**
 开屏广告点击回调
 */
- (void)splashAdDidClick:(VLNSplashAd *)splashAd {
    if (self.willCloseB) {
        self.willCloseB(self);
    }
}

/**
 开屏广告关闭回调
 */
- (void)splashAdDidClose:(VLNSplashAd *)splashAd {
    if (self.didCloseB) {
        self.didCloseB(self);
    }
}

/**
  开屏广告将要关闭回调
 */
- (void)splashAdWillClose:(VLNSplashAd *)splashAd {
    if (self.willCloseB) {
        self.willCloseB(self);
    }
}

@end
