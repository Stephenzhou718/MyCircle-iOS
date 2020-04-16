//
//  MINGTweetsTableViewCell.h
//  MyCircle
//
//  Created by 周汉明 on 2020/4/15.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MINGTweetsTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *authorAvatar;
@property (nonatomic, strong) UILabel *authorNameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIButton *folllowButton;
@property (nonatomic, strong) UILabel *contentlabel;
@property (nonatomic, strong) UIImageView *imageOne;
@property (nonatomic, strong) UIImageView *imageTwo;
@property (nonatomic, strong) UIImageView *imageThree;

@property (nonatomic, strong) UILabel *likeCountLabel;
@property (nonatomic, strong) UILabel *commentCountLabel;


@end

NS_ASSUME_NONNULL_END
