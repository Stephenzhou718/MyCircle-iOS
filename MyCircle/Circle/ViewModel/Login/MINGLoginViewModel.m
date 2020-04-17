//
//  MINGLoginViewModel.m
//  MyCircle
//
//  Created by 周汉明 on 2020/4/16.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGLoginViewModel.h"

#import <AFNetworking/AFNetworking.h>

@interface MINGLoginViewModel ()

@property (nonatomic, strong) MINGUser *user;
@property (nonatomic, copy) NSString *password;

@end

@implementation MINGLoginViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark - public

- (void)setUserInfoWithUser:(MINGUser *)user
{
    self.user = user;
}

- (void)setPass:(NSString *)password
{
    self.password = password;
}

#pragma mark - lazy load

- (RACCommand *)loginCommand
{
    if (!_loginCommand) {
        _loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                
                // 参数字典
                NSDictionary *params = @{
                    @"username" : self.user.username,
                    @"password" : self.password
                };
                
                NSString *url = @"http://127.0.0.1:8080/user/login";
                url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"#%^{}\"[]|\\<> "].invertedSet];
                
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

                                }
                               //存储之后删除cookies
                               [cookieJar deleteCookie:cookie];
                          }
                        
                        [[NSUserDefaults standardUserDefaults] setObject:self.user.username forKey:@"username"];
                        [[NSUserDefaults standardUserDefaults] setObject:self.password forKey:@"password"];
                        
                        [subscriber sendNext:@YES];
                        [subscriber sendCompleted];
                    } else {
                        NSDictionary *userInfo = @{NSLocalizedDescriptionKey:@"密码或用户名错误"};
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
    return _loginCommand;
}

- (RACCommand *)registerCommand
{
    if (!_registerCommand) {
        
    }
    return _registerCommand;
}






@end
