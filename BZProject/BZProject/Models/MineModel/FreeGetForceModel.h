//
//  FreeGetForceModel.h
//  BZProject
//
//  Created by duwen on 14/12/18.
//  Copyright (c) 2014年 peterstudio. All rights reserved.
//

#import "BaseModel.h"

@protocol FreeGetForceDetailModel

@end

@interface FreeGetForceDetailModel : JSONModel
@property(nonatomic,copy)NSString<Optional> * pow;          // 个人算力
@property(nonatomic,copy)NSString<Optional> * ygb;         // 阳光宝
@property(nonatomic,copy)NSString<Optional> * total_pow;          // 总算力
@property(nonatomic,copy)NSString<Optional> * total_ygb;          // 总算阳光宝
@end

@interface FreeGetForceModel : BaseModel
@property(nonatomic,copy)FreeGetForceDetailModel<Optional> * data;                     // 用户数据
@end
