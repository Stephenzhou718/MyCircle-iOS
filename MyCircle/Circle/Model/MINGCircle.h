//
//  MINGCircle.h
//  MyCircle
//
//  Created by 周汉明 on 2020/4/15.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface MINGCircle : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *circleId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *circleDescription;
@property (nonatomic, copy) NSString *imgUrl;
@property (nonatomic, copy) NSString *belongUsername;

@end

NS_ASSUME_NONNULL_END
