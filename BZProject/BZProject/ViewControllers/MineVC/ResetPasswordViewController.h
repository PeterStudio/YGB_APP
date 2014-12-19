//
//  ResetPasswordViewController.h
//  BZProject
//
//  Created by duwen on 14/12/16.
//  Copyright (c) 2014年 peterstudio. All rights reserved.
//

#import "BZViewController.h"
#import "LoginModel.h"
@interface ResetPasswordViewController : BZViewControllerWithBackButton<UITextFieldDelegate>
@property (strong,nonatomic) dispatch_block_t resetPasswordButtonBlock;  // 重置密码成功事件

@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *passwordTFArray;






@end
