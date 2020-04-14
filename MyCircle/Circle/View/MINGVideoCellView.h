//
//  MINGVideoCellView.h
//  MyCircle
//
//  Created by 周汉明 on 2020/4/12.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MINGVideoCellView : UITableViewCell

@property (nonatomic, strong) UIImageView *cover;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIImageView *authorHeaderView;
@property (nonatomic, strong) UILabel *authorNickName;


@property (nonatomic, strong) UIImageView *likeIcon;
@property (nonatomic, strong) UILabel *likeCountLabel;
@property (nonatomic, strong) UILabel *commentCountLabel;

@end

NS_ASSUME_NONNULL_END
