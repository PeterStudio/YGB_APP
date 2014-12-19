//
//  ResetPasswordService.h
//  BZProject
//
//  Created by duwen on 14/12/15.
//  Copyright (c) 2014年 peterstudio. All rights reserved.
//

#import "BaseService.h"

@interface ResetPasswordService : BaseService

/**
 *  修改密码
 *
 *  @param userId       用户ID
 *  @param _oldPassword 旧密码
 *  @param _newPassword 新密码
 *  @param success      成功回调
 *  @param failure      失败回调
 */
- (void)resetPassword_Request_HTTP_UserID:(NSString *)userId
                              oldPassword:(NSString *)_oldPassword
                              newPassword:(NSString *)_newPassword
                                  success:(void (^)(id responseObject))success
                                  failure:(void (^)(NSError *error))failure;


@end
