//
//  MINGTabBarViewController.m
//  MyCircle
//
//  Created by 周汉明 on 2020/4/17.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGTabBarViewController.h"
#import "MINGCircleVideoListViewModel.h"
#import "MINGCircleVideoListController.h"
#import "MINGProfileViewController.h"
#import "MINGVideoFeedViewController.h"
#import "MINGCirclePageViewController.h"
#import "XLNavigationController.h"
#import "MINGLoginPageViewController.h"
#import "MINGPublishViewController.h"
#import "MINGProfileViewModel.h"
#import "MINGProfileViewController.h"

@interface MINGTabBarViewController ()

@end

@implementation MINGTabBarViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        
        // 首页
        MINGCircleVideoListViewModel *videoListViewModel = [[MINGCircleVideoListViewModel alloc] init];
        MINGCircleVideoListController *videoListViewController = [[MINGCircleVideoListController alloc] initWithViewModel:videoListViewModel];
        videoListViewController.view.backgroundColor = [UIColor lightGrayColor];
        videoListViewController.tabBarItem.title = @"首页";
        videoListViewController.tabBarItem.image = [UIImage imageNamed:@"video"];
        videoListViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"video_active"];
        
        // 圈子
        MINGCirclePageViewController *circlePageViewController = [MINGCirclePageViewController new];
        circlePageViewController.tabBarItem.title = @"圈子";
        circlePageViewController.tabBarItem.image = [UIImage imageNamed:@"circle"];
        circlePageViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"circle_active"];
        
        // 发布
        MINGPublishViewController *publishViewController = [[MINGPublishViewController alloc] init];
        publishViewController.tabBarItem.title = @"发布";
        publishViewController.tabBarItem.image = [UIImage imageNamed:@"publish"];
        publishViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"publish_active"];
        
        // 我的
        MINGProfileViewModel *viewModel = [[MINGProfileViewModel alloc] init];
        MINGProfileViewController *profileViewController = [[MINGProfileViewController alloc] initWithViewModel:viewModel];
        profileViewController.tabBarItem.title = @"我的";
        profileViewController.tabBarItem.image = [UIImage imageNamed:@"me"];
        profileViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"me_active"];
    
        
        [self setViewControllers:@[videoListViewController, circlePageViewController, publishViewController, profileViewController]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

@end
