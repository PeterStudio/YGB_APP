//
//  AccountTransferService.h
//  BZProject
//
//  Created by duwen on 14/12/15.
//  Copyright (c) 2014年 peterstudio. All rights reserved.
//

#import "BaseService.h"

@interface AccountTransferService : BaseService


/**
 *  阳光宝转账
 *
 *  @param _memberId 用户ID
 *  @param _address  转账地址
 *  @param _funds    金额
 *  @param _types    0 及时到账 1担保交易
 *  @param success   成功回调
 *  @param failure   失败回调
 */
- (void)accountTransfer_Request_HTTP_memberID:(NSString *)_memberId
                                      address:(NSString *)_address
                                        funds:(NSString *)_funds
                                        types:(NSString *)_types
                                      success:(void (^)(id responseObject))success
                                      failure:(void (^)(NSError *error))failure;

@end
