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
#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface MINGVideoDetailViewModel : NSObject

@property (nonatomic, strong) MINGVideo *video;
@property (nonatomic, strong) MINGUser *author;
@property (nonatomic, assign) Boolean followAuthor;
@property (nonatomic, copy) NSMutableArray<MINGCommentItem *> *comments;

@property (nonatomic, strong) WMPlayerModel *playerModel;

@property (nonatomic, strong) RACCommand<NSString *, id> *commentCommand;
@property (nonatomic, strong) RACCommand<NSString *, id> *followCommand;
@property (nonatomic, strong) RACCommand<NSString *, id> *unFollowCommand;

- (instancetype)initWithVideoItem:(MINGVideoItem *)videoItem;

@end

NS_ASSUME_NONNULL_END
