//
//  MINGUserItem.h
//  MyCircle
//
//  Created by 周汉明 on 2020/4/16.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGUser.h"

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface MINGUserItem : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) MINGUser *user;
@property (nonatomic, assign) Boolean follow;

@end

NS_ASSUME_NONNULL_END
