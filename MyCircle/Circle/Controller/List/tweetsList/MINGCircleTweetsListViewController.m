//
//  MINGCircleTweetsListViewController.m
//  MyCircle
//
//  Created by 周汉明 on 2020/4/15.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGCircleTweetsListViewController.h"
#import "UIColor+Hex.h"
#import "MINGTools.h"
#import "MINGTweetsTableViewCell.h"
#import "MINGTweetsDetailViewModel.h"
#import "MINGTweetsDetailViewController.h"

#import <MJRefresh/MJRefresh.h>
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>

@interface MINGCircleTweetsListViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MINGCircleTweetsListViewModel *viewModel;

@end

@implementation MINGCircleTweetsListViewController

- (instancetype)initWithViewModel:(MINGCircleTweetsListViewModel *)viewModel
{
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
        [self configSubviews];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[self.viewModel.refreshCommand.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
        [self.tableView reloadData];
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
    
    [self refreshTweetsItems];
}

- (void)configSubviews
{
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.bottom.equalTo(self.view);
    }];
}


#pragma mark - Actions

- (void)refreshTweetsItems
{
    [self.viewModel.refreshCommand execute:nil];
}

- (void)loadMoreTweetsItems
{
    [self.viewModel.loadMoreCommand execute:nil];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 280;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    MINGTweetsDetailViewModel *viewModel = [[MINGTweetsDetailViewModel alloc] initWithTweetsItem:self.viewModel.tweetsItems[indexPath.row]];
    MINGTweetsDetailViewController *controller = [[MINGTweetsDetailViewController alloc] initWithViewModel:viewModel];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.tweetsItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MINGTweetsTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MINGTweetsTableViewCell" forIndexPath:indexPath];
    MINGTweetsItem *tweetsItem = self.viewModel.tweetsItems[indexPath.row];
    [cell.authorAvatar sd_setImageWithURL:[NSURL URLWithString:tweetsItem.author.headUrl]];
    cell.authorNameLabel.text = tweetsItem.author.nickname;
    cell.timeLabel.text = [MINGTools converTimeStampToString:tweetsItem.tweets.time];
    cell.contentlabel.text = tweetsItem.tweets.content;
    cell.likeCountLabel.text = [NSString stringWithFormat:@"%@",@(tweetsItem.tweets.likeCount)];
    cell.commentCountLabel.text = [NSString stringWithFormat:@"%@",@(tweetsItem.tweets.commentCount)];
    
    NSArray<NSURL *> *urls = [MINGTools spiltStringToUrls:tweetsItem.tweets.imgs];
    if (urls.count >= 1) {
        [cell.imageOne sd_setImageWithURL:urls[0]];
    }
    if (urls.count >= 2) {
        [cell.imageTwo sd_setImageWithURL:urls[1]];
    }
    if (urls.count >= 3) {
        [cell.imageThree sd_setImageWithURL:urls[2]];
    }
    return cell;
}


#pragma mark - lazy load

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"F8F8F8"];
        [_tableView registerClass:[MINGTweetsTableViewCell class] forCellReuseIdentifier:@"MINGTweetsTableViewCell"];
        
        
        // 刷新和 loadMore
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshTweetsItems)];
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTweetsItems)];
    }
    return _tableView;
}


@end
