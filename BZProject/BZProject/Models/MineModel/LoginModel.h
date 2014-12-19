//
//  LoginModel.h
//  BZProject
//
//  Created by duwen on 14/12/15.
//  Copyright (c) 2014年 peterstudio. All rights reserved.
//

#import "BaseModel.h"

@protocol LoginDetailModel

@end

@interface LoginDetailModel : JSONModel
@property(nonatomic,copy)NSString<Optional> * id;                       // 用户ID
@property(nonatomic,copy)NSString<Optional> * mob;                      // 登录名
@property(nonatomic,copy)NSString<Optional> * user_pass;                // Md5后的登录密码
@property(nonatomic,copy)NSString<Optional> * safe_pass;                // Md5后的资金获取密码
@property(nonatomic,copy)NSString<Optional> * nick_name;                //  昵称
@property(nonatomic,copy)NSString<Optional> * isSign;                   // 今天是否签到 0 未签到 1 已经签到
@property(nonatomic,copy)NSString<Optional> * signdate;                 // 签到日期
@end

@interface LoginModel : BaseModel
@property(nonatomic,strong)LoginDetailModel * data;                     // 用户数据

@end
