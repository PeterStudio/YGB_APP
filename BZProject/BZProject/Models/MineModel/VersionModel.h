//
//  VersionModel.h
//  BZProject
//
//  Created by duwen on 14/12/15.
//  Copyright (c) 2014年 peterstudio. All rights reserved.
//

#import "BaseModel.h"

@interface VersionModel : BaseModel
@property(nonatomic,copy)NSString<Optional> * content;                     // 更新内容
@property(nonatomic,copy)NSString<Optional> * urlAddress;                  // 下载地址
@property(nonatomic,copy)NSString<Optional> * version;                     // 最新版本
@end
