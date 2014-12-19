//
//  FreeForceHistoryModel.h
//  BZProject
//
//  Created by duwen on 14/12/19.
//  Copyright (c) 2014年 peterstudio. All rights reserved.
//

#import "BaseModel.h"

@protocol FreeForceHistoryDetailModel

@end

@interface FreeForceHistoryDetailModel : JSONModel
@property(nonatomic, copy)NSString<Optional> * id;
@property(nonatomic, copy)NSString<Optional> * ygb;
@property(nonatomic, copy)NSString<Optional> * sl;
@property(nonatomic, copy)NSString<Optional> * member_id;
@property(nonatomic, copy)NSString<Optional> * dwygb;
@property(nonatomic, copy)NSString<Optional> * zsl;
@property(nonatomic, copy)NSString<Optional> * time;
@end

@interface FreeForceHistoryModel : BaseModel
@property (nonatomic, copy)NSArray<FreeForceHistoryDetailModel,Optional> * data;
@end






















