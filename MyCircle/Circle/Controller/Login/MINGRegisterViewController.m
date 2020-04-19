//
//  MINGRegisterViewController.m
//  MyCircle
//
//  Created by 周汉明 on 2020/4/16.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGRegisterViewController.h"
#import "MINGTabBarViewController.h"

#import <Masonry/Masonry.h>
#import <Toast/Toast.h>

@interface MINGRegisterViewController ()

@property (nonatomic, strong) UITextField *usernameTextField;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UIButton *registButton;

@property (nonatomic, strong) MINGRegisterViewModel *viewModel;

@end

@implementation MINGRegisterViewController

- (id)initWithViewModel:(MINGRegisterViewModel *)viewModel
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
    [[self.viewModel.registerCommand.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        
        // tab bar controllers
        MINGTabBarViewController *controller = [[MINGTabBarViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }];
    
    [self.viewModel.registerCommand.errors subscribeNext:^(NSError * _Nullable x) {
        @strongify(self)
        [self.view makeToast:self.viewModel.errorMsg duration:2 position:CSToastPositionCenter];
    }];
}

- (void)configSubViews
{
    [self.view addSubview:self.usernameTextField];
    [self.view addSubview:self.passwordTextField];
    [self.view addSubview:self.registButton];
    
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
    
    [self.registButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.passwordTextField.mas_bottom).offset(40);
        make.width.equalTo(@200);
        make.height.equalTo(@40);
    }];
}

#pragma mark - Actions

- (void)registerButtonClicked:(UIButton *)button
{
    
    [self.viewModel loadUsername:self.usernameTextField.text];
    [self.viewModel loadPassword:self.passwordTextField.text];
    [self.viewModel.registerCommand execute:nil];
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

- (UIButton *)registButton
{
    if (!_registButton) {
        _registButton = [[UIButton alloc] init];
        [_registButton setTitle:@"Register" forState:UIControlStateNormal];
        [_registButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_registButton addTarget:self action:@selector(registerButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registButton;
}


@end
