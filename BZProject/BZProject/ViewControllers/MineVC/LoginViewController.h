//
//  LoginViewController.h
//  BZProject
//
//  Created by duwen on 14/12/10.
//  Copyright (c) 2014年 peterstudio. All rights reserved.
//

#import "BZViewController.h"

@interface LoginViewController : BZViewControllerWithBackButton<UITextFieldDelegate>

@property (strong,nonatomic) dispatch_block_t loginButtonBlock;  // 登录成功事件

@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;

@end
