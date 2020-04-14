//
//  MINGVideo.h
//  MyCircle
//
//  Created by 周汉明 on 2020/4/11.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface MINGVideo : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *videoId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *uploadUsername;
@property (nonatomic, copy) NSString *belongCircleId;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *coverUrl;
@property (nonatomic, assign) NSInteger likeCount;
@property (nonatomic, assign) NSInteger commentCount;
@property (nonatomic, assign) NSInteger publishTime;

@end

NS_ASSUME_NONNULL_END
