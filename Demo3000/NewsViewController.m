//
//  NewsViewController.m
//  VlionAdSDK_3000
//
//  Created by yangting on 2020/6/29.
//  Copyright © 2020 杨挺. All rights reserved.
//

#import "NewsViewController.h"
#import <VLionNewsSDK/VLionNewsSDK.h>

@interface NewsViewController ()<UIGestureRecognizerDelegate>

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    VlionAdPageView *view = [[VlionAdPageView alloc] initWithFrame:self.view.bounds media:@"730" submedia:@"1009" currentVC:self];
    [self.view addSubview:view];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
}

@end
