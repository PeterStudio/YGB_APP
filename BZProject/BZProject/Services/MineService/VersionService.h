//
//  VersionService.h
//  BZProject
//
//  Created by duwen on 14/12/15.
//  Copyright (c) 2014年 peterstudio. All rights reserved.
//

#import "BaseService.h"

@interface VersionService : BaseService

/**
 *  版本更新
 *
 *  @param version 当前版本
 *  @param _type   1 安卓 2苹果
 *  @param _imei   设备唯一号
 *  @param success 成功回调
 *  @param failure 失败回调
 */
- (void)version_Request_HTTP_Version:(NSString *)version
                                type:(NSString *)_type
                                imei:(NSString *)_imei
                             success:(void (^)(id responseObject))success
                             failure:(void (^)(NSError *error))failure;

@end
