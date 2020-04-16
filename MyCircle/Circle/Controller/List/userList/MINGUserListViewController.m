//
//  MINGUserListViewController.m
//  MyCircle
//
//  Created by 周汉明 on 2020/4/16.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGUserListViewController.h"
#import "MINGUserTableViewCell.h"

#import <SDWebImage/SDWebImage.h>
#import <Masonry/Masonry.h>

@interface MINGUserListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MINGUserListViewModel *viewModel;

@end

@implementation MINGUserListViewController


- (instancetype)initWithViewModel:(MINGUserListViewModel *)viewModel
{
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
        [self configSubViews];
        self.tableView.backgroundColor = [UIColor whiteColor];
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)configSubViews
{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.bottom.equalTo(self.view);
    }];
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 72;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.userItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MINGUserTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MINGUserTableViewCell" forIndexPath:indexPath];
    MINGUserItem *userItem = self.viewModel.userItems[indexPath.row];
    [cell.userAvatar sd_setImageWithURL:[NSURL URLWithString:userItem.user.headUrl]];
    cell.nicknameLabel.text = userItem.user.nickname;
    cell.descriptionLabel.text = userItem.user.signature;
    return cell;
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
        
        [_tableView registerClass:[MINGUserTableViewCell class] forCellReuseIdentifier:@"MINGUserTableViewCell"];
    }
    return _tableView;
}


@end
