//
//  MINGTweetsDetailViewController.m
//  MyCircle
//
//  Created by 周汉明 on 2020/4/11.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGTweetsDetailViewController.h"
#import "MINGCommentView.h"
#import "MINGCommentViewModel.h"
#import "UIColor+Hex.h"
#import "MINGTools.h"


#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>
#import <Toast/Toast.h>

@interface MINGTweetsDetailViewController () <UITextViewDelegate>

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *authorAvatar;
@property (nonatomic, strong) UILabel *authorNameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIButton *followButton;
@property (nonatomic, strong) UILabel *contentlabel;
@property (nonatomic, strong) UIImageView *imageOne;
@property (nonatomic, strong) UIImageView *imageTwo;
@property (nonatomic, strong) UIImageView *imageThree;

@property (nonatomic, strong) UIView *imagesPanel;

@property (nonatomic, strong) UIImageView *likeIcon;
@property (nonatomic, strong) UILabel *likeCountLabel;
@property (nonatomic, strong) UIImageView *commentIcon;
@property (nonatomic, strong) UILabel *commentCountLabel;

//评论输入框
@property (nonatomic, strong) UIView *commentView;
@property (nonatomic, strong) UITextView *commentInputView;
@property (nonatomic, strong) UIButton *sendButton;

// 评论列表
@property (nonatomic, strong) MINGCommentViewModel *commentViewModel;
@property (nonatomic, strong) MINGCommentView *commentListView;

@property (nonatomic, assign) NSInteger like;

@property (nonatomic, strong) MINGTweetsDetailViewModel *viewModel;

@end

@implementation MINGTweetsDetailViewController

- (instancetype)initWithViewModel:(MINGTweetsDetailViewModel *)viewModel
{
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
        self.commentViewModel = [[MINGCommentViewModel alloc] initWithContentType:MINGContentTypeTweets eventId:self.viewModel.tweets.tweetsId];
        self.like = viewModel.like;
        [self configSubViews];
        [self loadData];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.viewModel.followAuthor) {
        self.followButton.selected = YES;
        self.followButton.backgroundColor = [UIColor colorWithHexString:@"F0F0F0"];
    } else {
        self.followButton.selected = NO;
        self.followButton.backgroundColor = [UIColor orangeColor];
    }
    
    if (self.like == 1) {
        self.likeIcon.image = [UIImage imageNamed:@"like_active"];
    } else {
        self.likeIcon.image = [UIImage imageNamed:@"like"];
    }
    
    @weakify(self)
    [[self.viewModel.commentCommand.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.commentViewModel.refreshCommand execute:nil];
        
        [self.commentInputView resignFirstResponder];
        [self.view makeToast:@"评论成功" duration:1 position:CSToastPositionCenter];
        // 发布评论完成后，清空评论框
        UITextRange *textRange = [self.commentInputView textRangeFromPosition:self.commentInputView.beginningOfDocument toPosition:self.commentInputView.endOfDocument];
        [self.commentInputView replaceRange:textRange withText:@""];
    }];
    
    [[self.viewModel.followCommand.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.view makeToast:@"关注成功" duration:1 position:CSToastPositionCenter];
        self.followButton.backgroundColor = [UIColor colorWithHexString:@"F0F0F0"];
        self.followButton.selected = YES;
    }];
    
    [[self.viewModel.unFollowCommand.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.view makeToast:@"取消关注成功" duration:1 position:CSToastPositionCenter];
        self.followButton.backgroundColor = [UIColor orangeColor];
        self.followButton.selected = NO;
    }];
    
    
    [[self.viewModel.likeCommand.executionSignals switchToLatest] subscribeNext:^(NSNumber *x) {
        @strongify(self)
        self.likeIcon.image = [UIImage imageNamed:@"like_active"];
        self.like = 1;
        self.likeCountLabel.text = [NSString stringWithFormat:@"%@", x];
    }];
    
    [[self.viewModel.disLikeCommand.executionSignals switchToLatest] subscribeNext:^(NSNumber *x) {
        @strongify(self)
        self.like = 0;
        self.likeIcon.image = [UIImage imageNamed:@"like"];
        self.likeCountLabel.text = [NSString stringWithFormat:@"%@", x];
    }];
}

- (void)configSubViews
{
    [self.view addSubview:self.backView];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.bottom.equalTo(self.view);
    }];
    
    [self.backView addSubview:self.authorAvatar];
    [self.backView addSubview:self.authorNameLabel];
    [self.backView addSubview:self.timeLabel];
    [self.backView addSubview:self.followButton];
    [self.backView addSubview:self.contentlabel];
    [self.backView addSubview:self.imagesPanel];
    [self.backView addSubview:self.likeIcon];
    [self.backView addSubview:self.likeCountLabel];
    [self.backView addSubview:self.commentIcon];
    [self.backView addSubview:self.commentCountLabel];
    [self.backView addSubview:self.commentView];
    [self.backView addSubview:self.commentListView];
    
    [self.authorAvatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView).offset(10);
        make.top.equalTo(self.backView).offset(10);
        make.width.and.height.equalTo(@40);
    }];
    
    [self.authorNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.authorAvatar.mas_trailing).offset(6);
        make.top.equalTo(self.authorAvatar);
        make.width.and.height.greaterThanOrEqualTo(@0);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.authorNameLabel);
        make.bottom.equalTo(self.authorAvatar);
        make.height.and.width.greaterThanOrEqualTo(@0);
    }];
    
    [self.followButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.backView).offset(-10);
        make.centerY.equalTo(self.authorAvatar);
        make.width.equalTo(@50);
        make.height.equalTo(@24);
    }];
    
    [self.contentlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.authorNameLabel);
        make.trailing.equalTo(self.backView).offset(-20);
        make.top.equalTo(self.timeLabel.mas_bottom).offset(8);
        make.height.greaterThanOrEqualTo(@0);
    }];
    
    [self.imagesPanel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.authorNameLabel);
        make.trailing.equalTo(self.followButton);
        make.top.equalTo(self.contentlabel.mas_bottom).offset(8);
        make.height.equalTo(@111.5);
    }];
    
    [self.commentIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.authorNameLabel);
        make.top.equalTo(self.imagesPanel.mas_bottom).offset(18);
        make.width.and.height.equalTo(@24);
    }];
    
    [self.commentCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.commentIcon.mas_trailing).offset(4);
        make.centerY.equalTo(self.commentIcon);
        make.width.and.height.greaterThanOrEqualTo(@0);
    }];
    
    [self.likeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.commentCountLabel.mas_trailing).offset(40);
        make.centerY.equalTo(self.commentIcon);
        make.width.and.height.equalTo(@24);
    }];
    
    [self.likeCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.likeIcon.mas_trailing).offset(4);
        make.centerY.equalTo(self.commentIcon);
        make.width.and.height.greaterThanOrEqualTo(@0);
    }];
    
    [self.commentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.trailing.equalTo(self.backView);
        make.top.equalTo(self.commentIcon.mas_bottom);
        make.height.equalTo(@40);
    }];
    
    [self.commentListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self.backView);
        make.top.equalTo(self.commentView.mas_bottom).offset(8);
    }];
    
    [self.imagesPanel addSubview:self.imageOne];
    [self.imagesPanel addSubview:self.imageTwo];
    [self.imagesPanel addSubview:self.imageThree];
    
    [self.imageOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.imagesPanel);
        make.top.equalTo(self.imagesPanel);
        make.width.and.height.equalTo(@111.5);
    }];
    
    [self.imageTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.imageOne.mas_trailing).offset(2);
        make.top.equalTo(self.imagesPanel);
        make.width.and.height.equalTo(@111.5);
    }];
    
    [self.imageThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.imageTwo.mas_trailing).offset(2);
        make.top.equalTo(self.imagesPanel);
        make.width.and.height.equalTo(@111.5);
    }];
    
    [self.commentView addSubview:self.commentInputView];
    [self.commentView addSubview:self.sendButton];
    
    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.commentView).offset(-8);
        make.centerY.equalTo(self.commentView);
        make.width.equalTo(@50);
        make.height.equalTo(@25);
    }];
    
    [self.commentInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.commentView).offset(8);
        make.trailing.equalTo(self.sendButton.mas_leading).offset(-8);
        make.centerY.equalTo(self.commentView);
        make.height.equalTo(@30);
    }];
}

- (void)loadData
{
//    MINGTweetsItem *tweetsItem = self.viewModel.tweetsItem;
    [self.authorAvatar sd_setImageWithURL:[NSURL URLWithString:self.viewModel.author.headUrl]];
    self.authorNameLabel.text = self.viewModel.author.nickname;
    self.timeLabel.text = [MINGTools converTimeStampToString:self.viewModel.tweets.time];
    self.contentlabel.text = self.viewModel.tweets.content;
    self.likeCountLabel.text = [NSString stringWithFormat:@"%@",@(self.viewModel.tweets.likeCount)];
    self.commentCountLabel.text = [NSString stringWithFormat:@"%@",@(self.viewModel.tweets.commentCount)];
    
    NSArray<NSURL *> *urls = [MINGTools spiltStringToUrls:self.viewModel.tweets.imgs];
    if (urls.count >= 1) {
        [self.imageOne sd_setImageWithURL:urls[0]];
    }
    if (urls.count >= 2) {
        [self.imageTwo sd_setImageWithURL:urls[1]];
    }
    if (urls.count >= 3) {
        [self.imageThree sd_setImageWithURL:urls[2]];
    }
}

#pragma mark - Actions

- (void)sendButtonDidClicked:(id)sender
{
    if (self.commentInputView.text != nil && ![self.commentInputView.text isEqualToString:@""]) {
        [self.viewModel.commentCommand execute:self.commentInputView.text];
    } else {
        [self.view makeToast:@"不可以发空评论哦～" duration:1 position:CSToastPositionTop];
    }
}

- (void)followButtonDidClicked:(id)sender
{
    if (self.followButton.isSelected) {
        //  取消关注
        [self.viewModel.unFollowCommand execute:self.viewModel.author.username];
    } else {
        // 关注
        [self.viewModel.followCommand execute:self.viewModel.author.username];
    }
}

- (void)likeIconDidClicked:(id)sender
{
    if (self.like == 1) {
        // 取消点赞
        [self.viewModel.disLikeCommand execute:nil];
        self.likeIcon.image = [UIImage imageNamed:@"like"];
    } else {
        // 点赞
        [self.viewModel.likeCommand execute:nil];
        self.likeIcon.image = [UIImage imageNamed:@"like_active"];
    }
}


#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(nonnull NSString *)text
{
    if ([text isEqual:@"\n"]) {//判断按的是不是return
        [self.commentInputView resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark - lazy load

- (UIView *)backView
{
    if (!_backView) {
        _backView = [UIView new];
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}

- (UIImageView *)authorAvatar
{
    if (!_authorAvatar) {
        _authorAvatar = [UIImageView new];
        _authorAvatar.layer.cornerRadius = 19;
        _authorAvatar.layer.masksToBounds = YES;
    }
    return _authorAvatar;
}

- (UILabel *)authorNameLabel
{
    if (!_authorNameLabel) {
        _authorNameLabel = [UILabel new];
        _authorNameLabel.font = [UIFont systemFontOfSize:14];
        _authorNameLabel.textColor = [UIColor colorWithHexString:@"404040"];
    }
    return _authorNameLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.textColor = [UIColor colorWithHexString:@"404040"];
    }
    return _timeLabel;
}

- (UIButton *)followButton
{
    if (!_followButton) {
        _followButton = [[UIButton alloc] init];
        _followButton.layer.cornerRadius = 5;
        _followButton.layer.masksToBounds = YES;
        
        _followButton.backgroundColor = [UIColor orangeColor];
        _followButton.titleLabel.textColor = [UIColor whiteColor];
        _followButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_followButton setTitle:@"+关注" forState:UIControlStateNormal];
        [_followButton setTitle:@"已关注" forState:UIControlStateSelected];
        [_followButton addTarget:self action:@selector(followButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _followButton;
}

- (UILabel *)contentlabel
{
    if (!_contentlabel) {
        _contentlabel = [UILabel new];
        _contentlabel.numberOfLines = 2;
        _contentlabel.font = [UIFont systemFontOfSize:16];
        _contentlabel.textColor = [UIColor colorWithHexString:@"404040"];
        
    }
    return _contentlabel;
    
}

- (UIView *)imagesPanel
{
    if (!_imagesPanel) {
        _imagesPanel = [UIView new];
    }
    return _imagesPanel;
}

- (UIImageView *)imageOne
{
    if (!_imageOne) {
        _imageOne = [UIImageView new];
    }
    return _imageOne;
}

- (UIImageView *)imageTwo
{
    if (!_imageTwo) {
        _imageTwo = [UIImageView new];
    }
    return _imageTwo;
}

- (UIImageView *)imageThree
{
    if (!_imageThree) {
        _imageThree = [UIImageView new];
    }
    return _imageThree;
}


- (UIImageView *)likeIcon
{
    if (!_likeIcon) {
        _likeIcon = [UIImageView new];
        _likeIcon.userInteractionEnabled = YES;
        [_likeIcon addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(likeIconDidClicked:)]];
        _likeIcon.image = [UIImage imageNamed:@"like"];
    }
    return _likeIcon;
}

- (UILabel *)likeCountLabel
{
    if (!_likeCountLabel) {
        _likeCountLabel = [UILabel new];
        _likeCountLabel.font = [UIFont systemFontOfSize:14];
        _likeCountLabel.textColor = [UIColor colorWithHexString:@"808080"];
    }
    return _likeCountLabel;
}

- (UIImageView *)commentIcon
{
    if (!_commentIcon) {
        _commentIcon = [UIImageView new];
        _commentIcon.image = [UIImage imageNamed:@"comment"];
    }
    return _commentIcon;
}

- (UILabel *)commentCountLabel
{
    if (!_commentCountLabel) {
        _commentCountLabel = [UILabel new];
        _commentCountLabel.font  = [UIFont systemFontOfSize:14];
        _commentCountLabel.textColor = [UIColor colorWithHexString:@"808080"];
    }
    return _commentCountLabel;
}

- (UIView *)commentView
{
    if (!_commentView) {
        _commentView = [[UIView alloc] init];
        _commentView.backgroundColor = [UIColor whiteColor];
        _commentView.userInteractionEnabled = YES;
    }
    return _commentView;
}

- (UITextView *)commentInputView
{
    if (!_commentInputView) {
        _commentInputView = [[UITextView alloc] init];
        _commentInputView.backgroundColor = [UIColor colorWithHexString:@"F8F8F8"];
        _commentInputView.layer.cornerRadius = 5;
        _commentInputView.layer.masksToBounds = YES;
        _commentInputView.returnKeyType = UIReturnKeyDefault;
        _commentInputView.delegate = self;
        
    }
    return _commentInputView;
}

- (UIButton *)sendButton
{
    if (!_sendButton) {
        _sendButton = [[UIButton alloc] init];
        _sendButton.backgroundColor = [UIColor orangeColor];
        _sendButton.layer.cornerRadius = 5;
        _sendButton.layer.masksToBounds = YES;
        _sendButton.titleLabel.textColor = [UIColor whiteColor];
        _sendButton.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
        [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
        [_sendButton addTarget:self action:@selector(sendButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendButton;
}

- (MINGCommentView *)commentListView
{
    if (!_commentListView) {
        _commentListView = [[MINGCommentView alloc] initWithViewModel:self.commentViewModel];
    }
    return _commentListView;
}


@end
