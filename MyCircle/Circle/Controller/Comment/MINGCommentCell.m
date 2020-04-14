//
//  MINGCommentCell.m
//  MyCircle
//
//  Created by 周汉明 on 2020/4/14.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGCommentCell.h"
#import "UIColor+Hex.h"

#import <Masonry/Masonry.h>

@interface MINGCommentCell ()

@property (nonatomic, strong) UIView *sepLine;

@end

@implementation MINGCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self confiureSubviews];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)confiureSubviews
{
    [self.contentView addSubview:self.authorAvatar];
    [self.contentView addSubview:self.authorNickNameLabel];
    [self addSubview:self.commentLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.likeIcon];
    [self addSubview:self.likeCountLabel];
    [self addSubview:self.sepLine];
    
    [self.authorAvatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(10);
        make.top.equalTo(self).offset(10);
        make.width.and.height.equalTo(@38);
    }];
    
    [self.authorNickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.authorAvatar.mas_trailing).offset(10);
        make.top.equalTo(self.authorAvatar);
        make.width.and.height.greaterThanOrEqualTo(@0);
    }];
    
    [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.authorNickNameLabel);
        make.top.equalTo(self.authorNickNameLabel.mas_bottom).offset(5);
        make.width.and.height.greaterThanOrEqualTo(@0);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.authorNickNameLabel);
        make.bottom.equalTo(self.sepLine).offset(-5);
        make.width.and.height.greaterThanOrEqualTo(@0);
    }];
    
    [self.likeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.authorAvatar);
        make.trailing.equalTo(self).offset(-10);
        make.width.and.height.equalTo(@32);
    }];
    
    [self.likeCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.likeIcon);
        make.top.equalTo(self.likeIcon.mas_bottom).offset(3);
    }];
    
    [self.sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.authorNickNameLabel);
        make.trailing.and.bottom.equalTo(self);
        make.height.equalTo(@1);
    }];
}

#pragma mark - lazy load

- (UIImageView *)authorAvatar
{
    if (!_authorAvatar) {
        _authorAvatar = [[UIImageView alloc] init];
        _authorAvatar.layer.cornerRadius = 19;
        _authorAvatar.layer.masksToBounds = YES;
    }
    return _authorAvatar;
}

- (UILabel *)authorNickNameLabel
{
    if (!_authorNickNameLabel) {
        _authorNickNameLabel = [[UILabel alloc] init];
        _authorNickNameLabel.font = [UIFont systemFontOfSize:13];
        _authorNickNameLabel.textColor = [UIColor colorWithHexString:@"808080"];
    }
    return _authorNickNameLabel;
}

- (UILabel *)commentLabel
{
    if (!_commentLabel) {
        _commentLabel = [[UILabel alloc] init];
        _commentLabel.font = [UIFont systemFontOfSize:15];
    }
    return _commentLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.textColor = [UIColor colorWithHexString:@"D0D0D0"];
    }
    return _timeLabel;
}

- (UIImageView *)likeIcon
{
    if (!_likeIcon) {
        _likeIcon = [[UIImageView alloc] init];
        _likeIcon.image = [UIImage imageNamed:@"like"];
    }
    return _likeIcon;
}

- (UILabel *)likeCountLabel
{
    if (!_likeCountLabel) {
        _likeCountLabel = [[UILabel alloc] init];
        _likeCountLabel.font = [UIFont systemFontOfSize:12];
        _likeCountLabel.textColor = [UIColor colorWithHexString:@"999999"];
    }
    return _likeCountLabel;
}

- (UIView *)sepLine
{
    if (!_sepLine) {
        _sepLine = [[UIView alloc] init];
        _sepLine.backgroundColor = [UIColor colorWithHexString:@"808080"];
        _sepLine.alpha = 0.5;
    }
    return _sepLine;
}

@end
