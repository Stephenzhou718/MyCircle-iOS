//
//  MINGTweetsDetailViewModel.m
//  MyCircle
//
//  Created by 周汉明 on 2020/4/15.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGTweetsDetailViewModel.h"

#import <AFNetworking/AFNetworking.h>

@interface MINGTweetsDetailViewModel ()

@end

@implementation MINGTweetsDetailViewModel

- (instancetype)initWithTweetsItem:(MINGTweetsItem *)tweetsItem
{
    self = [super init];
    if (self) {
        self.author = tweetsItem.author;
        self.tweets = tweetsItem.tweets;
        self.followAuthor = tweetsItem.followAuthor;
        self.like = tweetsItem.like;
    }
    return self;
}

#pragma mark -lazy load

- (RACCommand *)likeCommand
{
    if (!_likeCommand) {
        _likeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
               AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
               manager.requestSerializer = [AFHTTPRequestSerializer serializer];
               [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"cookie"] forHTTPHeaderField:@"ticket"];
                NSDictionary *params = @{
                    @"EventType" : @1,
                    @"eventId" : self.tweets.tweetsId
                };
                
                NSString *url = @"http://127.0.0.1:8080/require_login/like";
                
                [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    if ([[responseObject objectForKey:@"code"] isEqualToNumber:@0]) {
                        [subscriber sendNext:[responseObject objectForKey:@"msg"]];
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
    return _likeCommand;
}

- (RACCommand *)disLikeCommand
{
    if (!_disLikeCommand) {
        _disLikeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
               AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
               manager.requestSerializer = [AFHTTPRequestSerializer serializer];
               [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"cookie"] forHTTPHeaderField:@"ticket"];
                
                NSString *url = @"http://127.0.0.1:8080/require_login/dislike";
                NSDictionary *params = @{
                    @"EventType" : @1,
                    @"eventId" : self.tweets.tweetsId
                };
                
                [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    if ([[responseObject objectForKey:@"code"] isEqualToNumber:@0]) {
                        [subscriber sendNext: [responseObject objectForKey:@"msg"]];
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
    return _disLikeCommand;
}


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
                    @"eventType" : @1,
                    @"eventId" : self.tweets.tweetsId
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
