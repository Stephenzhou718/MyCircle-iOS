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

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UITabBarController *controller = [[UITabBarController alloc] init];
    controller.view.backgroundColor = [UIColor whiteColor];
    
    // tab bar controllers
    MINGVideoFeedViewController *videoFeedViewController = [[MINGVideoFeedViewController alloc] init];
    videoFeedViewController.view.backgroundColor = [UIColor lightGrayColor];
    videoFeedViewController.tabBarItem.title = @"首页";
    
    [controller setViewControllers:@[videoFeedViewController]];
    self.window.rootViewController = controller;
    [self.window makeKeyAndVisible];
    return YES;
}


@end
