//
//  MINGPublishTweetsViewController.m
//  MyCircle
//
//  Created by 周汉明 on 2020/4/17.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGPublishTweetsViewController.h"
#import "UIColor+Hex.h"

#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>
#import <Toast/Toast.h>

@interface MINGPublishTweetsViewController ()
<
UITextViewDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate
>

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIView *sepLine;

@property (nonatomic, strong) UIImageView *imageOne;
@property (nonatomic, strong) UIImageView *imageTwo;
@property (nonatomic, strong) UIImageView *imageThree;

@property (nonatomic, strong) UIBarButtonItem *publishButton;


@property (nonatomic, strong) MINGPublishTweetsViewModel *viewModel;

@end

@implementation MINGPublishTweetsViewController

- (instancetype)initWithViewModel:(MINGPublishTweetsViewModel *)viewModel
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
    [[self.viewModel.uploadImageOneCommand.executionSignals switchToLatest] subscribeNext:^(NSString *x) {
        @strongify(self)
        [self.imageOne sd_setImageWithURL:[NSURL URLWithString:x]];
    }];
    
    [[self.viewModel.uploadImageTwoCommand.executionSignals switchToLatest] subscribeNext:^(NSString *x) {
        @strongify(self)
        [self.imageTwo sd_setImageWithURL:[NSURL URLWithString:x]];
    }];
    
    [[self.viewModel.uploadImageThreeCommand.executionSignals switchToLatest] subscribeNext:^(NSString *x) {
        @strongify(self)
        [self.imageThree sd_setImageWithURL:[NSURL URLWithString:x]];
    }];
    
    [[self.viewModel.publishCommand.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.view makeToast:@"发布完成" duration:1 position:CSToastPositionCenter];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    }];
    
}

- (void)configSubViews
{
    [self.view addSubview:self.textView];
    [self.view addSubview:self.sepLine];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.trailing.and.top.equalTo(self.view);
        make.height.equalTo(@200);
    }];
    [self.sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.trailing.equalTo(self.view);
        make.top.equalTo(self.textView.mas_bottom);
        make.height.equalTo(@1);
    }];
    
    [self.view addSubview:self.imageOne];
    [self.view addSubview:self.imageTwo];
    [self.view addSubview:self.imageThree];
    
    
    [self.imageOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sepLine.mas_bottom).offset(20);
        make.leading.equalTo(self.view).offset(15);
        make.width.and.height.equalTo(@112);
    }];
    
    [self.imageTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sepLine.mas_bottom).offset(20);
        make.leading.equalTo(self.imageOne.mas_trailing).offset(2);
//        make.centerX.equalTo(self.view);
        make.width.and.height.equalTo(@112);
    }];

    [self.imageThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sepLine.mas_bottom).offset(20);
        make.leading.equalTo(self.imageTwo.mas_trailing).offset(2);
        make.width.and.height.equalTo(@112);
    }];
}

#pragma mark Action

- (void)imageOneDidTapped:(id)sender
{
    self.viewModel.uploadIndex = 1;
    [self showImagePicker];
    
}

- (void)imageTwoDidTapper:(id)sender
{
    self.viewModel.uploadIndex = 2;
    [self showImagePicker];
}

- (void)imageThreeDidTapper:(id)sender
{
    self.viewModel.uploadIndex = 3;
    [self showImagePicker];
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
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        [self presentViewController:imagePicker animated:YES completion:nil];
        
    }]];
    
     [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)publishButtonClicked:(id)sender
{
    self.viewModel.content = self.textView.text;
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
    switch (self.viewModel.uploadIndex) {
        case 1:
            self.viewModel.imageOne = [info objectForKey:UIImagePickerControllerEditedImage];
            [self.viewModel.uploadImageOneCommand execute:nil];
            break;
            
        case 2:
            self.viewModel.imageTwo = [info objectForKey:UIImagePickerControllerEditedImage];
            [self.viewModel.uploadImageTwoCommand execute:nil];
            break;
        case 3:
            self.viewModel.imageThree = [info objectForKey:UIImagePickerControllerEditedImage];
            [self.viewModel.uploadImageThreeCommand execute:nil];
            break;
        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - lazy load

- (UITextView *)textView
{
    if (!_textView) {
        _textView = [UITextView new];
        _textView.font = [UIFont systemFontOfSize:20];
        _textView.backgroundColor = [UIColor colorWithHexString:@"F8F8F8"];
        _textView.delegate = self;
    }
    return _textView;
}

- (UIView *)sepLine
{
    if (!_sepLine) {
        _sepLine = [[UIView alloc] init];
        _sepLine.backgroundColor = [UIColor colorWithHexString:@"808080"];
    }
    return _sepLine;
}

- (UIImageView *)imageOne
{
    if (!_imageOne) {
        _imageOne = [UIImageView new];
        _imageOne.image = [UIImage imageNamed:@"plus"];
        _imageOne.layer.cornerRadius = 5;
        _imageOne.layer.masksToBounds = YES;
        _imageOne.userInteractionEnabled = YES;
        [_imageOne addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageOneDidTapped:)]];
    }
    return _imageOne;
}

- (UIImageView *)imageTwo
{
    if (!_imageTwo) {
        _imageTwo = [UIImageView new];
        _imageTwo.image = [UIImage imageNamed:@"plus"];
        _imageTwo.layer.cornerRadius = 5;
        _imageTwo.layer.masksToBounds = YES;
        _imageTwo.userInteractionEnabled = YES;
        [_imageTwo addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTwoDidTapper:)]];
    }
    return _imageTwo;
}

- (UIImageView *)imageThree
{
    if (!_imageThree) {
        _imageThree = [UIImageView new];
        _imageThree.image = [UIImage imageNamed:@"plus"];
        _imageThree.layer.cornerRadius = 5;
        _imageThree.layer.masksToBounds = YES;
        _imageThree.userInteractionEnabled = YES;
        [_imageThree addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageThreeDidTapper:)]];
    }
    return _imageThree;
}

- (UIBarButtonItem *)publishButton
{
    if (!_publishButton) {
        _publishButton = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStyleDone target:self action:@selector(publishButtonClicked:)];
    }
    return _publishButton;
}

@end
