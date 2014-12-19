//
//  RegistService.h
//  BZProject
//
//  Created by duwen on 14/12/15.
//  Copyright (c) 2014年 peterstudio. All rights reserved.
//

#import "BaseService.h"

@interface RegistService : BaseService

/**
 *  验证码获取
 *
 *  @param mob     手机号
 *  @param success 成功后调用的block
 *  @param failure 失败后调用的block
 */
- (void)confirmationCode_Request_HTTP_PhoneNum:(NSString *)mob
                              success:(void (^)(id responseObject))success
                              failure:(void (^)(NSError *error))failure;


/**
 *  注册登录
 *
 *  @param mob          手机号
 *  @param _password    密码
 *  @param _recommendID 推荐人ID
 *  @param success      成功后调用的block
 *  @param failure      失败后调用的block
 */
- (void)regist_Request_HTTP_PhoneNum:(NSString *)mob
                            password:(NSString *)_password
                         recommendID:(NSString *)_recommendID
                                imei:(NSString *)_imei
                             success:(void (^)(id responseObject))success
                             failure:(void (^)(NSError *error))failure;

@end
