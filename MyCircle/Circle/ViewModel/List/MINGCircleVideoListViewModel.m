//
//  MINGCircleVideoListViewModel.m
//  MyCircle
//
//  Created by 周汉明 on 2020/4/11.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGCircleVideoListViewModel.h"

#import <AFNetworking/AFNetworking.h>
#import <Mantle/Mantle.h>

@interface MINGCircleVideoListViewModel()

@property (nonatomic, assign) NSInteger offset;
@property (nonatomic, assign) NSInteger limit;

@end

@implementation MINGCircleVideoListViewModel


#pragma mark - life circle

- (instancetype)init
{
    self = [super init];
    if (self) {
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
                    @"offset" : @0,
                    @"limit" : @(self.limit)
                };
                
                // 请求
                NSString *url = @"http://127.0.0.1:8080/index";
                url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"#%^{}\"[]|\\<> "].invertedSet];
                [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    
                    if ([[responseObject objectForKey:@"code"] isEqualToNumber:@0]) {
                        NSArray<MINGVideoItem *> *videoItemsFromNet = [MTLJSONAdapter modelsOfClass:[MINGVideoItem class] fromJSONArray:[responseObject objectForKey:@"data"] error:nil];
                        self.videoItems = [NSMutableArray arrayWithArray:videoItemsFromNet];
                        self.offset = videoItemsFromNet.count;
                        Boolean hasMore = [videoItemsFromNet lastObject].hasMore;
                        [subscriber sendNext:[NSNumber numberWithBool:hasMore]];
                        [subscriber sendCompleted];
                        
                    } else {
                        NSDictionary *userInfo = @{NSLocalizedDescriptionKey:@"网络请求错误"};
                        [subscriber sendError:[NSError errorWithDomain:NSCocoaErrorDomain code:0 userInfo:userInfo]];
                    }
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    NSDictionary *userInfo = @{NSLocalizedDescriptionKey:@"网络请求错误"};
                    [subscriber sendError:[NSError errorWithDomain:NSCocoaErrorDomain code:0 userInfo:userInfo]];
                    NSLog(error);
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
                    @"offset" : @(self.offset),
                    @"limit" : @(self.limit)
                };
                // 请求
                NSString *url = @"http://127.0.0.1:8080/index";
                url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"#%^{}\"[]|\\<> "].invertedSet];
                [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    
                    if ([[responseObject objectForKey:@"code"] isEqualToNumber:@0]) {
                        NSArray<MINGVideoItem *> *videoItemsFromNet = [MTLJSONAdapter modelsOfClass:[MINGVideoItem class] fromJSONArray:[responseObject objectForKey:@"data"] error:nil];
                        [self.videoItems addObjectsFromArray:videoItemsFromNet];
                        self.offset += videoItemsFromNet.count;
                        Boolean hasMore = [videoItemsFromNet lastObject].hasMore;
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

@end
