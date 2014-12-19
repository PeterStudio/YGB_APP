//
//  VersionService.m
//  BZProject
//
//  Created by duwen on 14/12/15.
//  Copyright (c) 2014年 peterstudio. All rights reserved.
//

#import "VersionService.h"
#import "VersionModel.h"
@implementation VersionService
{
    NSString * versionKey;
    NSString * typeKey;
    NSString * imeiKey;
    NSString * hashKey;
}

- (id)init{
    if (self = [super init]) {
        versionKey  = @"version";
        typeKey     = @"type";
        imeiKey     = @"imei";
        hashKey     = @"hash";
    }
    return self;
}

- (void)version_Request_HTTP_Version:(NSString *)version
                                type:(NSString *)_type
                                imei:(NSString *)_imei
                             success:(void (^)(id))success
                             failure:(void (^)(NSError *))failure{
    // 组装入参parameters对象
    NSString * hashStr = [NSString stringWithFormat:@"%@%@%@%@",version,_type,_imei,MD5KEY];
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:version,versionKey,_type,typeKey,_imei,imeiKey,[hashStr stringFromMD5],hashKey, nil];
    // 发送POST请求
    [[AFHTTPRequestOperationManager manager] POST:HTTP_VersionUpdate_URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        /*******成功返回处理逻辑**********/
        // 如果接口返回数据不加密，responseObject为NSDictionary类型，直接通过JSONModel方法反射出实体类
        VersionModel * demoModel = [[VersionModel alloc] initWithDictionary:responseObject error:nil];
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
