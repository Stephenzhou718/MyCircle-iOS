//
//  MINGProfileViewController.m
//  MyCircle
//
//  Created by 周汉明 on 2020/3/21.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGProfileViewController.h"
#import "MINGProfileBaseCell.h"
#import "MINGProfileBaseCellWithArrow.h"
#import "MINGProfileSimpleCell.h"
#import "MINGUserListViewModel.h"
#import "MINGUserListViewController.h"
#import "UIColor+Hex.h"

#import <SDWebImage/SDWebImage.h>
#import <Masonry/Masonry.h>
#import <Toast/Toast.h>

@interface MINGProfileViewController ()
<
UIImagePickerControllerDelegate,
UINavigationControllerDelegate
>
 
@property (nonatomic, strong) UIImageView *avatarView;
@property (nonatomic, strong) UIButton *changeAvatarButton;
@property (nonatomic, strong) UILabel *nickNameLabel;

@property (nonatomic, strong) MINGProfileBaseCell *useranameCell;
@property (nonatomic, strong) MINGProfileBaseCellWithArrow *signatureCell;
@property (nonatomic, strong) MINGProfileBaseCellWithArrow *nickNameCell;
@property (nonatomic, strong) MINGProfileSimpleCell *followersCell;
@property (nonatomic, strong) MINGProfileSimpleCell *followingsCell;

@property (nonatomic, strong) MINGProfileViewModel *viewModel;

@end

@implementation MINGProfileViewController

- (instancetype)initWithViewModel:(MINGProfileViewModel *)viewModel
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
    self.view.backgroundColor = [UIColor colorWithHexString:@"F8F8F8"];
    
    @weakify(self)
    [[self.viewModel.getUserInfoCommand.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        MINGUser *user = self.viewModel.user;
        [self.avatarView sd_setImageWithURL:[NSURL URLWithString:user.headUrl]];
        self.nickNameLabel.text = user.nickname;
        self.useranameCell.content.text = user.username;
        self.nickNameCell.content.text = user.nickname;
        self.signatureCell.content.text = [user.signature isEqualToString:@""] ? @"未填写" : user.signature;
    }];
    
    [[self.viewModel.uploadAvatarCommand.executionSignals switchToLatest] subscribeNext:^(NSString *x) {
        [self.avatarView sd_setImageWithURL:[NSURL URLWithString:x]];
        [self.viewModel.updataAvatarUrlCommand execute:nil];
    }];
    
    [[self.viewModel.updataAvatarUrlCommand.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
        [self.view makeToast:@"更换成功"];
    }];
    
    [self.viewModel.getFollowersCommand execute:nil];
    [self.viewModel.getFollowingsCommand execute:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.viewModel.getUserInfoCommand execute:nil];
    [self.viewModel.getFollowersCommand execute:nil];
    [self.viewModel.getFollowingsCommand execute:nil];
}

- (void)configSubViews
{
    [self.view addSubview:self.avatarView];
    [self.view addSubview:self.useranameCell];
    [self.view addSubview:self.signatureCell];
    [self.view addSubview:self.nickNameCell];
    [self.view addSubview:self.followersCell];
    [self.view addSubview:self.followingsCell];
    
    [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.equalTo(self.view);
        make.height.equalTo(@400);
    }];
    
    [self.useranameCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.top.equalTo(self.avatarView.mas_bottom);
        make.height.equalTo(@80);
    }];
    
    [self.signatureCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.top.equalTo(self.useranameCell.mas_bottom);
        make.height.equalTo(@80);
    }];
    
    [self.nickNameCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.top.equalTo(self.signatureCell.mas_bottom);
        make.height.equalTo(@80);
    }];
    
    [self.followersCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.top.equalTo(self.nickNameCell.mas_bottom);
        make.height.equalTo(@80);
    }];
    
    [self.followingsCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.top.equalTo(self.followersCell.mas_bottom);
        make.height.equalTo(@80);
    }];
    
    [self.avatarView addSubview:self.changeAvatarButton];
    [self.avatarView addSubview:self.nickNameLabel];
    
    [self.changeAvatarButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatarView).offset(45);
        make.trailing.equalTo(self.avatarView).offset(-15);
        make.width.and.height.greaterThanOrEqualTo(@0);
    }];
    
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.avatarView).offset(20);
        make.bottom.equalTo(self.avatarView).offset(-40);
        make.width.and.height.greaterThanOrEqualTo(@0);
    }];
}

#pragma mark - Actions

- (void)changeAvatarButtonDidClicked:(id)sender
{
    [self showImagePicker];
}

- (void)signatureCellDidTapped:(id)sender
{
    
}

- (void)nickNameCellDidTapped:(id)sender
{
    
}

- (void)followerCellDidTapped:(id)sender
{
    MINGUserListViewModel *viewModel = [[MINGUserListViewModel alloc] initWithMINGUserItems:self.viewModel.followers];
    MINGUserListViewController *controller = [[MINGUserListViewController alloc] initWithViewModel:viewModel];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)followingCellDidtapped:(id)sender
{
    MINGUserListViewModel *viewModel = [[MINGUserListViewModel alloc] initWithMINGUserItems:self.viewModel.followings];
       MINGUserListViewController *controller = [[MINGUserListViewController alloc] initWithViewModel:viewModel];
       [self.navigationController pushViewController:controller animated:YES];
}


- (void)showImagePicker
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 拍照操作
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        [self presentViewController:imagePicker animated:YES completion:nil];
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"从相册上传" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 从手机相册选择图片的操作
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        [self presentViewController:imagePicker animated:YES completion:nil];
        
    }]];
    
     [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info
{
    self.viewModel.uploadImage = [info objectForKey:UIImagePickerControllerEditedImage];
    [self.viewModel.uploadAvatarCommand execute:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - lazy load

- (UIImageView *)avatarView
{
    if (!_avatarView) {
        _avatarView = [[UIImageView alloc] init];
        _avatarView.contentMode = UIViewContentModeScaleToFill;
        _avatarView.userInteractionEnabled = YES;
    }
    return _avatarView;
}

- (UIButton *)changeAvatarButton
{
    if (!_changeAvatarButton) {
        _changeAvatarButton = [[UIButton alloc] init];
        _changeAvatarButton.titleLabel.font = [UIFont systemFontOfSize:18];
        [_changeAvatarButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_changeAvatarButton setTitle:@"更换头像" forState:UIControlStateNormal];
        [_changeAvatarButton addTarget:self action:@selector(changeAvatarButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _changeAvatarButton;
}

- (UILabel *)nickNameLabel
{
    if (!_nickNameLabel) {
        _nickNameLabel = [UILabel new];
        _nickNameLabel.font = [UIFont systemFontOfSize:40 weight:UIFontWeightBold];
        _nickNameLabel.textColor = [UIColor whiteColor];
    }
    return _nickNameLabel;
}

- (MINGProfileBaseCell *)useranameCell
{
    if (!_useranameCell) {
        _useranameCell = [[MINGProfileBaseCell alloc] init];
        _useranameCell.title.text = @"账号";
    }
    return _useranameCell;
}

- (MINGProfileBaseCellWithArrow *)signatureCell
{
    if (!_signatureCell) {
        _signatureCell = [[MINGProfileBaseCellWithArrow alloc] init];
        _signatureCell.title.text = @"个性签名";
        _signatureCell.userInteractionEnabled = YES;
        [_signatureCell addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(signatureCellDidTapped:)]];
    }
    return _signatureCell;
}

- (MINGProfileBaseCellWithArrow *)nickNameCell
{
    if (!_nickNameCell) {
        _nickNameCell = [[MINGProfileBaseCellWithArrow alloc] init];
        _nickNameCell.title.text = @"昵称";
        _nickNameCell.userInteractionEnabled = YES;
        [_nickNameCell addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nickNameCellDidTapped:)]];
    }
    return _nickNameCell;
}

- (MINGProfileSimpleCell *)followersCell
{
    if (!_followersCell) {
        _followersCell = [[MINGProfileSimpleCell alloc] init];
        _followersCell.content.text = @"粉丝";
        _followingsCell.userInteractionEnabled = YES;
        [_followersCell addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(followerCellDidTapped:)]];
    }
    return _followersCell;
}

- (MINGProfileSimpleCell *)followingsCell
{
    if (!_followingsCell) {
        _followingsCell = [[MINGProfileSimpleCell alloc] init];
        _followingsCell.content.text = @"关注";
        [_followingsCell setSeplineHidden:YES];
        _followingsCell.userInteractionEnabled = YES;
        [_followingsCell addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(followingCellDidtapped:)]];
    }
    return _followingsCell;
}

@end
