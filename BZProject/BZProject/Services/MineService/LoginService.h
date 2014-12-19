//
//  LoginService.h
//  BZProject
//
//  Created by duwen on 14/12/15.
//  Copyright (c) 2014年 peterstudio. All rights reserved.
//

#import "BaseService.h"

@interface LoginService : BaseService


/**
 *  登录
 *
 *  @param userName  用户名
 *  @param _password 密码
 *  @param _system   系统型号
 *  @param _version  APP版本号
 *  @param _imei     设备号
 *  @param success   成功回调
 *  @param failure   失败回调
 */
- (void)login_Request_HTTP_UserName:(NSString *)userName
                           password:(NSString *)_password
                             system:(NSString *)_system
                            version:(NSString *)_version
                               imei:(NSString *)_imei
                            success:(void (^)(id responseObject))success
                            failure:(void (^)(NSError *error))failure;

@end
