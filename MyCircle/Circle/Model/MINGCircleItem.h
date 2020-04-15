//
//  MINGCircleItem.h
//  MyCircle
//
//  Created by 周汉明 on 2020/4/15.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGCircle.h"

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface MINGCircleItem : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) MINGCircle *circle;
@property (nonatomic, assign) Boolean hasJoined;

@end

NS_ASSUME_NONNULL_END
