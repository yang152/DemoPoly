//
//  AppDelegate.m
//  Demo3000
//
//  Created by yangting on 2020/6/22.
//  Copyright © 2020 杨挺. All rights reserved.
//

#import "AppDelegate.h"
#import <VLionADSDK/VLNADSDK.h>

@interface AppDelegate ()<VLNSplashAdDelegate>
@property (nonatomic, strong) VLNSplashAd *ad;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[VLNAdSDKManager defaultManager] setAppID:@"30164"];

    VLNSplashAd *ad = [[VLNSplashAd alloc] initWithTagId:@"23799"];
    self.ad = ad;
    ad.placeholderImage = [UIImage imageNamed:@"bg_launch_1242"];
    ad.delegate = self;
    [ad loadAdAndShowInWindow:self.window];
//    [self.ad loadAd];
    
    return YES;
}

- (void)splashAdDidLoad:(VLNSplashAd *)splashAd {
    NSLog(@"VLNSplashAd DidLoad");
//    [self.ad showAdInWindow:self.window];
}

- (void)splashAd:(VLNSplashAd *)splashAd didFailWithError:(NSError *)error {
    NSLog(@"VLNSplashAd didFailWithError");
}

- (void)splashAdExposured:(VLNSplashAd *)splashAd {
    NSLog(@"VLNSplashAd splashAdExposured");
}

- (void)splashAdDidClick:(VLNSplashAd *)splashAd {
    NSLog(@"VLNSplashAd splashAdDidClick");
}

- (void)splashAdWillClose:(VLNSplashAd *)splashAd {
    NSLog(@"VLNSplashAd splashAdWillClose");
}



#pragma mark - UISceneSession lifecycle




@end
