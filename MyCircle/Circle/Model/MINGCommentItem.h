//
//  MINGCommentItem.h
//  MyCircle
//
//  Created by 周汉明 on 2020/4/13.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGComment.h"
#import "MINGUser.h"

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface MINGCommentItem : MTLModel<MTLJSONSerializing>

@property (nonatomic, assign) Boolean hasMore;
@property (nonatomic, assign) NSInteger like;
@property (nonatomic, strong) MINGUser *author;
@property (nonatomic, strong) MINGComment *comment;

@end

NS_ASSUME_NONNULL_END
