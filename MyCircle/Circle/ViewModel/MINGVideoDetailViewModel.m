//
//  MINGVideoDetailViewModel.m
//  MyCircle
//
//  Created by 周汉明 on 2020/4/13.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGVideoDetailViewModel.h"

@interface MINGVideoDetailViewModel()

@property (nonatomic, strong) MINGVideoItem *videoItem;


@end

@implementation MINGVideoDetailViewModel

- (instancetype)initWithVideoItem:(MINGVideoItem *)videoItem
{
    self = [super init];
    if (self) {
        self.video = videoItem.video;
        self.author = videoItem.author;
        self.videoItem = videoItem;
        
        _playerModel = [[WMPlayerModel alloc] init];
        _playerModel.title = videoItem.video.title;
        _playerModel.videoURL = [NSURL URLWithString:videoItem.video.url];
//        _playerModel.videoURL = [NSURL URLWithString:@"http://q7w5eu31h.bkt.clouddn.com/37e9c0ab5bf44c74855c2d82e74f2c70.mp4"];
        
    }
    return self;
}



#pragma mark - lazy load


@end
