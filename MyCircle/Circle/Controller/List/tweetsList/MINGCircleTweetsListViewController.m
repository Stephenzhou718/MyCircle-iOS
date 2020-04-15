//
//  MINGCircleTweetsListViewController.m
//  MyCircle
//
//  Created by 周汉明 on 2020/4/15.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGCircleTweetsListViewController.h"

@interface MINGCircleTweetsListViewController ()

@property (nonatomic, strong) MINGCircleTweetsListViewModel *viewModel;

@end

@implementation MINGCircleTweetsListViewController

- (instancetype)initWithViewModel:(MINGCircleTweetsListViewModel *)viewModel
{
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

@end
