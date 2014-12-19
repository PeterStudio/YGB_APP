//
//  LoginService.m
//  BZProject
//
//  Created by duwen on 14/12/15.
//  Copyright (c) 2014年 peterstudio. All rights reserved.
//

#import "LoginService.h"
#import "LoginModel.h"
#import "LoginManager.h"
@implementation LoginService
{
    NSString * userNameKey;
    NSString * passwordKey;
    NSString * systemKey;
    NSString * vesionKey;
    NSString * imeiKey;
    NSString * hashKey;
}

- (id)init{
    if (self = [super init]) {
        userNameKey = @"username";
        passwordKey = @"password";
        systemKey   = @"system";
        vesionKey   = @"version";
        imeiKey     = @"imei";
        hashKey     = @"hash";
    }
    return self;
}

- (void)login_Request_HTTP_UserName:(NSString *)userName
                           password:(NSString *)_password
                             system:(NSString *)_system
                            version:(NSString *)_version
                               imei:(NSString *)_imei
                            success:(void (^)(id))success
                            failure:(void (^)(NSError *))failure{
    // 组装入参parameters对象
    NSString * hashStr = [NSString stringWithFormat:@"%@%@%@%@%@%@",userName,_password,_system,_version,_imei,MD5KEY];
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:userName,userNameKey,_password,passwordKey,_system,systemKey,_version,vesionKey,_imei,imeiKey,[hashStr stringFromMD5],hashKey, nil];
    // 发送POST请求
    [[AFHTTPRequestOperationManager manager] POST:HTTP_UserLogin_URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        /*******成功返回处理逻辑**********/
        LoginModel * demoModel = [[LoginModel alloc] initWithDictionary:responseObject error:nil];
        if ([RETURN_CODE_SUCCESS isEqualToString:demoModel.status]) {
            [[LoginManager shareInstance] saveAccountInfo:(LoginDetailModel *)demoModel.data];
        }
        // 调用success块
        if (success) {
            success(demoModel);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        /*******失败返回处理逻辑**********/
        if (failure) {
            failure(error);
        }
    }];

}

@end
