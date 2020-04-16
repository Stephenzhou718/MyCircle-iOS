//
//  MINGCircleDetailViewModel.m
//  MyCircle
//
//  Created by 周汉明 on 2020/4/15.
//  Copyright © 2020 周汉明. All rights reserved.
//



#import "MINGCircleDetailViewModel.h"
#import "MINGUserItem.h"

#import <AFNetworking/AFNetworking.h>

@interface MINGCircleDetailViewModel ()

@end

@implementation MINGCircleDetailViewModel

- (instancetype)initWithCircleItem:(MINGCircleItem *)circleItem
{
    self = [super init];
    if (self) {
        self.circleItem = circleItem;
    }
    return self;
}


#pragma mark - lazy load

- (RACCommand *)getCircleMembersCommand
{
    if (!_getCircleMembersCommand) {
        _getCircleMembersCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                
                // 参数字典
                NSDictionary *params = @{
                    @"circleId" : self.circleItem.circle.circleId
                };
                
                // 请求
                NSString *url = @"http://127.0.0.1:8080/circle/get_circle_members";
                url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"#%^{}\"[]|\\<> "].invertedSet];
                [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    if ([[responseObject objectForKey:@"code"] isEqualToNumber:@0]) {
                        NSArray<MINGUserItem *> *circleMembersFromNet = [MTLJSONAdapter modelsOfClass:[MINGUserItem class] fromJSONArray:[responseObject objectForKey:@"data"] error:nil];
                        self.circleMembers = [NSMutableArray arrayWithArray:circleMembersFromNet];
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
    return _getCircleMembersCommand;
}


@end
