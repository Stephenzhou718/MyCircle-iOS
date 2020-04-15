//
//  MINGCiecleViewController.m
//  MyCircle
//
//  Created by 周汉明 on 2020/3/21.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGCircleVideoListController.h"
#import "MINGVideoCellView.h"
#import "MINGCircleVideoListViewModel.h"
#import "MINGVideoDetailViewModel.h"
#import "MINGVideoDetailViewController.h"

#import <Masonry/Masonry.h>
#import <WMPlayer/WMPlayer.h>
#import <SDWebImage/SDWebImage.h>
#import <MJRefresh/MJRefresh.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <ReactiveObjC/ReactiveObjC.h>

@interface MINGCircleVideoListController ()
<
UITableViewDelegate,
UITableViewDataSource,
UIScrollViewDelegate,
WMPlayerDelegate
>

@property (nonatomic, strong) MINGCircleVideoListViewModel *viewModel;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) WMPlayer *player;

@end

@implementation MINGCircleVideoListController

#pragma mark - life circle
- (instancetype)initWithViewModel:(MINGCircleVideoListViewModel *)viewModel
{
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
        [self configureSubViews];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self.viewModel.refreshCommand.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    }];
    
    @weakify(self)
    [[self.viewModel.refreshCommand.executionSignals switchToLatest] subscribeError:^(NSError * _Nullable error) {
        @strongify(self)
        [self __showToastL:[error.userInfo objectForKey:@"msg"]];
        [self.tableView.mj_header endRefreshing];
    }];
    
    [[self.viewModel.loadMoreCommand.executionSignals switchToLatest] subscribeNext:^(NSNumber *x) {
        [self.tableView reloadData];
        if (x.boolValue) {
            [self.tableView.mj_footer endRefreshing];
        } else {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.viewModel.refreshCommand execute:nil];
}

- (void)configureSubViews
{
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).offset(20);
        make.trailing.equalTo(self.view).offset(-20);
        make.top.and.bottom.equalTo(self.view);
    }];
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 310;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    MINGVideoDetailViewModel *viewModel = [[MINGVideoDetailViewModel alloc] initWithVideoItem:[self.viewModel.videoItems objectAtIndex:indexPath.row]];
    MINGVideoDetailViewController *controller = [[MINGVideoDetailViewController alloc] initWithViewModel:viewModel];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.videoItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MINGVideoCellView *cell = [tableView dequeueReusableCellWithIdentifier:@"MINGVideoCellView" forIndexPath:indexPath];
    MINGVideoItem *videoItem = [self.viewModel.videoItems objectAtIndex:indexPath.row];
    
    [cell.cover sd_setImageWithURL:[NSURL URLWithString:videoItem.video.coverUrl]];
    [cell.authorHeaderView sd_setImageWithURL:[NSURL URLWithString:videoItem.author.headUrl]];
    cell.authorNickName.text = videoItem.author.nickname;
    cell.commentCountLabel.text = [NSString stringWithFormat:@"%@",@(videoItem.video.commentCount)];
    cell.likeCountLabel.text = [NSString stringWithFormat:@"%@", @(videoItem.video.likeCount)];
    cell.title.text = videoItem.video.title;
    return cell;
}


#pragma mark - private

- (void)__showToastL:(NSString *)msg
{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.label.text = msg;
    HUD.mode = MBProgressHUDModeText;
    HUD.minShowTime = 2;
    [HUD showAnimated:YES];
}

#pragma mark - Action

- (void)refreshVideoItems
{
    [self.viewModel.refreshCommand execute:nil];
}

- (void)loadMoreVideoItems
{
    [self.viewModel.loadMoreCommand execute:nil];
}

#pragma mark - lazy load

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor lightGrayColor];
        
        [_tableView registerClass:[MINGVideoCellView class] forCellReuseIdentifier:@"MINGVideoCellView"];
        
        // 刷新和 loadmore
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshVideoItems)];
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreVideoItems)];
    }
    
    return _tableView;
}

- (WMPlayer *)player
{
    if (!_player) {
        WMPlayerModel *playerModel = [WMPlayerModel new];
        playerModel.title = @"title";
        playerModel.videoURL = [NSURL URLWithString:@"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4"];
        _player = [[WMPlayer alloc] initPlayerModel:playerModel];
    }
    return _player;
}

@end
