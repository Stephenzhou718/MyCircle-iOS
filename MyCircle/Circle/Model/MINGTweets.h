//
//  MINGTweets.h
//  MyCircle
//
//  Created by 周汉明 on 2020/4/16.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface MINGTweets : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *tweetsId;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *imgs;
@property (nonatomic, copy) NSString *belongCircleId;
@property (nonatomic, copy) NSString *authorId;
@property (nonatomic, assign) NSInteger likeCount;
@property (nonatomic, assign) NSInteger commentCount;
@property (nonatomic, assign) long time;

@end

NS_ASSUME_NONNULL_END
