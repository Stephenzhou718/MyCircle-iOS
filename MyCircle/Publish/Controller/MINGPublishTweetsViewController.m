//
//  MINGPublishTweetsViewController.m
//  MyCircle
//
//  Created by 周汉明 on 2020/4/17.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGPublishTweetsViewController.h"

@interface MINGPublishTweetsViewController ()

@property (nonatomic, strong) MINGPublishTweetsViewModel *viewModel;

@end

@implementation MINGPublishTweetsViewController

- (instancetype)initWithViewModel:(MINGPublishTweetsViewModel *)viewModel
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
