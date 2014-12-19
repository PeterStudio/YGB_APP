//
//  SiginService.h
//  BZProject
//
//  Created by duwen on 14/12/15.
//  Copyright (c) 2014年 peterstudio. All rights reserved.
//

#import "BaseService.h"

@interface SignInService : BaseService

/**
 *  签到
 *
 *  @param memberId 用户ID
 *  @param success  成功回调
 *  @param failure  失败回调
 */
- (void)signIn_Request_HTTP_memberID:(NSString *)memberId
                             success:(void (^)(id responseObject))success
                             failure:(void (^)(NSError *error))failure;

@end
