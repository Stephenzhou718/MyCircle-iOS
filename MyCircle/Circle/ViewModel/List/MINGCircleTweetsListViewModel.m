//
//  MINGCircleTweetsListViewModel.m
//  MyCircle
//
//  Created by 周汉明 on 2020/4/15.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGCircleTweetsListViewModel.h"
#import "MINGTweetsItem.h"

#import <AFNetworking/AFNetworking.h>

@interface MINGCircleTweetsListViewModel ()

@property (nonatomic, assign) NSInteger offset;
@property (nonatomic, assign) NSInteger limit;
@property (nonatomic, copy) NSString *circleId;

@end

@implementation MINGCircleTweetsListViewModel

- (instancetype)initWithCircleId:(NSString *)circleId
{
    self = [super init];
    if (self) {
        self.offset = 0;
        self.limit = 6;
        self.circleId = circleId;
    }
    return self;
}


#pragma mark - lazy load

- (NSMutableArray<MINGTweetsItem *> *)tweetsItems
{
    if (!_tweetsItems) {
        _tweetsItems = [NSMutableArray new];
    }
    return _tweetsItems;
}

- (RACCommand *)refreshCommand
{
    if (!_refreshCommand) {
        _refreshCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                
                // 参数字典
                NSDictionary *params = @{
                    @"offset" : @0,
                    @"limit" : @(self.limit),
                    @"circleId" : self.circleId
                };
                
                NSString *url = @"http://127.0.0.1:8080/circle/tweets";
                url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"#%^{}\"[]|\\<> "].invertedSet];
                
                [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    
                    if ([[responseObject objectForKey:@"code"] isEqualToNumber:@0]) {
                        NSArray<MINGTweetsItem *> *tweetsItemsFromNet = [MTLJSONAdapter modelsOfClass:[MINGTweetsItem class] fromJSONArray:[responseObject objectForKey:@"data"] error:nil];
                        [self.tweetsItems addObjectsFromArray:tweetsItemsFromNet];
                        self.offset = self.tweetsItems.count;
                        
                        [subscriber sendNext:@YES];
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
                    @"offset" : @(self.offset),
                    @"limit" : @(self.limit),
                    @"circleId" : self.circleId
                };
                
                NSString *url = @"http://127.0.0.1:8080/circle/videos";
                url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"#%^{}\"[]|\\<> "].invertedSet];
                
                [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    
                    if ([[responseObject objectForKey:@"code"] isEqualToNumber:@0]) {
                        NSArray<MINGTweetsItem *> *tweetsItemsFromNet = [MTLJSONAdapter modelsOfClass:[MINGTweetsItem class] fromJSONArray:[responseObject objectForKey:@"data"] error:nil];
                        [self.tweetsItems addObjectsFromArray:tweetsItemsFromNet];
                        self.offset += self.tweetsItems.count;
                        Boolean hasMore = [tweetsItemsFromNet lastObject].hasMore;
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
