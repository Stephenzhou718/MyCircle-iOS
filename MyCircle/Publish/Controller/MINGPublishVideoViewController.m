//
//  MINGPublishVideoViewController.m
//  MyCircle
//
//  Created by 周汉明 on 2020/4/17.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGPublishVideoViewController.h"

@interface MINGPublishVideoViewController ()

@property (nonatomic, strong) MINGPublishVideoViewModel *viewModel;

@end

@implementation MINGPublishVideoViewController

- (instancetype)initWithViewModel:(MINGPublishVideoViewModel *)viewModel
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
