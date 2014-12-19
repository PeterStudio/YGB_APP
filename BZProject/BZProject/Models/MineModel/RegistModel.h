//
//  RegistModel.h
//  BZProject
//
//  Created by duwen on 14/12/15.
//  Copyright (c) 2014年 peterstudio. All rights reserved.
//

#import "BaseModel.h"

@interface RegistModel : BaseModel
@property(nonatomic,copy)NSString<Optional> * data;                     //返回data
@end


@interface ConfirmationCodeModel : BaseModel
@property(nonatomic,copy)NSString<Optional> * data;                     //返回data
@end