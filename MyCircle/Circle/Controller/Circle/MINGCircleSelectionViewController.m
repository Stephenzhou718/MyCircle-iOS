//
//  MINGCircleSelectionViewController.m
//  MyCircle
//
//  Created by 周汉明 on 2020/4/15.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGCircleSelectionViewController.h"
#import "MINGCircleSelectionCell.h"
#import "XLNavigationController.h"
#import "MINGCircleDetailViewModel.h"
#import "MINGCircleDetailController.h"

#import <Masonry/Masonry.h>
#import <MJRefresh/MJRefresh.h>
#import <SDWebImage/SDWebImage.h>

@interface MINGCircleSelectionViewController ()<UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MINGCircleSelectionViewModel *viewModel;

@end

@implementation MINGCircleSelectionViewController

- (instancetype)initWithViewModel:(MINGCircleSelectionViewModel *)viewModel
{
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
        [self configViews];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self.viewModel.refreshCommand.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    }];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [self refreshCircleItems];
}

- (void)configViews
{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.bottom.equalTo(self.view);
    }];
}


#pragma mark - Actions

- (void)refreshCircleItems
{
    [self.viewModel.refreshCommand execute:nil];
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    MINGCircleItem *circleItem = [self.viewModel.circleItems objectAtIndex:indexPath.row];
    MINGCircleDetailViewModel *viewModel = [[MINGCircleDetailViewModel alloc] initWithCircleItem:circleItem];
    MINGCircleDetailController *controller = [[MINGCircleDetailController alloc] initWithViewModel:viewModel];
    [controller.navigationItem setTitle:@"圈子"];
    [self.navigationController pushViewController:controller animated:YES];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.circleItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MINGCircleSelectionCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MINGCircleSelectionCell" forIndexPath:indexPath];
    MINGCircleItem *item = [self.viewModel.circleItems objectAtIndex:indexPath.row];
    
    [cell.cover sd_setImageWithURL:[NSURL URLWithString:item.circle.imgUrl]];
    cell.circleNameLabel.text = item.circle.name;
    cell.descriptionLabel.text = item.circle.circleDescription;
    return cell;
}




#pragma mark - lazy load

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_tableView registerClass:[MINGCircleSelectionCell class] forCellReuseIdentifier:@"MINGCircleSelectionCell"];
        
        // 刷新
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshCircleItems)];
    }
    return _tableView;
}


@end
