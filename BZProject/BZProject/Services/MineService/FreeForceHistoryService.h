//
//  FreeForceHistoryService.h
//  BZProject
//
//  Created by duwen on 14/12/19.
//  Copyright (c) 2014年 peterstudio. All rights reserved.
//

#import "BaseService.h"

@interface FreeForceHistoryService : BaseService

/**
 *  获取算力历史纪录
 *
 *  @param memberId 用户ID
 *  @param success  成功回掉
 *  @param failure  失败回调
 */
- (void)freeForceHistory_Request_HTTP_MemberID:(NSString *)memberId
                                       success:(void (^)(id responseObject))success
                                       failure:(void (^)(NSError *error))failure;
@end
