//
//  UserFoundsModel.h
//  BZProject
//
//  Created by duwen on 14/12/15.
//  Copyright (c) 2014年 peterstudio. All rights reserved.
//

#import "BaseModel.h"

@protocol UserFundsDetailModel

@end

@interface UserFundsDetailModel : JSONModel
@property(nonatomic,copy)NSString<Optional> * ssc;          // 阳光币
@property(nonatomic,copy)NSString<Optional> * ygcx;         // 诚心币
@property(nonatomic,copy)NSString<Optional> * ygq;          // 阳光权
@property(nonatomic,copy)NSString<Optional> * ygb;          // 阳光宝
@property(nonatomic,copy)NSString<Optional> * cny;          // 人名币
@property(nonatomic,copy)NSString<Optional> * pow;          // 个人算力
@property(nonatomic,copy)NSString<Optional> * total_pow;    // 总算力
@property(nonatomic,copy)NSString<Optional> * total_ygb;    // 总算阳光宝
@property(nonatomic,copy)NSString<Optional> * signNumber;   // 昨天签到总人数
@property(nonatomic,copy)NSString<Optional> * mySignYgb;    // 昨天我签到分配到的阳光包数量
@end

@interface UserFundsModel : BaseModel
@property(nonatomic,copy)UserFundsDetailModel<Optional> * data;                     // 用户数据
@end
