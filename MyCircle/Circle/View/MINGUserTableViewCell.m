//
//  MINGUserTableViewCell.m
//  MyCircle
//
//  Created by 周汉明 on 2020/4/16.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGUserTableViewCell.h"
#import "UIColor+Hex.h"

#import <Masonry/Masonry.h>

@interface MINGUserTableViewCell ()

@property (nonatomic, strong) UIView *sepLine;

@end

@implementation MINGUserTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configSubviews];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)configSubviews
{
    [self addSubview:self.userAvatar];
    [self addSubview:self.nicknameLabel];
    [self addSubview:self.descriptionLabel];
    [self addSubview:self.followButton];
    [self addSubview:self.sepLine];
    
    [self.userAvatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(12);
        make.centerY.equalTo(self);
        make.width.and.height.equalTo(@48);
    }];
    
    [self.nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.userAvatar.mas_trailing).offset(12);
        make.top.equalTo(self.userAvatar).offset(2);
        make.height.and.width.greaterThanOrEqualTo(@0);
    }];
    
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.nicknameLabel);
        make.trailing.lessThanOrEqualTo(self.followButton.mas_leading).offset(12);
        make.bottom.equalTo(self.userAvatar).offset(-2);
        make.height.greaterThanOrEqualTo(@0);
    }];
    
    [self.followButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self).offset(-12);
        make.centerY.equalTo(self.userAvatar);
        make.width.equalTo(@67);
        make.height.equalTo(@28);
    }];
    
    [self.sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.bottom.equalTo(self);
        make.leading.equalTo(self.userAvatar.mas_trailing);
        make.height.equalTo(@1);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - lazy load

- (UIImageView *)userAvatar
{
    if (!_userAvatar) {
        _userAvatar = [UIImageView new];
        _userAvatar.layer.cornerRadius = 24;
        _userAvatar.layer.masksToBounds = YES;
    }
    return _userAvatar;
}

- (UILabel *)nicknameLabel
{
    if (!_nicknameLabel) {
        _nicknameLabel = [UILabel new];
        _nicknameLabel.font = [UIFont systemFontOfSize:14];
        _nicknameLabel.textColor = [UIColor colorWithHexString:@"404040"];
    }
    return _nicknameLabel;
}

- (UILabel *)descriptionLabel
{
    if (!_descriptionLabel) {
        _descriptionLabel = [[UILabel alloc] init];
        _descriptionLabel.font = [UIFont systemFontOfSize:14];
        _descriptionLabel.textColor = [UIColor colorWithHexString:@"707070"];
    }
    return _descriptionLabel;
}

- (UIButton *)followButton
{
    if (!_followButton) {
        _followButton = [UIButton new];
        [_followButton setTitle:@"关注" forState:UIControlStateNormal];
    }
    return _followButton;
}

- (UIView *)sepLine
{
    if (!_sepLine) {
        _sepLine = [UIView new];
        _sepLine.backgroundColor = [UIColor colorWithHexString:@"F0F0F0"];
    }
    return _sepLine;
}

@end
