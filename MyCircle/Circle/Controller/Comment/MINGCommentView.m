//
//  MINGCommentView.m
//  MyCircle
//
//  Created by 周汉明 on 2020/4/14.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGCommentView.h"
#import "UIColor+Hex.h"
#import "MINGCommentCell.h"
#import "MINGTools.h"

#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>
#import <MJRefresh/MJRefresh.h>

@interface MINGCommentView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIView *commentCountView;
@property (nonatomic, strong) UILabel *commentCountLabel;
@property (nonatomic, strong) UIView *commentCountSepLine;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MINGCommentViewModel *viewModel;

@end

@implementation MINGCommentView

#pragma mark - life circle

- (instancetype)initWithViewModel:(MINGCommentViewModel *)viewModel
{
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
        [self configSubViews];
        [self bindCommand];
        
    }
    return self;
}

- (void)configSubViews
{
    // 总的评论数
    [self addSubview:self.commentCountView];
    [self.commentCountView addSubview:self.commentCountLabel];
    [self.commentCountView addSubview:self.commentCountSepLine];
        
    [self.commentCountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.equalTo(self);
        make.height.equalTo(@44);
    }];
    
    [self.commentCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.commentCountView);
        make.leading.equalTo(self.commentCountView).offset(16);
    }];
    
    [self.commentCountSepLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self.commentCountView);
        make.height.equalTo(@1);
    }];
    
    
    // 评论
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self);
        make.top.equalTo(self.commentCountView.mas_bottom);
    }];
}

- (void)loadData
{
    self.commentCountLabel.text = [NSString stringWithFormat:@"已展示 %@ 条评论, 上滑加载更多～", @(self.viewModel.commentItems.count)];
}

- (void)loadDataWithNoMore
{
    self.commentCountLabel.text = [NSString stringWithFormat:@"已展示 %@ 条评论, 没有更多啦～", @(self.viewModel.commentItems.count)];
}

- (void)bindCommand
{
    [[self.viewModel.refreshCommand.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
        [self.tableView reloadData];
        [self loadData];
        [self.tableView.mj_header endRefreshing];
    }];
    
    [[self.viewModel.loadMoreCommand.executionSignals switchToLatest] subscribeNext:^(NSNumber *x) {
        [self.tableView reloadData];
        if (x.boolValue) {
            [self.tableView.mj_footer endRefreshing];
            [self loadData];
        } else {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            [self loadDataWithNoMore];
        }
    }];
    
    [self refreshCommentItems];
}


#pragma mark - Actions

- (void)refreshCommentItems
{
    [self.viewModel.refreshCommand execute:nil];
}

- (void)loadMoreCommentItems
{
    [self.viewModel.loadMoreCommand execute:nil];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 78;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//
//}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.commentItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MINGCommentCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MINGCommentCell" forIndexPath:indexPath];
    MINGCommentItem *commentItem = [self.viewModel.commentItems objectAtIndex:indexPath.row];
    [cell.authorAvatar sd_setImageWithURL:[NSURL URLWithString:commentItem.author.headUrl]];
    cell.authorNickNameLabel.text = commentItem.author.nickname;
    cell.commentLabel.text = commentItem.comment.content;
    cell.likeCountLabel.text = [NSString stringWithFormat:@"%@", @(commentItem.comment.likeCount)];
    cell.timeLabel.text = [MINGTools converTimeStampToString:commentItem.comment.time];;
    return cell;
}


#pragma mark - lazy load

- (UIView *)commentCountView
{
    if (!_commentCountView) {
        _commentCountView = [[UIView alloc] init];
        _commentCountView.backgroundColor = [UIColor colorWithHexString:@"F8F8F8"];
    }
    return _commentCountView;
}

- (UILabel *)commentCountLabel
{
    if (!_commentCountLabel) {
        _commentCountLabel = [[UILabel alloc] init];
        _commentCountLabel.font = [UIFont systemFontOfSize:14];
        _commentCountLabel.textColor = [UIColor colorWithHexString:@"404040"];
    }
    return _commentCountLabel;
}

- (UIView *)commentCountSepLine
{
    if (!_commentCountSepLine) {
        _commentCountSepLine = [[UIView alloc] init];
        _commentCountSepLine.backgroundColor = [UIColor colorWithHexString:@"808080"];
    }
    return _commentCountSepLine;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[MINGCommentCell class] forCellReuseIdentifier:@"MINGCommentCell"];
        
        // 刷新和 loaMore
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshCommentItems)];
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreCommentItems)];
    }
    return _tableView;
}

@end
