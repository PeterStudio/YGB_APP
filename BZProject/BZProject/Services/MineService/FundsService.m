//
//  FundsService.m
//  BZProject
//
//  Created by duwen on 14/12/15.
//  Copyright (c) 2014年 peterstudio. All rights reserved.
//

#import "FundsService.h"
#import "UserFundsModel.h"

@implementation FundsService
{
    NSString * idKey;
    NSString * hashKey;
}

- (id)init{
    if (self = [super init]) {
        idKey   = @"id";
        hashKey = @"hash";
    }
    return self;
}

- (void)funds_Request_HTTP_UserID:(NSString *)userId
                          success:(void (^)(id responseObject))success
                          failure:(void (^)(NSError *error))failure;{
    // 组装入参parameters对象
    NSString * hashStr = [NSString stringWithFormat:@"%@%@",userId,MD5KEY];
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:userId,idKey,[hashStr stringFromMD5],hashKey, nil];
    // 发送POST请求
    [[AFHTTPRequestOperationManager manager] POST:HTTP_GetUserFunds_URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        /*******成功返回处理逻辑**********/
        // 如果接口返回数据不加密，responseObject为NSDictionary类型，直接通过JSONModel方法反射出实体类
        UserFundsModel * demoModel = [[UserFundsModel alloc] initWithDictionary:responseObject error:nil];
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
