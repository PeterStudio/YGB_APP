//
//  AccountTransferService.m
//  BZProject
//
//  Created by duwen on 14/12/15.
//  Copyright (c) 2014年 peterstudio. All rights reserved.
//

#import "AccountTransferService.h"
#import "AccountTransferModel.h"
@implementation AccountTransferService
{
    NSString * memberIdKey;
    NSString * addrKey;
    NSString * fundsKey;
    NSString * typesKey;
    NSString * hashKey;
}

- (id)init{
    if (self = [super init]) {
        memberIdKey = @"member_id";
        addrKey     = @"addr";
        fundsKey    = @"funds";
        typesKey    = @"types";
        hashKey     = @"hash";
    }
    return self;
}

- (void)accountTransfer_Request_HTTP_memberID:(NSString *)_memberId
                                      address:(NSString *)_address
                                        funds:(NSString *)_funds
                                        types:(NSString *)_types
                                      success:(void (^)(id))success
                                      failure:(void (^)(NSError *))failure{
    // 组装入参parameters对象
    NSString * hashStr = [NSString stringWithFormat:@"%@%@%@%@%@",_memberId,_address,_funds,_types,MD5KEY];
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:_memberId,memberIdKey,_address,addrKey,_funds,fundsKey,_types,typesKey,[hashStr stringFromMD5],hashKey, nil];
    // 发送POST请求
    [[AFHTTPRequestOperationManager manager] POST:HTTP_AccountTransfer_URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        /*******成功返回处理逻辑**********/
        // 如果接口返回数据不加密，responseObject为NSDictionary类型，直接通过JSONModel方法反射出实体类
        AccountTransferModel * demoModel = [[AccountTransferModel alloc] initWithDictionary:responseObject error:nil];
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
