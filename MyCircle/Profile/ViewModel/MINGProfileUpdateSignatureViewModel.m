//
//  MINGProfileUpdateSignatureViewModel.m
//  MyCircle
//
//  Created by 周汉明 on 2020/4/18.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGProfileUpdateSignatureViewModel.h"

#import <AFNetworking/AFNetworking.h>

@implementation MINGProfileUpdateSignatureViewModel

#pragma mark - lazy load

- (RACCommand *)updateSignatureCommand
{
    if (!_updateSignatureCommand) {
        _updateSignatureCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                manager.requestSerializer = [AFHTTPRequestSerializer serializer];
                [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"cookie"] forHTTPHeaderField:@"ticket"];
                
                NSString *url = @"http://127.0.0.1:8080/require_login/user/update_signature";
                NSDictionary *params = @{
                    @"signature" : self.signature
                };
                
                [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    if ([[responseObject objectForKey:@"code"] isEqualToNumber:@0]) {
                        [subscriber sendNext:nil];
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
    return _updateSignatureCommand;
}

@end
