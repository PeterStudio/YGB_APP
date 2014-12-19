//
//  RegistService.m
//  BZProject
//
//  Created by duwen on 14/12/15.
//  Copyright (c) 2014年 peterstudio. All rights reserved.
//

#import "RegistService.h"
#import "RegistModel.h"

@implementation RegistService
{
    NSString * mobKey;
    NSString * user_passKey;
    NSString * fidKey;
    NSString * imeiKey;
    NSString * hashKey;
}

- (id)init{
    if(self = [super init]){
        mobKey = @"mob";
        user_passKey = @"user_pass";
        fidKey = @"fid";
        imeiKey = @"imei";
        hashKey = @"hash";
    }
    return self;
}

- (void)confirmationCode_Request_HTTP_PhoneNum:(NSString *)mob
                                       success:(void (^)(id))success
                                       failure:(void (^)(NSError *))failure{
    // 组装入参parameters对象
    NSString * hashStr = [NSString stringWithFormat:@"%@%@",mob,MD5KEY];
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:mob,mobKey,[hashStr stringFromMD5],hashKey, nil];
    // 发送POST请求
    [[AFHTTPRequestOperationManager manager] POST:HTTP_LanguageConfirmationCode_URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        /*******成功返回处理逻辑**********/
        // 如果接口返回数据不加密，responseObject为NSDictionary类型，直接通过JSONModel方法反射出实体类
        ConfirmationCodeModel * demoModel = [[ConfirmationCodeModel alloc] initWithDictionary:responseObject error:nil];
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

- (void)regist_Request_HTTP_PhoneNum:(NSString *)mob
                            password:(NSString *)_password
                         recommendID:(NSString *)_recommendID
                                imei:(NSString *)_imei
                             success:(void (^)(id))success
                             failure:(void (^)(NSError *))failure{
    NSDictionary * params = nil;
    NSString * hashStr = nil;
    if (_recommendID && ![@"" isEqualToString:_recommendID]) {
        hashStr = [NSString stringWithFormat:@"%@%@%@%@%@",mob,_password,_recommendID,_imei,MD5KEY];
        params = [NSDictionary dictionaryWithObjectsAndKeys:mob,mobKey,_password,user_passKey,_recommendID,fidKey,_imei,imeiKey,[hashStr stringFromMD5],hashKey, nil];
    }else{
        hashStr = [NSString stringWithFormat:@"%@%@%@%@",mob,_password,_imei,MD5KEY];
        params = [NSDictionary dictionaryWithObjectsAndKeys:mob,mobKey,_password,user_passKey,_imei,imeiKey,[hashStr stringFromMD5],hashKey, nil];
    }
    // 发送POST请求
    [[AFHTTPRequestOperationManager manager] POST:HTTP_UserRegist_URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        /*******成功返回处理逻辑**********/
        // 如果接口返回数据不加密，responseObject为NSDictionary类型，直接通过JSONModel方法反射出实体类
        RegistModel * demoModel = [[RegistModel alloc] initWithDictionary:responseObject error:nil];
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
