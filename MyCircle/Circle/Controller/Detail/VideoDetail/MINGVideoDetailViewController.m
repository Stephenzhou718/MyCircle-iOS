//
//  MINGVideoDetailViewController.m
//  MyCircle
//
//  Created by 周汉明 on 2020/4/11.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGVideoDetailViewController.h"
#import "UIColor+Hex.h"
#import "MINGCommentViewModel.h"
#import "MINGCommentView.h"
#import "MINGTools.h"

#import <WMPlayer/WMPlayer.h>
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>

@interface MINGVideoDetailViewController ()<WMPlayerDelegate, UITextViewDelegate>

// 顶部的填充黑边
@property (nonatomic, strong) UIView *blackView;
@property (nonatomic, strong) WMPlayer *player;

// 视频相关简介
@property (nonatomic, strong) UIView *videoInfoView;
@property (nonatomic, strong) UILabel *videoTitleLabel;
@property (nonatomic, strong) UILabel *videoDescriptionLabel;


// 作者资料
@property (nonatomic, strong) UIView *authorInfoView;
@property (nonatomic, strong) UIImageView *authorAvatar;
@property (nonatomic, strong) UILabel *authorNickNameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIButton *followButton;

// 评论输入框
@property (nonatomic, strong) UIView *commentView;
@property (nonatomic, strong) UITextView *commentInputView;
@property (nonatomic, strong) UIButton *sendButton;


// 评论列表
@property (nonatomic, strong) MINGCommentViewModel *commentViewModel;
@property (nonatomic, strong) MINGCommentView *commentListView;

@property (nonatomic, strong) MINGVideoDetailViewModel *viewModel;

@end

@implementation MINGVideoDetailViewController


#pragma mark - life circle

- (instancetype)initWithViewModel:(MINGVideoDetailViewModel *)viewModel
{
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
        self.player.playerModel = viewModel.playerModel;
        self.commentViewModel = [[MINGCommentViewModel alloc] initWithContentType:MINGContentTypeVideo eventId:self.viewModel.video.videoId];
        [self loadData];
        [self configSubViews];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //获取设备旋转方向的通知,即使关闭了自动旋转,一样可以监测到设备的旋转方向
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    //旋转屏幕通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onDeviceOrientationChange)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil
     ];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.player play];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)configSubViews
{
    //
    [self.view addSubview:self.authorInfoView];
    [self.authorInfoView addSubview:self.authorAvatar];
    [self.authorInfoView addSubview:self.authorNickNameLabel];
    [self.authorInfoView addSubview:self.timeLabel];
    [self.authorInfoView addSubview:self.followButton];
    
    [self.view addSubview:self.videoInfoView];
    [self.videoInfoView addSubview:self.videoTitleLabel];
    [self.videoInfoView addSubview:self.videoDescriptionLabel];
    
    [self.view addSubview:self.commentView];
    [self.commentView addSubview:self.commentInputView];
    [self.commentView addSubview:self.sendButton];
    
    [self.view addSubview:self.commentListView];
    
    [self.view addSubview:self.blackView];
    [self.view addSubview:self.player];
    
    // 视频 view
    [self.blackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.equalTo(self.view);
        make.height.equalTo(@([WMPlayer IsiPhoneX]?34:0));
    }];
    
    [self.player mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.player.superview);
        make.top.equalTo(self.blackView.mas_bottom);
        make.height.mas_equalTo(self.player.mas_width).multipliedBy(9.0/16);
    }];
    
    // 用户信息 view
    [self.authorInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.top.equalTo(self.player.mas_bottom);
        make.height.equalTo(@40);
    }];
    
    [self.authorAvatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.authorInfoView).offset(8);
        make.top.equalTo(self.authorInfoView).offset(8);
        make.width.and.height.equalTo(@30);
    }];
    
    [self.authorNickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.authorAvatar.mas_trailing).offset(8);
        make.top.equalTo(self.authorInfoView).offset(6);
        make.width.and.height.greaterThanOrEqualTo(@0);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.authorNickNameLabel);
        make.top.equalTo(self.authorInfoView).offset(25);
        make.width.and.height.greaterThanOrEqualTo(@0);
    }];
    
    [self.followButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.authorAvatar);
        make.trailing.equalTo(self.authorInfoView).offset(-8);
        make.width.equalTo(@50);
        make.height.equalTo(@24);
    }];
    
    // 视频信息 view
    [self.videoInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.trailing.equalTo(self.view);
        make.top.equalTo(self.authorInfoView.mas_bottom);
        make.height.equalTo(@55);
    }];
    
    [self.videoTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.videoInfoView).offset(8);
        make.top.equalTo(self.videoInfoView).offset(8);
        make.width.and.height.greaterThanOrEqualTo(@0);
    }];
    
    [self.videoDescriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.videoTitleLabel);
        make.trailing.equalTo(self.videoInfoView).offset(-80);
        make.top.equalTo(self.videoTitleLabel.mas_bottom).offset(4);
        make.width.and.height.greaterThanOrEqualTo(@0);
    }];
    
    // 评论输入框
    [self.commentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.trailing.equalTo(self.view);
        make.top.equalTo(self.videoInfoView.mas_bottom);
        make.height.equalTo(@40);
    }];
    
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
    
    [self.commentListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self.view);
        make.top.equalTo(self.commentView.mas_bottom);
    }];
    
}

- (void)loadData
{
//    [self.authorAvatar sd_setImageWithURL:[NSURL URLWithString:@"https://static.veer.com/veer/static/resources/keyword/2020-02-19/533ed30de651499da1c463bca44b6d60.jpg"]];
//    self.authorNickNameLabel.text = @"飞翔的滑稽";
//    self.timeLabel.text = @"2020-7-18 11:30";
//
//
//    self.videoTitleLabel.text = @"英语六级听力听力听力呀";
//    self.videoDescriptionLabel.text = @"英语六级英语六级英语六级英语六级英语六级英语六级英语六级英语六级英语六级";
    
    [self.authorAvatar sd_setImageWithURL:[NSURL URLWithString:self.viewModel.author.headUrl]];
    self.authorNickNameLabel.text = self.viewModel.author.nickname;
    self.timeLabel.text = [MINGTools converTimeStampToString:self.viewModel.video.publishTime];
    self.videoTitleLabel.text = self.viewModel.video.title;
    self.videoDescriptionLabel.text = self.viewModel.video.content;
}

- (void)releaseWMPlayer{
    [self.player pause];
    [self.player removeFromSuperview];
    self.player = nil;
}
- (void)dealloc{
    [self releaseWMPlayer];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"DetailViewController dealloc");
}


#pragma mark super method

- (BOOL)prefersHomeIndicatorAutoHidden
{
    return self.player.isFullscreen;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(BOOL)prefersStatusBarHidden{
    return self.player.prefersStatusBarHidden;
}

- (BOOL)shouldAutorotate
{
    return !self.player.isLockScreen;
}

//viewController所支持的全部旋转方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    //对于present出来的控制器，要主动的（强制的）旋转VC，让wmPlayer全屏
//    UIInterfaceOrientationLandscapeLeft或UIInterfaceOrientationLandscapeRight
    [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationLandscapeRight) forKey:@"orientation"];
    return UIInterfaceOrientationLandscapeRight;
}

#pragma mark - private

- (void)onDeviceOrientationChange
{
    if (self.player.isLockScreen){
        return;
    }
//    if (self.forbidRotate) {
//        return ;
//    }
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)orientation;
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortraitUpsideDown:{
            NSLog(@"第3个旋转方向---电池栏在下");
        }
            break;
        case UIInterfaceOrientationPortrait:{
            NSLog(@"第0个旋转方向---电池栏在上");
            [self toOrientation:UIInterfaceOrientationPortrait];
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:{
            NSLog(@"第2个旋转方向---电池栏在左");
            [self toOrientation:UIInterfaceOrientationLandscapeLeft];
        }
            break;
        case UIInterfaceOrientationLandscapeRight:{
            NSLog(@"第1个旋转方向---电池栏在右");
            [self toOrientation:UIInterfaceOrientationLandscapeRight];
        }
            break;
        default:
            break;
    }
}


//点击进入,退出全屏,或者监测到屏幕旋转去调用的方法
-(void)toOrientation:(UIInterfaceOrientation)orientation{
    if (orientation ==UIInterfaceOrientationPortrait) {
        [self.player mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(self.player.superview);
            make.top.equalTo(self.blackView.mas_bottom);
        make.height.mas_equalTo(self.player.mas_width).multipliedBy(9.0/16);
        }];
        self.player.isFullscreen = NO;
    }else{
        [self.player mas_remakeConstraints:^(MASConstraintMaker *make) {
            if([WMPlayer IsiPhoneX]){
                make.edges.mas_equalTo(UIEdgeInsetsMake(self.player.playerModel.verticalVideo?14:0, 0, 0, 0));
            }else{
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
            }
        }];
        self.player.isFullscreen = YES;
    }
    if (@available(iOS 11.0, *)) {
        [self setNeedsUpdateOfHomeIndicatorAutoHidden];
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


#pragma mark - WMPlayerDelegate

///播放器事件
-(void)wmplayer:(WMPlayer *)wmplayer clickedCloseButton:(UIButton *)closeBtn{
    if (wmplayer.isFullscreen) {
        [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationPortrait) forKey:@"orientation"];
        //刷新
//        [UIViewController attemptRotationToDeviceOrientation];
    }else{
        if (self.presentingViewController) {
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

///播放暂停
-(void)wmplayer:(WMPlayer *)wmplayer clickedPlayOrPauseButton:(UIButton *)playOrPauseBtn{
    NSLog(@"clickedPlayOrPauseButton");
}

///全屏按钮
-(void)wmplayer:(WMPlayer *)wmplayer clickedFullScreenButton:(UIButton *)fullScreenBtn{
    if (self.player.isFullscreen) {//全屏
        //强制翻转屏幕，Home键在下边。
        [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationPortrait) forKey:@"orientation"];
    }else{//非全屏
        [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationLandscapeRight) forKey:@"orientation"];
    }
    //刷新
    [UIViewController attemptRotationToDeviceOrientation];
}

///单击播放器
-(void)wmplayer:(WMPlayer *)wmplayer singleTaped:(UITapGestureRecognizer *)singleTap{
    [self setNeedsStatusBarAppearanceUpdate];
}

///双击播放器
-(void)wmplayer:(WMPlayer *)wmplayer doubleTaped:(UITapGestureRecognizer *)doubleTap{
    NSLog(@"didDoubleTaped");
    if (wmplayer.isLockScreen) {
        return;
    }
    [wmplayer playOrPause:[wmplayer valueForKey:@"playOrPauseBtn"]];
}

///播放状态
-(void)wmplayerFailedPlay:(WMPlayer *)wmplayer WMPlayerStatus:(WMPlayerState)state{
    NSLog(@"wmplayerDidFailedPlay");
}

-(void)wmplayerReadyToPlay:(WMPlayer *)wmplayer WMPlayerStatus:(WMPlayerState)state{

}

-(void)wmplayerFinishedPlay:(WMPlayer *)wmplayer{
    NSLog(@"wmplayerDidFinishedPlay");
}

-(void)wmplayerGotVideoSize:(WMPlayer *)wmplayer videoSize:(CGSize )presentationSize{
    
}
//操作栏隐藏或者显示都会调用此方法
-(void)wmplayer:(WMPlayer *)wmplayer isHiddenTopAndBottomView:(BOOL)isHidden{
    [self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark - lazy load

- (UIView *)blackView
{
    if (!_blackView) {
        _blackView = [[UIView alloc] init];
        _blackView.backgroundColor = [UIColor blackColor];
    }
    return _blackView;
}

- (WMPlayer *)player
{
    if (!_player) {
        _player = [[WMPlayer alloc] initPlayerModel:_viewModel.playerModel];
        _player.backBtnStyle = BackBtnStylePop;     // 返回按钮样式
        _player.loopPlay = NO;
        _player.tintColor = [UIColor orangeColor];  // 更改播放器着色
        _player.enableBackgroundMode = NO;
        _player.enableVolumeGesture = YES;
        _player.enableFastForwardGesture = YES;
        _player.delegate = self;
        _player.playerModel = _viewModel.playerModel;
    }
    return _player;
}

- (UIView *)authorInfoView
{
    if (!_authorInfoView) {
        _authorInfoView = [[UIView alloc] init];
        _authorInfoView.backgroundColor = [UIColor whiteColor];
    }
    return _authorInfoView;
}

- (UIImageView *)authorAvatar
{
    if (!_authorAvatar) {
        _authorAvatar = [[UIImageView alloc] init];
        _authorAvatar.layer.cornerRadius = 15;
        _authorAvatar.layer.masksToBounds = YES;
    }
    return _authorAvatar;
}

- (UILabel *)authorNickNameLabel
{
    if (!_authorNickNameLabel) {
        _authorNickNameLabel = [[UILabel alloc] init];
        _authorNickNameLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightLight];
    }
    return _authorNickNameLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:10];
        _timeLabel.textColor = [UIColor colorWithHexString:@"808080"];
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
    }
    return _followButton;
}


- (UIView *)videoInfoView
{
    if (!_videoInfoView) {
        _videoInfoView = [[UIView alloc] init];
        _videoInfoView.backgroundColor = [UIColor whiteColor];
    }
    return _videoInfoView;
}

- (UILabel *)videoTitleLabel
{
    if (!_videoTitleLabel) {
        _videoTitleLabel = [[UILabel alloc] init];
        _videoTitleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _videoTitleLabel;
}

- (UILabel *)videoDescriptionLabel
{
    if (!_videoDescriptionLabel) {
        _videoDescriptionLabel = [[UILabel alloc] init];
        _videoDescriptionLabel.numberOfLines = 0;
        _videoDescriptionLabel.font = [UIFont systemFontOfSize:10];
        _videoDescriptionLabel.textColor = [UIColor colorWithHexString:@"808080"];
    }
    return _videoDescriptionLabel;
}

- (UIView *)commentView
{
    if (!_commentView) {
        _commentView = [[UIView alloc] init];
        _commentView.backgroundColor = [UIColor whiteColor];
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
