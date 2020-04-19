//
//  MINGLoginViewController.m
//  MyCircle
//
//  Created by 周汉明 on 2020/4/16.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGLoginViewController.h"
#import "MINGCircleVideoListViewModel.h"
#import "MINGCircleVideoListController.h"
#import "MINGProfileViewController.h"
#import "MINGVideoFeedViewController.h"
#import "MINGCirclePageViewController.h"
#import "XLNavigationController.h"
#import "MINGLoginPageViewController.h"
#import "MINGTabBarViewController.h"

#import "MINGCircleVideoListViewModel.h"

#import <Masonry/Masonry.h>
#import <Toast/Toast.h>

@interface MINGLoginViewController ()

@property (nonatomic, strong) UITextField *usernameTextField;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UIButton *loginButton;

@property (nonatomic, strong) MINGLoginViewModel *viewModel;

@end

@implementation MINGLoginViewController

- (instancetype)initWithViewModel:(MINGLoginViewModel *)viewModel
{
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
        [self configSubViews];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    @weakify(self)
    [[self.viewModel.loginCommand.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        
        // tab bar controllers
        MINGTabBarViewController *controller = [[MINGTabBarViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }];
    
    [self.viewModel.loginCommand.errors subscribeNext:^(NSError * _Nullable x) {
        @strongify(self)
        NSString *msg = [x.userInfo objectForKey:NSLocalizedDescriptionKey];
        [self.view makeToast:msg duration:2 position:CSToastPositionCenter];
    }];
}

- (void)configSubViews
{
    [self.view addSubview:self.usernameTextField];
    [self.view addSubview:self.passwordTextField];
    [self.view addSubview:self.loginButton];
    
    [self.usernameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(100);
        make.width.equalTo(@200);
        make.height.equalTo(@40);
    }];
    
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.usernameTextField.mas_bottom).offset(40);
        make.width.equalTo(@200);
        make.height.equalTo(@40);
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.passwordTextField.mas_bottom).offset(40);
        make.width.equalTo(@200);
        make.height.equalTo(@40);
    }];
}


#pragma mark - Actions

- (void)loginButtonClicked:(UIButton *)button
{
    MINGUser *user = [MINGUser new];
    user.username = self.usernameTextField.text;
    [self.viewModel setUserInfoWithUser:user];
    [self.viewModel setPass:self.passwordTextField.text];
    [self.viewModel.loginCommand execute:nil];
}

#pragma mark - lazy load

- (UITextField *)usernameTextField
{
    if (!_usernameTextField) {
        _usernameTextField = [[UITextField alloc] init];
        _usernameTextField.placeholder = @"Username";
        _usernameTextField.borderStyle = UITextBorderStyleRoundedRect;
    }
    return _usernameTextField;
}

- (UITextField *)passwordTextField
{
    if (!_passwordTextField) {
        _passwordTextField = [UITextField new];
        _passwordTextField.placeholder = @"Password";
        _passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
        [_passwordTextField setSecureTextEntry:YES];
    }
    return _passwordTextField;
}

- (UIButton *)loginButton
{
    if (!_loginButton) {
        _loginButton = [[UIButton alloc] init];
        [_loginButton setTitle:@"Login" forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_loginButton addTarget:self action:@selector(loginButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}


@end
