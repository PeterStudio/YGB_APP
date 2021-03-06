//
//  SiginService.m
//  BZProject
//
//  Created by duwen on 14/12/15.
//  Copyright (c) 2014年 peterstudio. All rights reserved.
//

#import "SignInService.h"
#import "SignInModel.h"
@implementation SignInService
{
    NSString * memberIDKey;
    NSString * hashKey;
}

- (id)init{
    if (self == [super init]) {
        memberIDKey = @"member_id";
        hashKey     = @"hash";
    }
    return self;
}

- (void)signIn_Request_HTTP_memberID:(NSString *)memberId
                             success:(void (^)(id))success
                             failure:(void (^)(NSError *))failure{
    // 组装入参parameters对象
    NSString * hashStr = [NSString stringWithFormat:@"%@%@",memberId,MD5KEY];
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:memberId,memberIDKey,[hashStr stringFromMD5],hashKey, nil];
    // 发送POST请求
    [[AFHTTPRequestOperationManager manager] POST:HTTP_SignIn_URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        /*******成功返回处理逻辑**********/
        // 如果接口返回数据不加密，responseObject为NSDictionary类型，直接通过JSONModel方法反射出实体类
        SignInModel * demoModel = [[SignInModel alloc] initWithDictionary:responseObject error:nil];
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
