//
//  MINGUserTableViewCell.h
//  MyCircle
//
//  Created by 周汉明 on 2020/4/16.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MINGUserTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *userAvatar;
@property (nonatomic, strong) UILabel *nicknameLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UIButton *followButton;

@end

NS_ASSUME_NONNULL_END
