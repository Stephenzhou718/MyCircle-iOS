//
//  MINGProfileViewModel.h
//  MyCircle
//
//  Created by 周汉明 on 2020/4/18.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGUser.h"
#import "MINGUserItem.h"

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface MINGProfileViewModel : NSObject

@property (nonatomic, strong) MINGUser *user;
@property (nonatomic, strong) UIImage *uploadImage;
@property (nonatomic, copy) NSString *avatarUrl;

@property (nonatomic, strong) RACCommand *getUserInfoCommand;
@property (nonatomic, strong) RACCommand *uploadAvatarCommand;
@property (nonatomic, strong) RACCommand *updataAvatarUrlCommand;

// 关注 / 粉丝
@property (nonatomic, strong) NSArray<MINGUserItem *> *followers;
@property (nonatomic, strong) NSArray<MINGUserItem *> *followings;

@property (nonatomic, strong) RACCommand *getFollowersCommand;
@property (nonatomic, strong) RACCommand *getFollowingsCommand;

@end

NS_ASSUME_NONNULL_END
