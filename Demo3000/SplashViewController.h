//
//  SplashViewController.h
//  VlionAdSDK_3000
//
//  Created by yangting on 2020/7/17.
//  Copyright © 2020 杨挺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <VLionADSDK/VLNAdSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface SplashViewController : UIViewController
- (void)showWithSplashAd:(VLNSplashAd *)splashAd;

@property (nonatomic, copy) void(^didCloseB)(SplashViewController *vc);
@property (nonatomic, copy) void(^willCloseB)(SplashViewController *vc);

@end

NS_ASSUME_NONNULL_END
