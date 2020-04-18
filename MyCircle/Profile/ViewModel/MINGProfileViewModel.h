//
//  MINGProfileViewModel.h
//  MyCircle
//
//  Created by 周汉明 on 2020/4/18.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGUser.h"

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



@end

NS_ASSUME_NONNULL_END
