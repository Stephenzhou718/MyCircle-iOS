//
//  MINGCirclePageViewController.m
//  MyCircle
//
//  Created by 周汉明 on 2020/4/15.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGCirclePageViewController.h"
#import "MINGCircleSelectionViewModel.h"
#import "MINGCircleSelectionViewController.h"
#import "XLPageViewController.h"

@interface MINGCirclePageViewController ()
<
XLPageViewControllerDelegate,
XLPageViewControllerDataSrouce
>

@property (nonatomic, strong) XLPageViewController *pageViewController;

@end

@implementation MINGCirclePageViewController
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

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"");
}


#pragma mark - XLPageViewControllerDelegate

- (void)pageViewController:(XLPageViewController *)pageViewController didSelectedAtIndex:(NSInteger)index
{
    NSLog(@"切换到了：%@",[self vcTitles][index]);
}

#pragma mark - XLPageViewControllerDataSrouce

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
        MINGCircleSelectionViewModel *viewModel = [[MINGCircleSelectionViewModel alloc] initWithSelectionType:MINGCircleSelectionTypeAll];
        MINGCircleSelectionViewController *controller = [[MINGCircleSelectionViewController alloc] initWithViewModel:viewModel];
        return controller;
        
    } else {
        MINGCircleSelectionViewModel *viewModel = [[MINGCircleSelectionViewModel alloc] initWithSelectionType:MINGCircleSelectionTypeAll];
        MINGCircleSelectionViewController *controller = [[MINGCircleSelectionViewController alloc] initWithViewModel:viewModel];
        return controller;
    }
}

#pragma mark - Actions

- (NSArray *)vcTitles
{
    return @[@"所有", @"我加入的"];
}


@end
