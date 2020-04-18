//
//  MINGProfileSimpleCell.m
//  MyCircle
//
//  Created by 周汉明 on 2020/4/18.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGProfileSimpleCell.h"
#import "UIColor+Hex.h"

#import <Masonry/Masonry.h>

@interface MINGProfileSimpleCell ()

@property (nonatomic, strong) UIView *sepLine;
@property (nonatomic, strong) UIImageView *arrowIcon;

@end

@implementation MINGProfileSimpleCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self confifSubViews];
    }
    return self;
}

- (void)confifSubViews
{
    [self addSubview:self.content];
    [self addSubview:self.arrowIcon];
    [self addSubview:self.sepLine];
    
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(10);
        make.centerY.equalTo(self);
        make.width.and.height.greaterThanOrEqualTo(@0);
    }];
    
    [self.arrowIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.trailing.equalTo(self).offset(-10);
        make.width.and.height.equalTo(@15);
    }];
    
    [self.sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.content);
        make.trailing.equalTo(self);
        make.bottom.equalTo(self);
        make.height.equalTo(@5);
    }];
    
}

- (void)setSeplineHidden:(Boolean)hidden
{
    self.sepLine.hidden = hidden;
}

#pragma mark - lazy load

- (UILabel *)content
{
    if (!_content) {
        _content = [UILabel new];
        _content.font = [UIFont systemFontOfSize:20];
        _content.textColor = [UIColor colorWithHexString:@"808080"];
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
