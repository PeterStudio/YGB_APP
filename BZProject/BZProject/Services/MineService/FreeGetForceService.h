//
//  FreeGetForceService.h
//  BZProject
//
//  Created by duwen on 14/12/18.
//  Copyright (c) 2014年 peterstudio. All rights reserved.
//

#import "BaseService.h"

@interface FreeGetForceService : BaseService

/**
 *  免费领取阳光宝
 *
 *  @param memberId 用户ID
 *  @param success  成功回调
 *  @param failure  失败回调
 */
- (void)freeGetForce_Request_HTTP_MemberID:(NSString *)memberId
                                   success:(void (^)(id responseObject))success
                                   failure:(void (^)(NSError *error))failure;

@end
