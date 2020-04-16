//
//  MINGTweetsItem.h
//  MyCircle
//
//  Created by 周汉明 on 2020/4/16.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGUser.h"
#import "MINGTweets.h"

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface MINGTweetsItem : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) MINGTweets *tweets;
@property (nonatomic, strong) MINGUser *author;
@property (nonatomic, assign) NSInteger like;
@property (nonatomic, assign) Boolean hasMore;
@property (nonatomic, assign) Boolean followAuthor;

@end

NS_ASSUME_NONNULL_END
