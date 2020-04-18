//
//  MINGPublishVideoViewModel.m
//  MyCircle
//
//  Created by 周汉明 on 2020/4/17.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGPublishVideoViewModel.h"

#import <AFNetworking/AFNetworking.h>

@interface MINGPublishVideoViewModel ()



@end

@implementation MINGPublishVideoViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


#pragma mark - lazy load

- (RACCommand *)uploadVideoCommand
{
    if (!_uploadVideoCommand) {
        _uploadVideoCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                manager.requestSerializer = [AFHTTPRequestSerializer serializer];
                [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"cookie"] forHTTPHeaderField:@"ticket"];
                manager.responseSerializer = [AFJSONResponseSerializer serializer];
                [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
                
                NSString *url = @"http://127.0.0.1:8080/uploadImage";
                url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"#%^{}\"[]|\\<> "].invertedSet];
                NSString *fileName = @"1.mp4";
                
                [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                    [formData appendPartWithFileURL:self.fileUrl name:@"file" fileName:fileName mimeType:@"video/mp4" error:nil];
                } progress:^(NSProgress * _Nonnull uploadProgress) {
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    if ([[responseObject objectForKey:@"code"] isEqualToNumber:@0]) {
                        self.videoUrl = [responseObject objectForKey:@"msg"];
                        [subscriber sendNext:[[responseObject objectForKey:@"msg"] stringByAppendingString:@"?vframe/jpg/offset/1"]];
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
    return _uploadVideoCommand;
}

- (RACCommand *)publishCommand
{
    if (!_publishCommand) {
        _publishCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                
                // 参数字典
                NSDictionary *params = @{
                    @"title" : self.title,
                    @"content" : self.content,
                    @"url" : self.videoUrl,
                    @"belongCircleId" : @"0c41c0a961224abe8858212822a862dd"
                };
                
                NSString *url = @"http://127.0.0.1:8080/require_login/circle/add_video";
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
