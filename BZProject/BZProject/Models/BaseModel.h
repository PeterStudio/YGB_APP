//
//  BaseModel.h
//  BZProject
//
//  Created by duwen on 14/12/15.
//  Copyright (c) 2014年 peterstudio. All rights reserved.
//

#import "JSONModel.h"

@interface BaseModel : JSONModel
@property(nonatomic,copy)NSString<Optional> *status;                     //返回code
@property(nonatomic,copy)NSString<Optional> *info;                     //返回信息
@end
