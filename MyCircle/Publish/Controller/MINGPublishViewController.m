//
//  MINGPublishViewController.m
//  MyCircle
//
//  Created by 周汉明 on 2020/4/11.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGPublishViewController.h"
#import "MINGPublishTweetsViewModel.h"
#import "MINGPublishVideoViewModel.h"
#import "MINGPublishVideoViewController.h"
#import "MINGPublishTweetsViewController.h"
#import "UIColor+Hex.h"

#import <Masonry/Masonry.h>

@interface MINGPublishViewController ()

@property (nonatomic, strong) UIView *publishTweetsView;
@property (nonatomic, strong) UIView *publishVideoView;
@property (nonatomic, strong) UIImageView *publishVideoIcon;
@property (nonatomic, strong) UIImageView *publishTweetsIcon;
@property (nonatomic, strong) UIButton *publishTweetsButton;
@property (nonatomic, strong) UIButton *publishVideoButton;

@end

@implementation MINGPublishViewController

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
    // Do any additional setup after loading the view.
}

- (void)configSubViews
{
    [self.view addSubview:self.publishTweetsView];
    [self.view addSubview:self.publishVideoView];
    
    [self.publishTweetsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).offset(40);
        make.trailing.equalTo(self.view).offset(-40);
        make.centerY.equalTo(self.view).offset(-150);
        make.height.equalTo(@200);
    }];
    
    [self.publishVideoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).offset(40);
        make.trailing.equalTo(self.view).offset(-40);
        make.centerY.equalTo(self.view).offset(150);
        make.height.equalTo(@200);
    }];
    
    [self.publishTweetsView addSubview:self.publishTweetsIcon];
    [self.publishTweetsView addSubview:self.publishTweetsButton];
    
    [self.publishTweetsIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.publishTweetsView).offset(30);
        make.centerX.equalTo(self.publishTweetsView);
        make.width.and.height.equalTo(@60);
    }];
    [self.publishTweetsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.publishTweetsIcon.mas_bottom).offset(20);
        make.centerX.equalTo(self.publishTweetsView);
        make.width.and.height.greaterThanOrEqualTo(@0);
    }];
    
    [self.publishVideoView addSubview:self.publishVideoIcon];
    [self.publishVideoView addSubview:self.publishVideoButton];
    
    [self.publishVideoIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.publishVideoView).offset(30);
        make.centerX.equalTo(self.publishVideoView);
        make.width.and.height.equalTo(@60);
    }];
    [self.publishVideoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.publishVideoIcon.mas_bottom).offset(20);
        make.centerX.equalTo(self.publishVideoView);
        make.width.and.height.greaterThanOrEqualTo(@0);
    }];
}



#pragma mark - Actions

- (void)publishTweetsButtonDidClicked:(id)sender
{
    MINGPublishTweetsViewModel *viewModel = [[MINGPublishTweetsViewModel alloc] init];
    MINGPublishTweetsViewController *controller = [[MINGPublishTweetsViewController alloc] initWithViewModel:viewModel];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)publishVideoButtonDidClicked:(id)sender
{
    MINGPublishVideoViewModel *viewModel = [[MINGPublishVideoViewModel alloc] init];
    MINGPublishVideoViewController *controller = [[MINGPublishVideoViewController alloc] initWithViewModel:viewModel];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - lazy load

- (UIView *)publishTweetsView
{
    if (!_publishTweetsView) {
        _publishTweetsView = [[UIView alloc] init];
        _publishTweetsView.backgroundColor = [UIColor colorWithHexString:@"57B0F1"];
        _publishTweetsView.layer.cornerRadius = 20;
        _publishTweetsView.layer.shadowColor = [UIColor blackColor].CGColor;
        _publishTweetsView.layer.shadowOffset = CGSizeMake(10, 15);
        _publishTweetsView.layer.shadowOpacity = 0.2;
        [_publishTweetsView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(publishTweetsButtonDidClicked:)]];
    }
    return _publishTweetsView;
}

- (UIView *)publishVideoView
{
    if (!_publishVideoView) {
        _publishVideoView = [[UIView alloc] init];
        _publishVideoView.backgroundColor = [UIColor colorWithHexString:@"3D389F"];
        _publishVideoView.layer.cornerRadius = 20;
        _publishVideoView.layer.shadowColor = [UIColor blackColor].CGColor;
        _publishVideoView.layer.shadowOffset = CGSizeMake(10, 15);
        _publishVideoView.layer.shadowOpacity = 0.2;
        [_publishVideoView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(publishVideoButtonDidClicked:)]];
    }
    return _publishVideoView;
}

- (UIImageView *)publishTweetsIcon
{
    if (!_publishTweetsIcon) {
        _publishTweetsIcon = [[UIImageView alloc] init];
        _publishTweetsIcon.image = [UIImage imageNamed:@"publish_tweets"];
    }
    return _publishTweetsIcon;
}

- (UIImageView *)publishVideoIcon
{
    if (!_publishVideoIcon) {
        _publishVideoIcon = [[UIImageView alloc] init];
        _publishVideoIcon.image = [UIImage imageNamed:@"publish_video"];
    }
    return _publishVideoIcon;
}


- (UIButton *)publishTweetsButton
{
    if (!_publishTweetsButton) {
        _publishTweetsButton = [[UIButton alloc] init];
        _publishTweetsButton.titleLabel.font = [UIFont systemFontOfSize:30 weight:UIFontWeightHeavy];
        [_publishTweetsButton setTitle:@"发布推文" forState:UIControlStateNormal];
        [_publishTweetsButton addTarget:self action:@selector(publishTweetsButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _publishTweetsButton;
}

- (UIButton *)publishVideoButton
{
    if (!_publishVideoButton) {
        _publishVideoButton = [[UIButton alloc] init];
        _publishVideoButton.titleLabel.font = [UIFont systemFontOfSize:30 weight:UIFontWeightHeavy];
        [_publishVideoButton setTitle:@"发布视频" forState:UIControlStateNormal];
        [_publishVideoButton addTarget:self action:@selector(publishVideoButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _publishVideoButton;
}




@end
