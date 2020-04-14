//
//  MINGCommentCell.h
//  MyCircle
//
//  Created by 周汉明 on 2020/4/14.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MINGCommentCell : UITableViewCell

@property (nonatomic, strong) UIImageView *authorAvatar;
@property (nonatomic, strong) UILabel *authorNickNameLabel;
@property (nonatomic, strong) UILabel *commentLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *likeIcon;
@property (nonatomic, strong) UILabel *likeCountLabel;

@end

NS_ASSUME_NONNULL_END
