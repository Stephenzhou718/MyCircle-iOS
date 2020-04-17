//
//  MINGLoginViewModel.h
//  MyCircle
//
//  Created by 周汉明 on 2020/4/16.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGUser.h"

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface MINGLoginViewModel : NSObject

@property (nonatomic, strong) RACCommand *loginCommand;
@property (nonatomic, strong) RACCommand *registerCommand;
@property (nonatomic, strong) RACCommand *updateUserInfoCommand;

- (void)setUserInfoWithUser:(MINGUser *)user;
- (void)setPass:(NSString *)password;

@end

NS_ASSUME_NONNULL_END
