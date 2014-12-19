//
//  BZDefine.h
//  BZProject
//
//  Created by duwen on 14/12/11.
//  Copyright (c) 2014年 peterstudio. All rights reserved.
//

#ifndef BZProject_BZDefine_h
#define BZProject_BZDefine_h

#endif

//正则表达式
#define EMAIL_REGULAR_EXPRESSION @"^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$"
#define USER_REGULAR_EXPRESSION @"^[0-9A-Za-z_]{6,20}$"
#define PSW_REGULAR_EXPRESSION @"^[A-Za-z0-9_]{6,20}$"
#define PSW_REGULAR_FORLOGIN  @"^[^ ]{6,20}$"
#define MOBILE_REGULAR_EXPRESSION @"^[0-9]{11}$"
#define ZIP_REGULAR_EXPRESSION @"^[0-9]{0,6}$"
#define AUTHCODE_REGULAR_EXPRESSION @"^[0-9]{1,10}$"
#define POSTCODE_REGULAR_EXPRESSION @"^[0-9]{6}$"
//正整数
#define POSITIVE_NUMBER_REGULAR_EXPRESSION   @"^[0-9]*[1-9][0-9]*$"
//非负浮点数
#define POSITIVE_FLOAT_REGULAR_EXPRESSION   @"^\\d+(\\.\\d+)?$"

#define IDNUMBER_REGULAR_EXPRESSION  @"[0-9]{17}([0-9]|[xX])"


#define MD5KEY  @"YD6hRfv42pGPeZ2DVuMCDnZ56ko7Y3qvBY"

#define RETURN_CODE_SUCCESS                  @"0"     //成功
#define OTHER_ERROR_MESSAGE   @"请求失败，请稍后再试"
#define NONE_DATA_MESSAGE   @"很抱歉，暂无数据"
#define USER_NAME_KEY    @"com.peterstudio.ygb.username"
#define USER_PASSWORD_KEY    @"com.peterstudio.ygb.password"
#define USER_NAME_PASSWORD_KEY  @"com.peterstudio.ygb.usernamepassword"
#define USERINFO    @"USERINFO"
//#define LOGINSUCCESS    @"LOGINSUCCESS"
//#define REGISTSUCCESS   @"REGISTSUCCESS"

//当前设备屏幕高度
#define UIScreenHeight ([[UIScreen mainScreen] bounds].size.height)
#define UIScreenWidth  ([[UIScreen mainScreen] bounds].size.width)
#define RETINA4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
//系统版本
#define CURRENT_VERSION [[UIDevice currentDevice].systemVersion floatValue]
//颜色
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define RGB(a, b, c) [UIColor colorWithRed:(a / 255.0f) green:(b / 255.0f) blue:(c / 255.0f) alpha:1.0f]
#define RGBA(a, b, c, d) [UIColor colorWithRed:(a / 255.0f) green:(b / 255.0f) blue:(c / 255.0f) alpha:d]



/**************************接口**************************/

#define SERVER_URL  @"http://www.sunscoin.org/index.php/Api/"

// 语言验证码
#define HTTP_LanguageConfirmationCode_URL   [NSString stringWithFormat:@"%@mobverif",SERVER_URL]

// 用户注册
#define HTTP_UserRegist_URL   [NSString stringWithFormat:@"%@reg",SERVER_URL]

// 用户登录
#define HTTP_UserLogin_URL   [NSString stringWithFormat:@"%@login",SERVER_URL]

// 获取用户资金
#define HTTP_GetUserFunds_URL   [NSString stringWithFormat:@"%@funds",SERVER_URL]

// 设置用户资金
#define HTTP_SetUserFunds_URL   [NSString stringWithFormat:@"%@set_funds",SERVER_URL]

// 挖矿 
#define HTTP_Mining_URL   [NSString stringWithFormat:@"%@mining",SERVER_URL]

// 签到
#define HTTP_SignIn_URL     [NSString stringWithFormat:@"%@qd",SERVER_URL]

// 修改密码
#define HTTP_ChangePassword_URL     [NSString stringWithFormat:@"%@repass",SERVER_URL]

// 转账
#define HTTP_AccountTransfer_URL    [NSString stringWithFormat:@"%@pay",SERVER_URL]

// 版本更新
#define HTTP_VersionUpdate_URL  [NSString stringWithFormat:@"%@update",SERVER_URL]

// 免费获取算力
#define HTTP_FreeGetForce_URL   [NSString stringWithFormat:@"%@freeGetForce",SERVER_URL]

// 获取算力历史纪录
#define HTTP_FreeForceHistory_URL   [NSString stringWithFormat:@"%@getwakuan",SERVER_URL]














