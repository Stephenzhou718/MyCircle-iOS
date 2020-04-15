//
//  MINGCircleSelectionViewModel.m
//  MyCircle
//
//  Created by 周汉明 on 2020/4/15.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGCircleSelectionViewModel.h"

#import <AFNetworking/AFNetworking.h>

@interface MINGCircleSelectionViewModel()

@property (nonatomic, assign) MINGCircleSelectionType type;

@end

@implementation MINGCircleSelectionViewModel

- (instancetype)initWithSelectionType:(MINGCircleSelectionType)type
{
    self = [super init];
    if (self) {
        self.circleItems = [NSMutableArray new];
        self.type = type;
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
                
                // 请求
                NSString *url = @"";
                if (self.type == MINGCircleSelectionTypeAll) {
                    url = @"http://127.0.0.1:8080/circle/get_all_circles";
                } else {
                    url = @"http://127.0.0.1:8080/circle/get_joined_circles";
                }
                url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"#%^{}\"[]|\\<> "].invertedSet];
                
                // 请求
                [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
                    // 请求进度
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    if ([[responseObject objectForKey:@"code"] isEqualToNumber:@0]) {
                        NSArray<MINGCircleItem *> *circleItemsFromNet = [MTLJSONAdapter modelsOfClass:[MINGCircleItem class] fromJSONArray:[responseObject objectForKey:@"data"] error:nil];
                        self.circleItems = [NSMutableArray arrayWithArray:circleItemsFromNet];
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

@end
