//
//  MINGCircleDetailController.m
//  MyCircle
//
//  Created by 周汉明 on 2020/4/15.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGCircleDetailController.h"
#import "MINGCircleVideoListViewModel.h"
#import "MINGCircleVideoListController.h"
#import "MINGCircleTweetsListViewModel.h"
#import "MINGCircleTweetsListViewController.h"
#import "XLPageViewController.h"
#import "UIColor+Hex.h"
#import "MINGUserListViewModel.h"
#import "MINGUserListViewController.h"

#import <ReactiveObjC/ReactiveObjC.h>
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>

@interface MINGCircleDetailController ()
<
XLPageViewControllerDelegate,
XLPageViewControllerDataSrouce
>


@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIImageView *coverView;
@property (nonatomic, strong) UIImageView *circleIcon;
@property (nonatomic, strong) UILabel *circleNameLabel;

@property (nonatomic, strong) UIView *infoView;
@property (nonatomic, strong) UILabel *circleMemberCountLabel;
@property (nonatomic, strong) UIView *circleMembersView;
@property (nonatomic, strong) UIImageView *circleMemberOneView;
@property (nonatomic, strong) UIImageView *circleMemberTwoView;
@property (nonatomic, strong) UIImageView *circleMemberThreeView;
@property (nonatomic, strong) UIButton *joinCircleButton;
@property (nonatomic, strong) UILabel *descriptionLabel;

@property (nonatomic, strong) XLPageViewController *pageViewController;

@property (nonatomic, strong) MINGCircleDetailViewModel *viewModel;

@end

@implementation MINGCircleDetailController


#pragma mark - life circle

- (instancetype)initWithViewModel:(MINGCircleDetailViewModel *)viewModel
{
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
        [self configSubViews];
        [self loadData];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"F8F8F8"];
    
    if (self.viewModel.circleItem.hasJoined) {
        self.joinCircleButton.selected = YES;
        self.joinCircleButton.backgroundColor = [UIColor colorWithHexString:@"F0F0F0"];
    } else {
        self.joinCircleButton.selected = NO;
        self.joinCircleButton.backgroundColor = [UIColor orangeColor];
    }
    
    @weakify(self)
    [[self.viewModel.getCircleMembersCommand.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        if (self.viewModel.circleMembers.count >= 1) {
            [self.circleMemberOneView sd_setImageWithURL:[NSURL URLWithString:self.viewModel.circleMembers[0].user.headUrl]];
        }
        if (self.viewModel.circleMembers.count >= 2) {
            [self.circleMemberTwoView sd_setImageWithURL:[NSURL URLWithString:self.viewModel.circleMembers[1].user.headUrl]];
        }
        if (self.viewModel.circleMembers.count >= 3) {
            [self.circleMemberThreeView sd_setImageWithURL:[NSURL URLWithString:self.viewModel.circleMembers[2].user.headUrl]];
        }
    
        self.circleMemberCountLabel.text = [NSString stringWithFormat:@"共有 %@ 名圈友", @(self.viewModel.circleMembers.count)];
    }];
    
    [[self.viewModel.joinCircleCommand.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
        self.joinCircleButton.selected = YES;
        self.joinCircleButton.backgroundColor = [UIColor colorWithHexString:@"F0F0F0"];
    }];
    
    [[self.viewModel.quitCircleCommand.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
        self.joinCircleButton.selected = NO;
        self.joinCircleButton.backgroundColor = [UIColor orangeColor];
    }];
    
    [self.viewModel.getCircleMembersCommand execute:nil];
    
    
}

- (void)loadData
{
    MINGCircleItem *circleItem = self.viewModel.circleItem;
    [self.coverView sd_setImageWithURL:[NSURL URLWithString:circleItem.circle.imgUrl]];
    self.circleNameLabel.text = circleItem.circle.name;
    self.descriptionLabel.text = circleItem.circle.circleDescription;
}

- (void)configSubViews
{
    [self.view addSubview:self.headerView];
    [self.headerView addSubview:self.coverView];
    [self.headerView addSubview:self.circleIcon];
    [self.headerView addSubview:self.circleNameLabel];
    
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.equalTo(self.view);
        make.height.equalTo(@180);
    }];
    [self.coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.bottom.equalTo(self.headerView);
    }];
    [self.circleNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.headerView);
        make.height.and.width.greaterThanOrEqualTo(@0);
    }];
    [self.circleIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.circleNameLabel);
        make.trailing.equalTo(self.circleNameLabel.mas_leading).offset(-5);
        make.width.and.height.equalTo(@24);
    }];
    
    [self.view addSubview:self.infoView];
    [self.infoView addSubview:self.circleMemberCountLabel];
    [self.infoView addSubview:self.circleMembersView];
    [self.infoView addSubview:self.joinCircleButton];
    [self.infoView addSubview:self.descriptionLabel];
    
    [self.infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom);
        make.leading.and.trailing.equalTo(self.view);
        make.height.equalTo(@120);
    }];
    [self.circleMemberCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.infoView);
        make.top.equalTo(self.infoView).offset(16);
        make.width.and.height.greaterThanOrEqualTo(@0);
    }];
    [self.circleMembersView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.circleMemberCountLabel.mas_bottom).offset(8);
        make.leading.equalTo(self.infoView).offset(100);
        make.height.equalTo(@40);
        make.width.equalTo(@100);
    }];
    [self.joinCircleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.circleMembersView.mas_trailing).offset(40);
        make.centerY.equalTo(self.circleMembersView);
        make.width.equalTo(@114);
        make.height.equalTo(@30);
    }];
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.infoView).offset(30);
        make.trailing.equalTo(self.infoView).offset(30);
//        make.bottom.equalTo(self.infoView).offset(3);
        make.top.equalTo(self.circleMembersView.mas_bottom).offset(3);
    }];
    
    [self.circleMembersView addSubview:self.circleMemberThreeView];
    [self.circleMembersView addSubview:self.circleMemberTwoView];
    [self.circleMembersView addSubview:self.circleMemberOneView];
    
    
    
    [self.circleMemberOneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.circleMembersView);
        make.leading.equalTo(self.circleMembersView);
        make.width.and.height.equalTo(@30);
    }];
    [self.circleMemberTwoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.circleMembersView);
        make.leading.equalTo(self.circleMembersView).offset(30);
        make.width.and.height.equalTo(@30);
    }];
    [self.circleMemberThreeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.circleMembersView);
        make.leading.equalTo(self.circleMembersView).offset(60);
        make.width.and.height.equalTo(@30);
    }];
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self.view);
        make.top.equalTo(self.infoView.mas_bottom).offset(8);
    }];
}



#pragma mark - Actions

- (NSArray *)vcTitles
{
    return @[@"视频模式", @"图文模式"];
}


- (void)membersViewDidClicked:(id)sender
{
    MINGUserListViewModel *viewModel = [[MINGUserListViewModel alloc] initWithMINGUserItems:self.viewModel.circleMembers];
    MINGUserListViewController *controller = [[MINGUserListViewController alloc] initWithViewModel:viewModel];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)joinCircleButtonDidClicked:(id)sender
{
    if (self.joinCircleButton.isSelected) {
        // 退出圈子
        [self.viewModel.quitCircleCommand execute:nil];
    } else {
        // 加入圈子
        [self.viewModel.joinCircleCommand execute:nil];
    }
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
        MINGCircleVideoListViewModel *viewModel = [[MINGCircleVideoListViewModel alloc] initWithCircleId:self.viewModel.circleItem.circle.circleId];
        MINGCircleVideoListController *controller = [[MINGCircleVideoListController alloc] initWithViewModel:viewModel];
        return controller;
    } else {
        MINGCircleTweetsListViewModel *viewModel = [[MINGCircleTweetsListViewModel alloc] initWithCircleId:self.viewModel.circleItem.circle.circleId];
        MINGCircleTweetsListViewController *viewController = [[MINGCircleTweetsListViewController alloc] initWithViewModel:viewModel];
        return viewController;
    }
}


#pragma mark - lazy load

- (UIView *)headerView
{
    if (!_headerView) {
        _headerView = [[UIView alloc] init];
        _headerView.contentMode = UIViewContentModeScaleToFill;
    }
    return _headerView;
}

- (UIImageView *)coverView
{
    if (!_coverView) {
        _coverView = [[UIImageView alloc] init];
    }
    return _coverView;
}

- (UIImageView *)circleIcon
{
    if (!_circleIcon) {
        _circleIcon = [[UIImageView alloc] init];
        _circleIcon.image = [UIImage imageNamed:@"circle_head"];
    }
    return _circleIcon;
}

- (UILabel *)circleNameLabel
{
    if (!_circleNameLabel) {
        _circleNameLabel = [[UILabel alloc] init];
        _circleNameLabel.font = [UIFont systemFontOfSize:24];
        _circleNameLabel.textColor = [UIColor whiteColor];
    }
    return _circleNameLabel;
}

- (UIView *)infoView
{
    if (!_infoView) {
        _infoView = [[UIView alloc] init];
        _infoView.backgroundColor = [UIColor whiteColor];
    }
    return _infoView;
}

- (UILabel *)circleMemberCountLabel
{
    if (!_circleMemberCountLabel) {
        _circleMemberCountLabel = [[UILabel alloc] init];
        _circleMemberCountLabel.font = [UIFont systemFontOfSize:14];
        _circleMemberCountLabel.textColor = [UIColor colorWithHexString:@"404040"];
    }
    return _circleMemberCountLabel;
}

- (UIView *)circleMembersView
{
    if (!_circleMembersView) {
        _circleMembersView = [UIView new];
        _circleMembersView.userInteractionEnabled = YES;
        [_circleMembersView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(membersViewDidClicked:)]];
    }
    return _circleMembersView;
}

- (UIImageView *)circleMemberOneView
{
    if (!_circleMemberOneView) {
        _circleMemberOneView = [UIImageView new];
        _circleMemberOneView.layer.cornerRadius = 15;
        _circleMemberOneView.layer.masksToBounds = YES;
        _circleMemberOneView.userInteractionEnabled = YES;
    }
    return _circleMemberOneView;
}

- (UIImageView *)circleMemberTwoView
{
    if (!_circleMemberTwoView) {
        _circleMemberTwoView = [UIImageView new];
        _circleMemberTwoView.layer.cornerRadius = 15;
        _circleMemberTwoView.layer.masksToBounds = YES;
        _circleMemberTwoView.userInteractionEnabled = YES;
    }
    return _circleMemberTwoView;
}

- (UIImageView *)circleMemberThreeView
{
    if (!_circleMemberThreeView) {
        _circleMemberThreeView = [UIImageView new];
        _circleMemberThreeView.layer.cornerRadius = 15;
        _circleMemberThreeView.layer.masksToBounds = YES;
        _circleMemberThreeView.userInteractionEnabled = YES;
    }
    return _circleMemberThreeView;
}


- (UIButton *)joinCircleButton
{
    if (!_joinCircleButton) {
        _joinCircleButton = [[UIButton alloc] init];
        _joinCircleButton.layer.cornerRadius = 15;
        _joinCircleButton.layer.masksToBounds = YES;
        [_joinCircleButton setTitle:@"+加入圈子" forState:UIControlStateNormal];
        [_joinCircleButton setTitle:@"退出圈子" forState:UIControlStateSelected];
        _joinCircleButton.backgroundColor = [UIColor orangeColor];
        _joinCircleButton.titleLabel.textColor = [UIColor whiteColor];
        _joinCircleButton.titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightBold];
        [_joinCircleButton addTarget:self action:@selector(joinCircleButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _joinCircleButton;
}

- (UILabel *)descriptionLabel
{
    if (!_descriptionLabel) {
        _descriptionLabel = [[UILabel alloc] init];
        _descriptionLabel.font = [UIFont systemFontOfSize:14];
        _descriptionLabel.textColor = [UIColor colorWithHexString:@"808080"];
        _descriptionLabel.numberOfLines = 0;
    }
    return _descriptionLabel;
}

- (XLPageViewController *)pageViewController
{
    if (!_pageViewController) {
        XLPageViewControllerConfig *config = [XLPageViewControllerConfig defaultConfig];
        config.titleSelectedColor = [UIColor orangeColor];
        config.shadowLineColor = [UIColor orangeColor];
        config.showTitleInNavigationBar = false;
        config.titleViewStyle = XLPageTitleViewStyleBasic;
        config.textVerticalAlignment = XLPageTitleViewAlignmentLeft;
        config.shadowLineAnimationType = XLPageShadowLineAnimationTypeZoom;
        config.separatorLineHidden = true;
        // 设置缩进
        config.titleViewInset = UIEdgeInsetsMake(5, 50, 5, 50);
        
        _pageViewController = [[XLPageViewController alloc] initWithConfig:config];
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
    }
    return _pageViewController;
}




@end
