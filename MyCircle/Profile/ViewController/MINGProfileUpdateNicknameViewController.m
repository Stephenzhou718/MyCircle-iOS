//
//  MINGProfileUpdateNicknameViewController.m
//  MyCircle
//
//  Created by 周汉明 on 2020/4/18.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGProfileUpdateNicknameViewController.h"
#import "UIColor+Hex.h"

#import <Masonry/Masonry.h>
#import <Toast/Toast.h>

@interface MINGProfileUpdateNicknameViewController ()

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIBarButtonItem *finishButton;

@property (nonatomic, strong) MINGProfileUpdateNicknameViewModel *viewModel;

@end

@implementation MINGProfileUpdateNicknameViewController

- (instancetype)initWithViewModel:(MINGProfileUpdateNicknameViewModel *)viewModel
{
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSubViews];
    self.navigationItem.rightBarButtonItem = self.finishButton;
    self.view.backgroundColor = [UIColor colorWithHexString:@"F8F8F8"];
    [[self.viewModel.updateNicknameCommand.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
        [self.view makeToast:@"修改成功" duration:1 position:CSToastPositionCenter];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    }];
}

- (void)configSubViews
{
    [self.view addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.equalTo(self.view);
        make.height.equalTo(@40);
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.textField becomeFirstResponder];
}

#pragma mark - Action

- (void)finishButtonClicked:(id)sender
{
    self.viewModel.nickname = self.textField.text;
    [self.viewModel.updateNicknameCommand execute:nil];
}


#pragma mark - lazy load

- (UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.backgroundColor = [UIColor whiteColor];
    }
    return _textField;
}

- (UIBarButtonItem *)finishButton
{
    if (!_finishButton) {
        _finishButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(finishButtonClicked:)];
    }
    return _finishButton;
}

@end
