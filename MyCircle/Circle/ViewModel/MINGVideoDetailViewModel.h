//
//  MINGVideoDetailViewModel.h
//  MyCircle
//
//  Created by 周汉明 on 2020/4/13.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGVideoItem.h"
#import "MINGCommentItem.h"

#import <Foundation/Foundation.h>
#import <WMPlayer/WMPlayer.h>

NS_ASSUME_NONNULL_BEGIN

@interface MINGVideoDetailViewModel : NSObject

@property (nonatomic, strong) MINGVideo *video;
@property (nonatomic, strong) MINGUser *author;
@property (nonatomic, copy) NSMutableArray<MINGCommentItem *> *comments;

@property (nonatomic, strong) WMPlayerModel *playerModel;

- (instancetype)initWithVideoItem:(MINGVideoItem *)videoItem;

@end

NS_ASSUME_NONNULL_END
