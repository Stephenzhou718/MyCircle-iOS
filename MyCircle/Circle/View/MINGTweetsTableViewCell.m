//
//  MINGTweetsTableViewCell.m
//  MyCircle
//
//  Created by 周汉明 on 2020/4/15.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGTweetsTableViewCell.h"
#import "UIColor+Hex.h"

#import <Masonry/Masonry.h>

@interface MINGTweetsTableViewCell ()

@property (nonatomic, strong) UIView *imagesPanel;
@property (nonatomic, strong) UIImageView *likeIcon;
@property (nonatomic, strong) UIImageView *commentIcon;
@property (nonatomic, strong) UIView *sepView;

@end

@implementation MINGTweetsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configSubViews];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)configSubViews
{
    [self addSubview:self.authorAvatar];
    [self addSubview:self.authorNameLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.folllowButton];
    [self addSubview:self.contentlabel];
    [self addSubview:self.imagesPanel];
    [self addSubview:self.likeIcon];
    [self addSubview:self.likeCountLabel];
    [self addSubview:self.commentIcon];
    [self addSubview:self.commentCountLabel];
    [self addSubview:self.sepView];
    
    [self.authorAvatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(10);
        make.top.equalTo(self).offset(10);
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
    
    [self.folllowButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self).offset(-10);
        make.centerY.equalTo(self.authorAvatar);
        make.width.equalTo(@64);
        make.height.equalTo(@24);
    }];
    
    [self.contentlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.authorNameLabel);
        make.trailing.equalTo(self).offset(-20);
        make.top.equalTo(self.timeLabel.mas_bottom).offset(8);
        make.height.greaterThanOrEqualTo(@0);
    }];
    
    [self.imagesPanel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.authorNameLabel);
        make.trailing.equalTo(self.folllowButton);
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
    
    [self.sepView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self);
        make.height.equalTo(@8);
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
}

#pragma mark - lazy load

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

- (UIButton *)folllowButton
{
    if (!_folllowButton) {
        _folllowButton = [UIButton new];
        _folllowButton.layer.cornerRadius = 12;
        _folllowButton.layer.masksToBounds = YES;
        [_folllowButton setTitle:@"+关注" forState:UIControlStateNormal];
    }
    return _folllowButton;
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

- (UIView *)sepView
{
    if (!_sepView) {
        _sepView = [UIView new];
        _sepView.backgroundColor = [UIColor colorWithHexString:@"F8F8F8"];    }
    return _sepView;
}

@end
