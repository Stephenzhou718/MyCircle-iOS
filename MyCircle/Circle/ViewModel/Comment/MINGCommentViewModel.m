//
//  MINGCommentViewModel.m
//  MyCircle
//
//  Created by 周汉明 on 2020/4/14.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGCommentViewModel.h"

#import <AFNetworking/AFNetworking.h>

@interface MINGCommentViewModel ()

@property (nonatomic, assign) NSInteger offset;
@property (nonatomic, assign) NSInteger limit;

@property (nonatomic, assign) NSInteger eventType;
@property (nonatomic, copy) NSString *eventId;

@end

@implementation MINGCommentViewModel

- (instancetype)initWithContentType:(MINGContentType)type eventId:(NSString *)eventId
{
    self = [super init];
    if (self) {
        self.eventType = type;
        self.eventId = eventId;
        self.offset = 0;
        self.limit = 6;
    }
    return self;
}

#pragma mark - lazy load

- (RACCommand *)refreshCommand
{
    if (!_refreshCommand) {
        _refreshCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                
                // 参数字典
                NSDictionary *params = @{
                    @"eventType" : @(self.eventType),
                    @"eventId" : self.eventId,
                    @"offset" : @0,
                    @"limit" : @(self.limit)
                };
                
                // 请求
                NSString *url = @"http://127.0.0.1:8080/comment/get_comments";
                url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"#%^{}\"[]|\\<> "].invertedSet];
                [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
                    // 请求进度
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    if ([[responseObject objectForKey:@"code"] isEqualToNumber:@0]) {
                        NSArray<MINGCommentItem *> *commentItemsFromNet = [MTLJSONAdapter modelsOfClass:[MINGCommentItem class] fromJSONArray:[responseObject objectForKey:@"data"] error:nil];
                        self.commentItems = [NSMutableArray arrayWithArray:commentItemsFromNet];
                        self.offset = commentItemsFromNet.count;
                        Boolean hasMore = [commentItemsFromNet lastObject].hasMore;
                        [subscriber sendNext:[NSNumber numberWithBool:hasMore]];
                        [subscriber sendCompleted];
                    } else {
                        NSDictionary *userInfo = @{NSLocalizedDescriptionKey:@"网络请求错误"};
                        [subscriber sendError:[NSError errorWithDomain:NSCocoaErrorDomain code:0 userInfo:userInfo]];
                        
                    }
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    NSDictionary *userInfo = @{NSLocalizedDescriptionKey:@"网络请求错误"};
                    [subscriber sendError:[NSError errorWithDomain:NSCocoaErrorDomain code:0 userInfo:userInfo]];
                }];
                
                return nil;
            }];
        }];
    }
    return _refreshCommand;
}

- (RACCommand *)loadMoreCommand
{
    if (!_loadMoreCommand) {
        _loadMoreCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                
                // 参数字典
                NSDictionary *params = @{
                    @"eventType" : @(self.eventType),
                    @"eventId" : self.eventId,
                    @"offset" : @(self.offset),
                    @"limit" : @(self.limit)
                };
                
                // 请求
                NSString *url = @"http://127.0.0.1:8080/comment/get_comments";
                url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"#%^{}\"[]|\\<> "].invertedSet];
                [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
                    // 请求进度
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    if ([[responseObject objectForKey:@"code"] isEqualToNumber:@0]) {
                        NSArray<MINGCommentItem *> *commentItemsFromNet = [MTLJSONAdapter modelsOfClass:[MINGCommentItem class] fromJSONArray:[responseObject objectForKey:@"data"] error:nil];
                        [self.commentItems addObjectsFromArray:commentItemsFromNet];
                        self.offset += commentItemsFromNet.count;
                        Boolean hasMore = [commentItemsFromNet lastObject].hasMore;
                        [subscriber sendNext:[NSNumber numberWithBool:hasMore]];
                        [subscriber sendCompleted];
                    } else {
                        NSDictionary *userInfo = @{NSLocalizedDescriptionKey:@"网络请求错误"};
                        [subscriber sendError:[NSError errorWithDomain:NSCocoaErrorDomain code:0 userInfo:userInfo]];
                        
                    }
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    NSDictionary *userInfo = @{NSLocalizedDescriptionKey:@"网络请求错误"};
                    [subscriber sendError:[NSError errorWithDomain:NSCocoaErrorDomain code:0 userInfo:userInfo]];
                }];
                
                
                return nil;
            }];
        }];
    }
    return _loadMoreCommand;
}

- (RACCommand<NSString *,id> *)likeCommand
{
    if (!_likeCommand) {
        _likeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSString * input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                manager.requestSerializer = [AFHTTPRequestSerializer serializer];
                [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"cookie"] forHTTPHeaderField:@"ticket"];
                
                NSString *url = @"http://127.0.0.1:8080/require_login/like";
                NSDictionary *params = @{
                    @"EventType" : @(MINGContentTypeComment),
                    @"eventId" : input
                };
                
                [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    if ([[responseObject objectForKey:@"code"] isEqualToNumber:@0]) {
                        NSNumber *likeCount = [NSNumber numberWithInt:(int)[responseObject objectForKey:@"msg"]];
                        [subscriber sendNext: likeCount];
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

- (RACCommand<NSString *,NSNumber *> *)disLikeCommand
{
    if (!_disLikeCommand) {
        _disLikeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                manager.requestSerializer = [AFHTTPRequestSerializer serializer];
                [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"cookie"] forHTTPHeaderField:@"ticket"];
                
                NSString *url = @"http://127.0.0.1:8080/require_login/dislike";
                NSDictionary *params = @{
                    @"EventType" : @(MINGContentTypeComment),
                    @"eventId" : input
                };
                
                [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    if ([[responseObject objectForKey:@"code"] isEqualToNumber:@0]) {
                        NSInteger likeCount = (int)[responseObject objectForKey:@"msg"];
                        [subscriber sendNext: @(likeCount)];
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


@end
