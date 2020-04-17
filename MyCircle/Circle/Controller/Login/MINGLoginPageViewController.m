//
//  MINGLoginPageViewController.m
//  MyCircle
//
//  Created by 周汉明 on 2020/4/16.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGLoginPageViewController.h"
#import "MINGLoginViewModel.h"
#import "MINGLoginViewController.h"
#import "MINGRegisterViewController.h"
#import "XLPageViewController.h"

#import <Masonry/Masonry.h>

@interface MINGLoginPageViewController ()
<
XLPageViewControllerDelegate,
XLPageViewControllerDataSrouce
>

@property (nonatomic, strong) XLPageViewController *pageViewController;

@end

@implementation MINGLoginPageViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configSubViews];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    XLPageViewControllerConfig *config = [XLPageViewControllerConfig defaultConfig];
    config.showTitleInNavigationBar = false;
    config.titleViewStyle = XLPageTitleViewStyleSegmented;
    config.separatorLineHidden = true;
    // 设置缩进
    config.titleViewInset = UIEdgeInsetsMake(5, 50, 5, 50);
    
    self.pageViewController = [[XLPageViewController alloc] initWithConfig:config];
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 80);
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
}

- (void)configSubViews
{
    
}


#pragma mark - XLPageViewControllerDelegate

- (void)pageViewController:(XLPageViewController *)pageViewController didSelectedAtIndex:(NSInteger)index
{
    
}

#pragma mark - XLPageViewControllerDataSource

- (NSInteger)pageViewControllerNumberOfPage
{
    return [self vcTitles].count;
}

- (NSString *)pageViewController:(XLPageViewController *)pageViewController titleForIndex:(NSInteger)index
{
    return [self vcTitles][index];
}

- (UIViewController *)pageViewController:(XLPageViewController *)pageViewController viewControllerForIndex:(NSInteger)index
{
    if (index == 0) {
        MINGLoginViewModel *viewModel = [[MINGLoginViewModel alloc] init];
        MINGLoginViewController *controller = [[MINGLoginViewController alloc] initWithViewModel:viewModel];
        return controller;
    } else {
        MINGLoginViewModel *viewModel = [[MINGLoginViewModel alloc] init];
        MINGRegisterViewController *controller = [[MINGRegisterViewController alloc] initWithViewModel:viewModel];
        return controller;
    }
}


#pragma mark - Actions

- (NSArray *)vcTitles
{
    return @[@"登陆", @"注册"];
}


@end
