//
//  MINGComment.h
//  MyCircle
//
//  Created by 周汉明 on 2020/4/14.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface MINGComment : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *commentId;
@property (nonatomic, assign) NSInteger evnetType;
@property (nonatomic, copy) NSString *eventId;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) NSInteger likeCount;
@property (nonatomic, assign) long time;

@end

NS_ASSUME_NONNULL_END
