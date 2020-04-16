//
//  MINGUser.h
//  MyCircle
//
//  Created by 周汉明 on 2020/4/12.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface MINGUser : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *headUrl;
@property (nonatomic, copy) NSString *signature;

@end

NS_ASSUME_NONNULL_END
