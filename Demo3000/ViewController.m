//
//  ViewController.m
//  VLionAdSDKDemo
//
//  Created by 张旭 on 2017/10/17.
//  Copyright © 2017年 cnlive. All rights reserved.
//

#import "ViewController.h"
#import <VLionAdSDK/VLNAdSDK.h>
#import "BannerADController.h"
#import "NativeAdListsController.h"
#import "InterstitialAdViewController.h"
#import "RewardVideoViewController.h"
#import <RSGameVlionAd/RSGameVlionAd.h>
#import <BUAdSDK/BUAdSDK.h>
#import "NewsViewController.h"
#import "SplashViewController.h"

typedef NS_ENUM(NSInteger, ADType) {
    ADTypeBanner = 0,
    ADTypeInterstitial = 1,
    ADTypeNative = 3,
    ADTypeExcitation= 4,
    ADTypeSplash=5,
    ADTypeSplashZiDingYi = 100,
    ADTypeDrawNative = 6,
    ADTypeDrawSmallGame = 7,
    ADTypeDrawNews = 8
};

@interface ViewController ()

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) UIView *interstitialView;
@property (nonatomic, strong) VLNSplashAd *splashAd;

@property (nonatomic, strong) SplashViewController *splashVC;

@property(nonatomic,assign) BOOL statusHiden;

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.dataSource = @[
                        @{
                            @"title": @"横幅图片广告",
                            @"tagId": @"23796",
                            @"ADType": @(ADTypeBanner)
                            },
                        @{
                            @"title": @"插屏图片广告",
                            @"tagId": @"23800",
                            @"ADType": @(ADTypeInterstitial)
                            },
                        @{
                            @"title": @"原生广告",
                            @"tagId": @"23798",
                            @"ADType": @(ADTypeNative)
                            },
                        @{
                            @"title": @"激励广告",
                            @"tagId": @"23974",
                            @"ADType": @(ADTypeExcitation)
                            },
                        @{
                            @"title": @"直接加载开屏广告",
                            @"tagId": @"23799",
                            @"ADType": @(ADTypeSplash)
                            },
                        @{
                            @"title": @"自定义开屏广告",
                            @"tagId": @"23799",
                            @"ADType": @(ADTypeSplashZiDingYi)
                        },
                        @{
                            @"title": @"draw视频流",
                            @"tagId": @"23799",
                            @"ADType": @(ADTypeDrawNative)
                            },
                        @{
                            @"title": @"小游戏",
                            @"tagId": @"45",
                            @"ADType": @(ADTypeDrawSmallGame)
                        },
                        @{
                            @"title": @"新闻SDK",
                            @"tagId": @"45",
                            @"ADType": @(ADTypeDrawNews)
                        }
                        
                        ];
    
    [self.tableView reloadData];
    
    self.navigationController.navigationBarHidden = YES;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *adCell = @"adCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:adCell];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:adCell];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = self.dataSource[indexPath.row][@"title"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *data = self.dataSource[indexPath.row];
    ADType type = [data[@"ADType"] integerValue];
    NSString *tagId = data[@"tagId"];
    
    switch (type) {
        case ADTypeBanner:
            [self loadBannerAd:tagId];
            break;
        case ADTypeInterstitial:
            [self loadInterstitialAd:tagId];
            break;
        case ADTypeNative:
            [self loadNativeAd];
            break;
        case ADTypeExcitation:
            [self loadExcitationAd:tagId];
            break;
        case ADTypeSplash:
        {
            self.splashAd = [[VLNSplashAd alloc] initWithTagId:tagId];
            self.splashAd.backgroundImage = [UIImage imageNamed:@"timg.jpeg"];
            [self.splashAd loadAdAndShowInWindow:self.view.window];
        }
            break;
        case ADTypeDrawNative:
        {
//            DrawNativeViewController *vc = [DrawNativeViewController new];
//            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case ADTypeDrawSmallGame:
        {
            RSGameListViewController *vc = [[RSGameListViewController alloc] initWithMediaId:tagId];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case ADTypeDrawNews:
            {
                NewsViewController *vc = [NewsViewController new];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            
        case ADTypeSplashZiDingYi:
        {
            [self loadSplashAd:tagId];
            break;
        }
        default:
            break;
    }
}

- (void)loadBannerAd:(NSString *)tagId {
    BannerADController *bannerVC = [[BannerADController alloc] init];
    bannerVC.tagId = tagId;
    [self.navigationController pushViewController:bannerVC animated:YES];
}

- (void)loadInterstitialAd:(NSString *)tagId {
    InterstitialAdViewController *interstitialAdVC = [[InterstitialAdViewController alloc] init];
    interstitialAdVC.tagId = tagId;
    [self.navigationController pushViewController:interstitialAdVC animated:YES];
}

- (void)loadNativeAd {
    NativeAdListsController *vc = [[NativeAdListsController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)loadExcitationAd:(NSString *)tagId {
    RewardVideoViewController *vc = [[RewardVideoViewController alloc] init];
    vc.tagId = tagId;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)loadSplashAd:(NSString *)tagId {
    
    if (!self.splashVC) {
        self.splashVC = [SplashViewController new];
        [self addChildViewController:self.splashVC];
        [self.view addSubview:self.splashVC.view];
        self.splashVC.view.frame = UIScreen.mainScreen.bounds;
        self.statusHiden = YES;
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
        __weak ViewController *wVC = self;
        self.splashVC.willCloseB = ^(SplashViewController * _Nonnull vc) {
            [vc removeFromParentViewController];
            [vc.view removeFromSuperview];
        };
        self.splashVC.didCloseB = ^(SplashViewController * _Nonnull vc) {
            [wVC invate];
        };
    }
    
}

- (void)invate {
    _splashVC = nil;
    self.statusHiden = NO;
    // 刷新状态栏
    [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
}

- (BOOL)prefersStatusBarHidden{
    return self.statusHiden;
}

@end
