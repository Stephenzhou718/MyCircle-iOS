//
//  MINGVideoCellView.m
//  MyCircle
//
//  Created by 周汉明 on 2020/4/12.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGVideoCellView.h"
#import "UIColor+Hex.h"

#import <Masonry/Masonry.h>

@interface MINGVideoCellView()

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *sepView;
@property (nonatomic, strong) UIImageView *commentIcon;

@end

@implementation MINGVideoCellView

#pragma mark - life circle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configureSubViews];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureSubViews
{
    [self addSubview:self.backView];
    [self.backView addSubview:self.cover];
    [self.backView addSubview:self.title];
    [self.backView addSubview:self.authorHeaderView];
    [self.backView addSubview:self.authorNickName];
    [self.backView addSubview:self.likeCountLabel];
    [self.backView addSubview:self.commentCountLabel];
    [self.backView addSubview:self.likeIcon];
    [self.backView addSubview:self.commentIcon];
    [self addSubview:self.sepView];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self).offset(10);
        make.leading.equalTo(self).offset(10);
        make.trailing.equalTo(self).offset(-10);
    }];
    
    [self.cover mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.equalTo(self.backView);
        make.height.equalTo(@230);
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cover.mas_bottom).offset(10);
        make.leading.trailing.equalTo(self.backView);
        make.height.greaterThanOrEqualTo(@0);
    }];
    
    [self.authorHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_bottom).offset(5);
        make.leading.equalTo(self.backView);
        make.width.and.height.equalTo(@30);
    }];
    
    [self.authorNickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.authorHeaderView.mas_trailing).offset(6);
        make.centerY.equalTo(self.authorHeaderView);
        make.width.and.height.greaterThanOrEqualTo(@0);
    }];
    
    
    
    [self.likeCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.backView).offset(-20);
        make.centerY.equalTo(self.authorHeaderView);
        make.width.and.height.greaterThanOrEqualTo(@0);
    }];
    
    [self.likeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.likeCountLabel.mas_leading).offset(-5);
        make.centerY.equalTo(self.authorHeaderView);
        make.width.and.height.equalTo(@24);
    }];
    
    
    [self.commentCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.likeIcon.mas_leading).offset(-10);
        make.centerY.equalTo(self.authorHeaderView);
        make.width.and.height.greaterThanOrEqualTo(@0);
    }];

    [self.commentIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.commentCountLabel.mas_leading).offset(-5);
        make.centerY.equalTo(self.authorHeaderView);
        make.width.and.height.equalTo(@24);
    }];
    
    [self.sepView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.trailing.and.bottom.equalTo(self);
        make.height.equalTo(@8);
    }];
}


#pragma mark - lazy load

- (UIView *)backView
{
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.userInteractionEnabled = YES;
    }
    return _backView;
}

- (UIImageView *)cover
{
    if (!_cover) {
        _cover = [[UIImageView alloc] init];
        _cover.userInteractionEnabled = YES;
    }
    return _cover;
}

- (UILabel *)title
{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.font = [UIFont systemFontOfSize:18];
        _title.textColor = [UIColor darkTextColor];
        _title.userInteractionEnabled = YES;
    }
    return _title;
}

- (UIImageView *)authorHeaderView
{
    if (!_authorHeaderView) {
        _authorHeaderView = [[UIImageView alloc] init];
        _authorHeaderView.layer.cornerRadius = 15;
        _authorHeaderView.userInteractionEnabled = YES;
        _authorHeaderView.layer.masksToBounds = YES;
    }
    return _authorHeaderView;
}

- (UILabel *)authorNickName
{
    if (!_authorNickName) {
        _authorNickName = [[UILabel alloc] init];
        _authorNickName.font = [UIFont systemFontOfSize:14];
        _authorNickName.textColor = [UIColor colorWithHexString:@"808080"];
        _authorNickName.userInteractionEnabled = YES;
    }
    return _authorNickName;
}

- (UILabel *)likeCountLabel
{
    if (!_likeCountLabel) {
        _likeCountLabel = [[UILabel alloc] init];
        _likeCountLabel.font = [UIFont systemFontOfSize:10];
        _likeCountLabel.textColor = [UIColor colorWithHexString:@"808080"];
        _likeCountLabel.userInteractionEnabled = YES;
    }
    return _likeCountLabel;
}

- (UILabel *)commentCountLabel
{
    if (!_commentCountLabel) {
        _commentCountLabel = [[UILabel alloc] init];
        _commentCountLabel.font = [UIFont systemFontOfSize:10];
        _commentCountLabel.textColor = [UIColor colorWithHexString:@"808080"];
        _commentCountLabel.userInteractionEnabled = YES;
    }
    return _commentCountLabel;
}

- (UIImageView *)likeIcon
{
    if (!_likeIcon) {
        _likeIcon = [[UIImageView alloc] init];
        _likeIcon.image = [UIImage imageNamed:@"like"];
        _likeIcon.userInteractionEnabled = YES;
    }
    return _likeIcon;
}

- (UIImageView *)commentIcon
{
    if (!_commentIcon) {
        _commentIcon = [[UIImageView alloc] init];
        _commentIcon.image = [UIImage imageNamed:@"comment"];
        _commentIcon.userInteractionEnabled = YES;
    }
    return _commentIcon;
}

- (UIView *)sepView
{
    if (!_sepView) {
        _sepView = [UIView new];
        _sepView.backgroundColor = [UIColor colorWithHexString:@"F8F8F8"];
    }
    return _sepView;
}

@end
