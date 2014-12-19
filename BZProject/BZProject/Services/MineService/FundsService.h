//
//  FundsService.h
//  BZProject
//
//  Created by duwen on 14/12/15.
//  Copyright (c) 2014年 peterstudio. All rights reserved.
//

#import "BaseService.h"

@interface FundsService : BaseService

/**
 *  获取用户资金
 *
 *  @param userId  用户ID
 *  @param success 成功回调
 *  @param failure 失败回调
 */
- (void)funds_Request_HTTP_UserID:(NSString *)userId
                          success:(void (^)(id responseObject))success
                          failure:(void (^)(NSError *error))failure;

@end
