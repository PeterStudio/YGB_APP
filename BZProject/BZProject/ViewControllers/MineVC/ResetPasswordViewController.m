//
//  ResetPasswordViewController.m
//  BZProject
//
//  Created by duwen on 14/12/16.
//  Copyright (c) 2014年 peterstudio. All rights reserved.
//

#import "ResetPasswordViewController.h"
#import "RegexKitLite.h"
#import "SVProgressHUD.h"
#import "ResetPasswordService.h"
#import "ResetPasswordModel.h"
#import "LoginManager.h"
@interface ResetPasswordViewController ()
@property (nonatomic, strong) ResetPasswordService * resetPasswordService;
@end

@implementation ResetPasswordViewController

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.resetPasswordService = [[ResetPasswordService alloc] init];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

- (void)hideKeyboard{
    for (UITextField * tf in _passwordTFArray) {
        [tf resignFirstResponder];
    }
}

- (IBAction)submitButtonSelected:(id)sender {
    [self hideKeyboard];
    UITextField * tf1 = (UITextField *)_passwordTFArray[0];
    if(![tf1.text isMatchedByRegex:PSW_REGULAR_EXPRESSION])
    {
        // 密码不对
        [SVProgressHUD showErrorWithStatus:@"旧密码是6-20位数字字母下划线"];
        return;
    }
    
    UITextField * tf2 = (UITextField *)_passwordTFArray[1];
    if(![tf2.text isMatchedByRegex:PSW_REGULAR_EXPRESSION])
    {
        // 密码不对
        [SVProgressHUD showErrorWithStatus:@"新密码是6-20位数字字母下划线"];
        return;
    }
    
    UITextField * tf3 = (UITextField *)_passwordTFArray[2];
    if (![tf2.text isEqualToString:tf3.text]) {
        // 确认密码与输入密码不一致
        [SVProgressHUD showErrorWithStatus:@"确认密码与新密码不一致"];
        return;
    }
    
    LoginDetailModel * loginModel = [[LoginManager shareInstance] loginAccountInfo];
    [SVProgressHUD showWithStatus:@"加载中" maskType:SVProgressHUDMaskTypeGradient];
    [self.resetPasswordService resetPassword_Request_HTTP_UserID:loginModel.id oldPassword:tf1.text newPassword:tf2.text success:^(id responseObject) {
        [SVProgressHUD dismiss];
        ResetPasswordModel * resetPasswordModel = (ResetPasswordModel *)responseObject;
        [SVProgressHUD showErrorWithStatus:resetPasswordModel.info];
        if ([RETURN_CODE_SUCCESS isEqualToString:resetPasswordModel.status]) {
            if (self.resetPasswordButtonBlock) {
                self.resetPasswordButtonBlock();
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:OTHER_ERROR_MESSAGE];
    }];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == _passwordTFArray[0]) {
        [_passwordTFArray[1] becomeFirstResponder];
    }
    else if (textField == _passwordTFArray[1]){
        [_passwordTFArray[2] becomeFirstResponder];
    }
    else{
        [_passwordTFArray[3] resignFirstResponder];
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
