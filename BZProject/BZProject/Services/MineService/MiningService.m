//
//  MiningService.m
//  BZProject
//
//  Created by duwen on 14/12/15.
//  Copyright (c) 2014年 peterstudio. All rights reserved.
//

#import "MiningService.h"
#import "MiningModel.h"
@implementation MiningService
{
    NSString * idKey;
    NSString * typeKey;
    NSString * hashKey;
}

- (id)init{
    if (self = [super init]) {
        idKey   = @"id";
        typeKey = @"type";
        hashKey = @"hash";
    }
    return self;
}

- (void)mining_Request_HTTP_UserID:(NSString *)userId
                              type:(NSString *)_type
                           success:(void (^)(id))success
                           failure:(void (^)(NSError *))failure{
    // 组装入参parameters对象
    NSString * hashStr = [NSString stringWithFormat:@"%@%@%@",userId,_type,MD5KEY];
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:userId,idKey,_type,typeKey,[hashStr stringFromMD5],hashKey, nil];
    // 发送POST请求
    [[AFHTTPRequestOperationManager manager] POST:HTTP_Mining_URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        /*******成功返回处理逻辑**********/
        // 如果接口返回数据不加密，responseObject为NSDictionary类型，直接通过JSONModel方法反射出实体类
        MiningModel * demoModel = [[MiningModel alloc] initWithDictionary:responseObject error:nil];
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
