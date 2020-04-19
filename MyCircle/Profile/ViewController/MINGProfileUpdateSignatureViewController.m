//
//  MINGProfileUpdateSignatureViewController.m
//  MyCircle
//
//  Created by 周汉明 on 2020/4/18.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGProfileUpdateSignatureViewController.h"
#import "UIColor+Hex.h"

#import <Masonry/Masonry.h>
#import <Toast/Toast.h>
#import <UITextView+ZWPlaceHolder.h>


@interface MINGProfileUpdateSignatureViewController ()

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIBarButtonItem *finishButton;
@property (nonatomic ,strong) MINGProfileUpdateSignatureViewModel *viewModel;

@end

@implementation MINGProfileUpdateSignatureViewController

- (instancetype)initWithViewModel:(MINGProfileUpdateSignatureViewModel *)viewModel
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
    
    [[self.viewModel.updateSignatureCommand.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
        [self.view makeToast:@"更新成功" duration:1 position:CSToastPositionCenter];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    }];
}

- (void)configSubViews
{
    [self.view addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.equalTo(self.view);
        make.height.equalTo(@150);
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.textView becomeFirstResponder];
}

#pragma mark - Actions

- (void)finishButtonClicked:(id)sender
{
    self.viewModel.signature = self.textView.text;
    [self.viewModel.updateSignatureCommand execute:nil];
}

#pragma mark - lazy load

- (UITextView *)textView
{
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.zw_placeHolder = @"";
        _textView.font = [UIFont systemFontOfSize:14];
        _textView.backgroundColor = [UIColor whiteColor];
    }
    return _textView;
}

- (UIBarButtonItem *)finishButton
{
    if (!_finishButton) {
        _finishButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(finishButtonClicked:)];
    }
    return _finishButton;
}




@end
