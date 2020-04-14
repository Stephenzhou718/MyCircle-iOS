//
//  MINGVideoItem.h
//  MyCircle
//
//  Created by 周汉明 on 2020/4/12.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGVideo.h"
#import "MINGUser.h"

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>


NS_ASSUME_NONNULL_BEGIN

@interface MINGVideoItem : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) MINGVideo *video;
@property (nonatomic, strong) MINGUser *author;
@property (nonatomic, assign) NSInteger like;
@property (nonatomic, assign) Boolean hasMore;
@property (nonatomic, assign) Boolean followAuthor;

@end

NS_ASSUME_NONNULL_END
