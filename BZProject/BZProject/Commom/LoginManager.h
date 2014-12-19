//
//  LoginManager.h
//  BZProject
//
//  Created by duwen on 14/12/15.
//  Copyright (c) 2014年 peterstudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginModel.h"
@interface LoginManager : NSObject
@property (nonatomic, strong) LoginDetailModel    *loginAccountInfo;       // 登录账户信息
//@property (nonatomic, assign) BOOL isLogin;

/**
 *  单例接口
 *
 *  @return 用户信息
 */
+ (LoginManager *)shareInstance;

/**
 *  注册成功之后保存用户信息
 *
 *  @param accountInfo 用户信息
 */
-(void)saveAccountInfo:(LoginDetailModel *)accountInfo;

/**
 *  注销清空用户数据
 */
//- (void)resetAccountInfo;
/**
 *  获取用户数据
 *
 *  @return 
 */
- (LoginDetailModel *)loginAccountInfo;




/**
 *  是否登录状态
 */
- (BOOL)isExistCurrentUser;

- (void)saveUsername:(NSString *)_username password:(NSString *)_password;

- (void)deletePassword;

- (NSString *)username;

- (NSString *)password;



@end
