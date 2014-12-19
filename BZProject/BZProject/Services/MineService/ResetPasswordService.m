//
//  ResetPasswordService.m
//  BZProject
//
//  Created by duwen on 14/12/15.
//  Copyright (c) 2014年 peterstudio. All rights reserved.
//

#import "ResetPasswordService.h"
#import "ResetPasswordModel.h"
#import "LoginManager.h"
@implementation ResetPasswordService
{
    NSString * memberIdKey;
    NSString * old_passKey;
    NSString * passnewKey;
    NSString * hashKey;
}

- (id)init{
    if (self = [super init]) {
        memberIdKey = @"member_id";
        old_passKey = @"old_pass";
        passnewKey  = @"passnew";
        hashKey     = @"hash";
    }
    return self;
}

- (void)resetPassword_Request_HTTP_UserID:(NSString *)userId
                              oldPassword:(NSString *)_oldPassword
                              newPassword:(NSString *)_newPassword
                                  success:(void (^)(id))success
                                  failure:(void (^)(NSError *))failure{
    // 组装入参parameters对象
    NSString * hashStr = [NSString stringWithFormat:@"%@%@%@%@",userId,_oldPassword,_newPassword,MD5KEY];
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:userId,memberIdKey,_oldPassword,old_passKey,_newPassword,passnewKey,[hashStr stringFromMD5],hashKey, nil];
    // 发送POST请求
    [[AFHTTPRequestOperationManager manager] POST:HTTP_ChangePassword_URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        /*******成功返回处理逻辑**********/
        // 如果接口返回数据不加密，responseObject为NSDictionary类型，直接通过JSONModel方法反射出实体类
        ResetPasswordModel * demoModel = [[ResetPasswordModel alloc] initWithDictionary:responseObject error:nil];
        if ([RETURN_CODE_SUCCESS isEqualToString:demoModel.status]) {
            [[LoginManager shareInstance] deletePassword];
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
