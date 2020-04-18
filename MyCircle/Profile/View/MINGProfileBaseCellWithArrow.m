//
//  MINGProfileBaseCellWithArrow.m
//  MyCircle
//
//  Created by 周汉明 on 2020/4/18.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGProfileBaseCellWithArrow.h"
#import "UIColor+Hex.h"

#import <Masonry/Masonry.h>

@interface MINGProfileBaseCellWithArrow ()

@property (nonatomic, strong) UIImageView * arrowIcon;
@property (nonatomic, strong) UIView *sepLine;

@end

@implementation MINGProfileBaseCellWithArrow

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configSubViews];
    }
    return self;
}

- (void)configSubViews
{
    [self addSubview:self.title];
    [self addSubview:self.content];
    [self addSubview:self.sepLine];
    [self addSubview:self.arrowIcon];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(10);
        make.top.equalTo(self).offset(10);
        make.width.and.height.greaterThanOrEqualTo(@0);
    }];
    
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.title);
        make.bottom.equalTo(self).offset(-15);
        make.leading.and.trailing.greaterThanOrEqualTo(@0);
    }];
    
    [self.sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.title);
        make.trailing.equalTo(self);
        make.bottom.equalTo(self);
        make.height.equalTo(@5);
    }];
    
    [self.arrowIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.trailing.equalTo(self).offset(-10);
        make.width.and.height.equalTo(@15);
    }];
}

- (void)setSepLineHidden:(Boolean)hidded
{
    self.sepLine.hidden = hidded;
}

#pragma mark - lazy load

- (UILabel *)title
{
    if (!_title) {
        _title = [UILabel new];
        _title.font = [UIFont systemFontOfSize:16];
        _title.textColor = [UIColor colorWithHexString:@"808080"];
    }
    return _title;
}

- (UILabel *)content
{
    if (!_content) {
        _content = [UILabel new];
        _content.font = [UIFont systemFontOfSize:20];
        _content.textColor = [UIColor colorWithHexString:@"404040"];
    }
    return _content;
}

- (UIView *)sepLine
{
    if (!_sepLine) {
        _sepLine = [[UIView alloc] init];
        _sepLine.backgroundColor = [UIColor colorWithHexString:@"F8F8F8"];
    }
    return _sepLine;
}

- (UIImageView *)arrowIcon
{
    if (!_arrowIcon) {
        _arrowIcon = [[UIImageView alloc] init];
        _arrowIcon.image = [UIImage imageNamed:@"arrow"];
    }
    return _arrowIcon;
}

@end
