//
//  MINGRegisterViewController.m
//  MyCircle
//
//  Created by 周汉明 on 2020/4/16.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGRegisterViewController.h"

@interface MINGRegisterViewController ()

@property (nonatomic, strong) MINGLoginViewModel *viewModel;

@end

@implementation MINGRegisterViewController

- (id)initWithViewModel:(MINGLoginViewModel *)viewModel
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
