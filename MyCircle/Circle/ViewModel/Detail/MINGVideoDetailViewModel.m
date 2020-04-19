//
//  MINGVideoDetailViewModel.m
//  MyCircle
//
//  Created by 周汉明 on 2020/4/13.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGVideoDetailViewModel.h"

#import <AFNetworking/AFNetworking.h>

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
        self.followAuthor = videoItem.followAuthor;
        
        _playerModel = [[WMPlayerModel alloc] init];
        _playerModel.title = videoItem.video.title;
        _playerModel.videoURL = [NSURL URLWithString:videoItem.video.url];
//        _playerModel.videoURL = [NSURL URLWithString:@"http://q7w5eu31h.bkt.clouddn.com/37e9c0ab5bf44c74855c2d82e74f2c70.mp4"];
        
    }
    return self;
}



#pragma mark - lazy load

- (RACCommand<NSString *,id> *)commentCommand
{
    if (!_commentCommand) {
        _commentCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSString *input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                manager.requestSerializer = [AFHTTPRequestSerializer serializer];
                [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"cookie"] forHTTPHeaderField:@"ticket"];
                
                NSDictionary *params = @{
                    @"content" : input,
                    @"eventType" : @0,
                    @"eventId" : self.videoItem.video.videoId
                };
                
                NSString *url = @"http://127.0.0.1:8080/require_login/comment/add_comment";
                
                [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    if ([[responseObject objectForKey:@"code"] isEqualToNumber:@0]) {
                        [subscriber sendNext:@YES];
                        [subscriber sendCompleted];
                    } else {
                        [subscriber sendError:nil];
                    }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    [subscriber sendError:error];
                }];
                
                return nil;
            }];
        }];
    }
    return _commentCommand;
}

- (RACCommand<NSString *,id> *)followCommand
{
    if (!_followCommand) {
        _followCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSString * input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                manager.requestSerializer = [AFHTTPRequestSerializer serializer];
                [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"cookie"] forHTTPHeaderField:@"ticket"];
                
                NSDictionary *params = @{
                    @"followingId" : input
                };
                NSString *url = @"http://127.0.0.1:8080/require_login/follow";
                
                [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    if ([[responseObject objectForKey:@"code"] isEqualToNumber:@0]) {
                        [subscriber sendNext:@YES];
                        [subscriber sendCompleted];
                    } else {
                        [subscriber sendError:nil];
                    }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    [subscriber sendError:error];
                }];
                
                return nil;
            }];
        }];
    }
    return _followCommand;
}

- (RACCommand<NSString *,id> *)unFollowCommand
{
    if (!_unFollowCommand) {
        _unFollowCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSString * input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                manager.requestSerializer = [AFHTTPRequestSerializer serializer];
                [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"cookie"] forHTTPHeaderField:@"ticket"];
                
                NSDictionary *params = @{
                    @"followingId" : input
                };
                NSString *url = @"http://127.0.0.1:8080//require_login/un_follow";
               
                [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    if ([[responseObject objectForKey:@"code"] isEqualToNumber:@0]) {
                        [subscriber sendNext:@YES];
                        [subscriber sendCompleted];
                    } else {
                        [subscriber sendError:nil];
                    }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    [subscriber sendError:error];
                }];
                return nil;
            }];
        }];
    }
    return _unFollowCommand;
}

@end
