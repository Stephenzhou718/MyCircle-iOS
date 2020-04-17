//
//  AppDelegate.m
//  MyCircle
//
//  Created by 周汉明 on 2020/3/19.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "AppDelegate.h"

#import "MINGCircleVideoListController.h"
#import "MINGProfileViewController.h"
#import "MINGVideoFeedViewController.h"
#import "MINGCirclePageViewController.h"
#import "XLNavigationController.h"
#import "MINGLoginPageViewController.h"

#import "MINGCircleVideoListViewModel.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    // 登陆面板
    MINGLoginPageViewController *loginController = [[MINGLoginPageViewController alloc] init];
    
    XLNavigationController *indexNavigationViewController = [[XLNavigationController alloc] initWithRootViewController:loginController];
    
    self.window.rootViewController = indexNavigationViewController;
    [self.window makeKeyAndVisible];
    return YES;
}


@end
