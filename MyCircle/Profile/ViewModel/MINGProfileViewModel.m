//
//  MINGProfileViewModel.m
//  MyCircle
//
//  Created by 周汉明 on 2020/4/18.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGProfileViewModel.h"

#import <AFNetworking/AFNetworking.h>

@implementation MINGProfileViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark - lazy load

- (RACCommand *)getUserInfoCommand
{
    if (!_getUserInfoCommand) {
        _getUserInfoCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                manager.requestSerializer = [AFHTTPRequestSerializer serializer];
                manager.responseSerializer = [AFJSONResponseSerializer serializer];
                [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"cookie"] forHTTPHeaderField:@"ticket"];
                
                NSString *url = @"http://127.0.0.1:8080/require_login/get_user_info";
                url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"#%^{}\"[]|\\<> "].invertedSet];
                [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    if ([[responseObject objectForKey:@"code"] isEqualToNumber:@0]) {
                        self.user = [MTLJSONAdapter modelOfClass:[MINGUser class] fromJSONDictionary:[responseObject objectForKey:@"data"] error:nil];
                        [subscriber sendNext:nil];
                        [subscriber sendCompleted];
                    } else {
                        [subscriber sendError:nil];
                    }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    [subscriber sendError:error];
                }];
                
                return nil;;
            }];
        }];
    }
    return _getUserInfoCommand;
}

- (RACCommand *)uploadAvatarCommand
{
    if (!_uploadAvatarCommand) {
        _uploadAvatarCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                manager.requestSerializer = [AFHTTPRequestSerializer serializer];
                manager.responseSerializer = [AFJSONResponseSerializer serializer];
//                [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"cookie"] forHTTPHeaderField:@"ticket"];
                
                [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    
                NSString *url = @"http://127.0.0.1:8080/uploadImage";
                url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"#%^{}\"[]|\\<> "].invertedSet];
                NSString *fileName = @"1.jpg";
                NSData *imageData = UIImageJPEGRepresentation(self.uploadImage, 0.7f);
                
                [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                    [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpeg"];
                } progress:^(NSProgress * _Nonnull uploadProgress) {
                    NSLog(@"Progress: %@", uploadProgress);
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    if ([[responseObject objectForKey:@"code"] isEqualToNumber:@0]) {
                        self.avatarUrl = [responseObject objectForKey:@"msg"];
                        [subscriber sendNext:[responseObject objectForKey:@"msg"]];
                        [subscriber sendCompleted];
                    } else {

                    }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    [subscriber sendError:error];
                }];
                return nil;
            }];
        }];
    }
    return _uploadAvatarCommand;
}

- (RACCommand *)updataAvatarUrlCommand
{
    if (!_updataAvatarUrlCommand) {
        _updataAvatarUrlCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"cookie"] forHTTPHeaderField:@"ticket"];
                
                NSString *url = @"http://127.0.0.1:8080/require_login/user/update_head_url";
                NSDictionary *params = @{
                    @"headUrl" : self.avatarUrl
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
    return _updataAvatarUrlCommand;
}

@end
