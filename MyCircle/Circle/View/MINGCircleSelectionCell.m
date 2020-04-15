//
//  MINGCircleSelectionCell.m
//  MyCircle
//
//  Created by 周汉明 on 2020/4/15.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGCircleSelectionCell.h"
#import "UIColor+Hex.h"

#import <Masonry/Masonry.h>

@interface MINGCircleSelectionCell()

@end

@implementation MINGCircleSelectionCell

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
    [self addSubview:self.cover];
    [self addSubview:self.circleNameLabel];
    [self addSubview:self.descriptionLabel];
    
    [self.cover mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(12);
        make.centerY.equalTo(self);
        make.width.and.height.equalTo(@80);
    }];
    
    [self.circleNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.cover.mas_trailing).offset(12);
        make.top.equalTo(self.cover).offset(5);
        make.width.and.height.greaterThanOrEqualTo(@0);
    }];
    
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.cover.mas_trailing).offset(12);
        make.trailing.equalTo(self).offset(-40);
        make.bottom.equalTo(self.cover);
        make.top.greaterThanOrEqualTo(self.circleNameLabel);
    }];
}


#pragma mark - lazy load

- (UIImageView *)cover
{
    if (!_cover) {
        _cover = [[UIImageView alloc] init];
        _cover.layer.cornerRadius = 10;
        _cover.layer.masksToBounds = YES;
    }
    return _cover;
}

- (UILabel *)circleNameLabel
{
    if (!_circleNameLabel) {
        _circleNameLabel = [[UILabel alloc] init];
        _circleNameLabel.font = [UIFont systemFontOfSize:18];
        _circleNameLabel.textColor = [UIColor colorWithHexString:@"404040"];
    }
    return _circleNameLabel;
}

- (UILabel *)descriptionLabel
{
    if (!_descriptionLabel) {
        _descriptionLabel = [[UILabel alloc] init];
        _descriptionLabel.font = [UIFont systemFontOfSize:15];
        _descriptionLabel.textColor = [UIColor colorWithHexString: @"808080"];
        _descriptionLabel.numberOfLines = 0;
    }
    return _descriptionLabel;
}

@end
