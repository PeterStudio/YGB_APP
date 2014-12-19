//
//  MiningService.h
//  BZProject
//
//  Created by duwen on 14/12/15.
//  Copyright (c) 2014年 peterstudio. All rights reserved.
//

#import "BaseService.h"

@interface MiningService : BaseService

/**
 *  挖矿
 *
 *  @param userId  用户ID
 *  @param _type   0 开始挖矿 1 停止挖矿
 *  @param success 成功回调
 *  @param failure 失败回调
 */
- (void)mining_Request_HTTP_UserID:(NSString *)userId
                              type:(NSString *)_type
                           success:(void (^)(id responseObject))success
                           failure:(void (^)(NSError *error))failure;

@end
