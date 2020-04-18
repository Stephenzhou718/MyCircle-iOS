//
//  MINGPublishTweetsViewModel.m
//  MyCircle
//
//  Created by 周汉明 on 2020/4/17.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGPublishTweetsViewModel.h"

#import <AFNetworking/AFNetworking.h>

@implementation MINGPublishTweetsViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark - lazy load

- (RACCommand *)uploadImageOneCommand
{
    if (!_uploadImageOneCommand) {
        _uploadImageOneCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                
                NSString *url = @"http://127.0.0.1:8080/uploadImage";
                url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"#%^{}\"[]|\\<> "].invertedSet];
                NSString *fileName = @"1.jpg";
                NSData *imageData = UIImageJPEGRepresentation(self.imageOne, 0.7f);

                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                manager.requestSerializer = [AFHTTPRequestSerializer serializer];
                manager.responseSerializer = [AFJSONResponseSerializer serializer];

                [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
                
                [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                    [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpeg"];
                } progress:^(NSProgress * _Nonnull uploadProgress) {
                    NSLog(@"Progress: %@", uploadProgress);
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    if ([[responseObject objectForKey:@"code"] isEqualToNumber:@0]) {
                        self.imageOneUrl = [responseObject objectForKey:@"msg"];
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
    return _uploadImageOneCommand;
}

- (RACCommand *)uploadImageTwoCommand
{
    if (!_uploadImageTwoCommand) {
        _uploadImageTwoCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                NSString *url = @"http://127.0.0.1:8080/uploadImage";
                url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"#%^{}\"[]|\\<> "].invertedSet];
                NSString *fileName = @"2.jpg";
                NSData *imageData = UIImageJPEGRepresentation(self.imageTwo, 0.7f);

                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                manager.requestSerializer = [AFHTTPRequestSerializer serializer];
                manager.responseSerializer = [AFJSONResponseSerializer serializer];

                [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
                
                [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                    [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpeg"];
                } progress:^(NSProgress * _Nonnull uploadProgress) {
                    NSLog(@"Progress: %@", uploadProgress);
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    if ([[responseObject objectForKey:@"code"] isEqualToNumber:@0]) {
                        self.imageTwoUrl = [responseObject objectForKey:@"msg"];
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
    return _uploadImageTwoCommand;
}

- (RACCommand *)uploadImageThreeCommand
{
    if (!_uploadImageThreeCommand) {
        _uploadImageThreeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                NSString *url = @"http://127.0.0.1:8080/uploadImage";
                url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"#%^{}\"[]|\\<> "].invertedSet];
                NSString *fileName = @"1.jpg";
                NSData *imageData = UIImageJPEGRepresentation(self.imageThree, 0.7f);

                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                manager.requestSerializer = [AFHTTPRequestSerializer serializer];
                [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"cookie"] forHTTPHeaderField:@"ticket"];
                manager.responseSerializer = [AFJSONResponseSerializer serializer];

                [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
                
                [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                    [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpeg"];
                } progress:^(NSProgress * _Nonnull uploadProgress) {
                    NSLog(@"Progress: %@", uploadProgress);
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    if ([[responseObject objectForKey:@"code"] isEqualToNumber:@0]) {
                        self.imageThreeUrl = [responseObject objectForKey:@"msg"];
                        [subscriber sendNext:[responseObject objectForKey:@"msg"]];
                        [subscriber sendCompleted];
                    } else {

                    }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    [subscriber sendError:error];
                }];
                return nil;
                return nil;
            }];
        }];
    }
    return _uploadImageThreeCommand;
}

- (RACCommand *)publishCommand
{
    if (!_publishCommand) {
        _publishCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                
                NSString *imgs = @"";
                if (self.imageOneUrl != nil) {
                    imgs = [imgs stringByAppendingString:self.imageOneUrl];
                }
                if (self.imageTwoUrl != nil) {
                    imgs = [imgs stringByAppendingString:@","];
                    imgs = [imgs stringByAppendingString:self.imageTwoUrl];
                }
                if (self.imageThreeUrl != nil) {
                    imgs = [imgs stringByAppendingString:@","];
                    imgs = [imgs stringByAppendingString:self.imageThreeUrl];
                }
                // 参数字典
                NSDictionary *params = @{
                    @"content" : self.content,
                    @"imgs" : imgs,
                    @"belongCircleId" : @"0c41c0a961224abe8858212822a862dd"
                };
                
                NSString *url = @"http://127.0.0.1:8080/require_login/circle/add_tweets";
                 url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"#%^{}\"[]|\\<> "].invertedSet];
                
                [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    if ([[responseObject objectForKey:@"code"] isEqualToNumber:@0]) {
                        [subscriber sendNext:@YES];
                        [subscriber sendCompleted];
                    } else {
                        NSString *msg = [responseObject objectForKey:@"msg"];
                        NSLog(@"%@", msg);
                    }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    [subscriber sendError:error];
                }];
                return nil;
            }];
        }];
    }
    return _publishCommand;
}

@end
