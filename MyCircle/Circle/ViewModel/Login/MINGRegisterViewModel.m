//
//  MINGRegisterViewModel.m
//  MyCircle
//
//  Created by 周汉明 on 2020/4/19.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGRegisterViewModel.h"

#import <AFNetworking/AFNetworking.h>

@interface MINGRegisterViewModel ()

@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *password;

@end

@implementation MINGRegisterViewModel



#pragma mark - public
- (void)loadUsername:(NSString *)username
{
    self.username = username;
}

- (void)loadPassword:(NSString *)password
{
    self.password = password;
}


#pragma mark - lazy load

- (RACCommand *)registerCommand
{
    if (!_registerCommand) {
        _registerCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                
                NSString *url = @"http://127.0.0.1:8080/user/register";
                NSDictionary *params = @{
                    @"username" : self.username,
                    @"password" : self.password
                };
                
                [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    if ([[responseObject objectForKey:@"code"] isEqualToNumber:@0]) {
                        //cookies获取
                          NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
                          NSArray *cookieArr = [cookieJar cookies];
                          for(NSHTTPCookie *cookie in cookieArr) {
                               NSLog(@"cookie －> %@", cookie);
                               if ([cookie.name isEqualToString:@"ticket"]) {
                                      //存储cookies
                                   NSLog(@"%@", cookie.value);
                                   [[NSUserDefaults standardUserDefaults] setObject:cookie.value forKey:@"cookie"];
                                   [[NSUserDefaults standardUserDefaults] setObject:self.username forKey:@"username"];
                                }
                               //存储之后删除cookies
//                               [cookieJar deleteCookie:cookie];
                          }
                                            
                        [[NSUserDefaults standardUserDefaults] setObject:self.username forKey:@"username"];
                        [[NSUserDefaults standardUserDefaults] setObject:self.password forKey:@"password"];
                        
                        [subscriber sendNext:@YES];
                        [subscriber sendCompleted];
                    } else {
                        self.errorMsg = [responseObject objectForKey:@"msg"];
                        [subscriber sendError:nil];
                    }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    [subscriber sendError:nil];
                }];
                
                return nil;
            }];
        }];
    }
    return _registerCommand;
}

@end





