//
//  MINGPublishVideoViewController.m
//  MyCircle
//
//  Created by 周汉明 on 2020/4/17.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGPublishVideoViewController.h"
#import "UIColor+Hex.h"

#import <ASProgressPopUpView/ASProgressPopUpView.h>
#import <SDWebImage/SDWebImage.h>
#import <Toast/Toast.h>
#import <Masonry/Masonry.h>
#import <UITextView+ZWPlaceHolder.h>

@interface MINGPublishVideoViewController ()
<
UITextViewDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate
>

@property (nonatomic, strong) UITextField *titleInputField;
@property (nonatomic, strong) UIView* sepLineOne;
@property (nonatomic, strong) UITextView *contentInputView;
@property (nonatomic, strong) UIView *sepLineTwo;
@property (nonatomic, strong) UIImageView *videoCoverView;
@property (nonatomic, strong) UIImageView *videoIcon;

@property (nonatomic, strong) UIBarButtonItem *publishButton;

@property (nonatomic, strong)
MINGPublishVideoViewModel *viewModel;

@end

@implementation MINGPublishVideoViewController

- (instancetype)initWithViewModel:(MINGPublishVideoViewModel *)viewModel
{
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
        [self configSubViews];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = self.publishButton;
    @weakify(self)
    [[self.viewModel.uploadVideoCommand.executionSignals switchToLatest] subscribeNext:^(NSString *x) {
        @strongify(self)
        [self.videoCoverView sd_setImageWithURL:[NSURL URLWithString:x]];
        self.videoIcon.hidden = NO;
        [self.view hideToastActivity];
    }];
    
    [[self.viewModel.publishCommand.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
       [self.view makeToast:@"发布成功" duration:1 position:CSToastPositionCenter];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    }];
}

- (void)configSubViews
{
    [self.view addSubview:self.titleInputField];
    [self.view addSubview:self.contentInputView];
    [self.view addSubview:self.videoCoverView];
    
    [self.videoCoverView addSubview:self.videoIcon];
    
    [self.titleInputField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).offset(10);
        make.trailing.equalTo(self.view).offset(-100);
        make.top.equalTo(self.view).offset(20);
        make.height.equalTo(@30);
    }];
    
    [self.contentInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).offset(10);
        make.trailing.equalTo(self.view).offset(-10);
        make.top.equalTo(self.titleInputField.mas_bottom).offset(10);
        make.height.equalTo(@150);
    }];
    
    [self.videoCoverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentInputView.mas_bottom).offset(20);
        make.leading.equalTo(self.view).offset(15);
        make.width.and.height.equalTo(@112);
    }];
    
    [self.videoIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.videoCoverView);
        make.width.and.height.equalTo(@35);
    }];
}

#pragma mark - Avtions

- (void)videoCoverDidClicked:(id)sender
{
    [self showImagePicker];
}

- (void)showImagePicker
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 拍照操作
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.mediaTypes = [NSArray arrayWithObjects:@"public.movie", nil];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        [self presentViewController:imagePicker animated:YES completion:nil];
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"从相册上传" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 从手机相册选择图片的操作
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        imagePicker.mediaTypes = [NSArray arrayWithObjects:@"public.movie", nil];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        [self presentViewController:imagePicker animated:YES completion:nil];
        
    }]];
    
     [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)publishButtonClicked:(id)sender
{
    self.viewModel.title = self.titleInputField.text;
    self.viewModel.content = self.contentInputView.text;
    [self.viewModel.publishCommand execute:nil];
}


#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{

    if([text isEqualToString:@"\n"]){

        [textView resignFirstResponder];

        return NO;

    }

    return YES;
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info
{
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
        
    if ([mediaType isEqualToString:@"public.movie"]){
        //如果是视频
        NSURL *url = info[UIImagePickerControllerMediaURL];//获得视频的URL
        NSLog(@"url %@",url);
        self.viewModel.fileUrl = url;
        [self.viewModel.uploadVideoCommand execute:nil];
        
        [self.titleInputField resignFirstResponder];
        [self.contentInputView resignFirstResponder];
//        [self.progressPopupView showPopUpViewAnimated:YES];
        [self.view makeToastActivity:CSToastPositionCenter];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - lazy load

- (UITextField *)titleInputField
{
    if (!_titleInputField) {
        _titleInputField = [[UITextField alloc] init];
        _titleInputField.borderStyle = UITextBorderStyleRoundedRect;
        _titleInputField.placeholder = @"在此处填写标题哦～";
    }
    return _titleInputField;
}

- (UIView *)sepLineOne
{
    if (!_sepLineOne) {
        _sepLineOne = [[UIView alloc] init];
        _sepLineOne.backgroundColor = [UIColor colorWithHexString:@"808080"];
    }
    return _sepLineOne;
}

- (UITextView *)contentInputView
{
    if (!_contentInputView) {
        _contentInputView = [UITextView new];
        _contentInputView.zw_placeHolder = @"在这里填写视频简介哦～～～";
        _contentInputView.layer.cornerRadius = 10;
        _contentInputView.layer.masksToBounds = YES;
        _contentInputView.layer.borderWidth = 1;
        _contentInputView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _contentInputView.font = [UIFont systemFontOfSize:20];
        _contentInputView.backgroundColor = [UIColor colorWithHexString:@"F8F8F8"];
        _contentInputView.delegate = self;
    }
    return _contentInputView;
}

- (UIView *)sepLineTwo
{
    if (!_sepLineTwo) {
        _sepLineTwo = [UIView new];
        _sepLineTwo.backgroundColor = [UIColor colorWithHexString:@"808080"];
    }
    return _sepLineTwo;
}

- (UIImageView *)videoCoverView
{
    if (!_videoCoverView) {
        _videoCoverView = [[UIImageView alloc] init];
        _videoCoverView.image = [UIImage imageNamed:@"plus"];
        _videoCoverView.userInteractionEnabled = YES;
        [_videoCoverView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(videoCoverDidClicked:)]];
    }
    return _videoCoverView;
}

- (UIImageView *)videoIcon
{
    if (!_videoIcon) {
        _videoIcon = [[UIImageView alloc] init];
        _videoIcon.image = [UIImage imageNamed:@"video_icon"];
        _videoIcon.alpha = 0.7;
        _videoIcon.userInteractionEnabled = YES;
        _videoIcon.hidden = YES;
        
    }
    return _videoIcon;
}

- (UIBarButtonItem *)publishButton
{
    if (!_publishButton) {
        _publishButton = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStyleDone target:self action:@selector(publishButtonClicked:)];
    }
    return _publishButton;
}



@end
