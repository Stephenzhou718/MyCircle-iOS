//
//  AppDelegate.m
//  MyCircle
//
//  Created by 周汉明 on 2020/3/19.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "AppDelegate.h"

#import "MINGCiecleVideoListController.h"
#import "MINGProfileViewController.h"
#import "MINGVideoFeedViewController.h"
#import "MINGCiecleVideoListController.h"
#import "MINGCirclePageViewController.h"
#import "XLNavigationController.h"

#import "MINGCircleVideoListViewModel.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UITabBarController *controller = [[UITabBarController alloc] init];
    controller.view.backgroundColor = [UIColor whiteColor];

    // tab bar controllers
    // 首页
    MINGCircleVideoListViewModel *videoListViewModel = [[MINGCircleVideoListViewModel alloc] init];
    MINGCiecleVideoListController *videoListViewController = [[MINGCiecleVideoListController alloc] initWithViewModel:videoListViewModel];
    videoListViewController.view.backgroundColor = [UIColor lightGrayColor];
    videoListViewController.tabBarItem.title = @"首页";
    videoListViewController.tabBarItem.image = [UIImage imageNamed:@"video"];
    videoListViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"video_active"];
    
    // 圈子
    MINGCirclePageViewController *circlePageViewController = [MINGCirclePageViewController new];
    circlePageViewController.tabBarItem.title = @"圈子";
    circlePageViewController.tabBarItem.image = [UIImage imageNamed:@"circle"];
    circlePageViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"circle_active"];
    
    
    [controller setViewControllers:@[videoListViewController, circlePageViewController]];
    XLNavigationController *indexNavigationViewController = [[XLNavigationController alloc] initWithRootViewController:controller];
    
    self.window.rootViewController = indexNavigationViewController;
    [self.window makeKeyAndVisible];
    return YES;
}


@end
