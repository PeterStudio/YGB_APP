//
//  RegistViewController.m
//  BZProject
//
//  Created by duwen on 14/12/13.
//  Copyright (c) 2014年 peterstudio. All rights reserved.
//

#import "RegistViewController.h"
#import "SVProgressHUD.h"
#import "RegexKitLite.h"
//#import "AFHTTPRequestOperationManager.h"
#import "NSString+MD5Addition.h"
#import "RegistService.h"
#import "RegistModel.h"
#import "UIDevice+IdentifierAddition.h"

#import "LoginManager.h"
#import "LoginService.h"
#import "LoginModel.h"
@interface RegistViewController ()
{
    NSString * verifStr;
}
@property (nonatomic, strong)LoginService * loginService;
@property (nonatomic, strong)RegistService * registService;
@end

@implementation RegistViewController

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    verifStr = nil;
    self.loginService = [[LoginService alloc] init];
    self.registService = [[RegistService alloc] init];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

- (void)hideKeyboard{
    for (UITextField * textfield in _textFieldArray) {
        [textfield resignFirstResponder];
    }
}

/**
 *  获取验证码
 *
 *  @param sender
 */
- (IBAction)confirmationCodeRequest:(id)sender {
    [self hideKeyboard];
    UITextField * phoneTF = (UITextField *)_textFieldArray[0];
    if (![phoneTF.text isMatchedByRegex:MOBILE_REGULAR_EXPRESSION]) {
        // 未输入账号
        [SVProgressHUD showErrorWithStatus:@"请输入11位手机号码"];
        return;
    }
    
    [SVProgressHUD showWithStatus:@"加载中" maskType:SVProgressHUDMaskTypeGradient];
    [self.registService confirmationCode_Request_HTTP_PhoneNum:phoneTF.text success:^(id responseObject) {
        [SVProgressHUD dismiss];
        ConfirmationCodeModel * confirmationCodeModel = (ConfirmationCodeModel *)responseObject;
        if ([RETURN_CODE_SUCCESS isEqualToString:confirmationCodeModel.status]) {
            verifStr = confirmationCodeModel.data;
        }
        [SVProgressHUD showErrorWithStatus:confirmationCodeModel.info];
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showSuccessWithStatus:OTHER_ERROR_MESSAGE];
    }];
}

/**
 *  注册
 *
 *  @param sender
 */
- (IBAction)registButtonSelected:(id)sender {
    [self hideKeyboard];
    UITextField * phoneTF = (UITextField *)_textFieldArray[0];
    if (![phoneTF.text isMatchedByRegex:MOBILE_REGULAR_EXPRESSION]) {
        // 未输入账号
        [SVProgressHUD showErrorWithStatus:@"请输入11位手机号码"];
        return;
    }
    
    UITextField * passWord1TF = (UITextField *)_textFieldArray[1];
    if(![passWord1TF.text isMatchedByRegex:PSW_REGULAR_EXPRESSION])
    {
        // 密码不对
        [SVProgressHUD showErrorWithStatus:@"密码是6-20位数字字母下划线"];
        return;
    }
    
    UITextField * passWord2TF = (UITextField *)_textFieldArray[2];
    if (![passWord1TF.text isEqualToString:passWord2TF.text]) {
        // 确认密码与输入密码不一致
        [SVProgressHUD showErrorWithStatus:@"确认密码与输入密码不一致"];
        return;
    }
    
    UITextField * confirmationCodeTF = (UITextField *)_textFieldArray[3];
    if (!verifStr || ![verifStr isEqualToString:confirmationCodeTF.text]) {
        // 验证码输入错误
        [SVProgressHUD showErrorWithStatus:@"验证码输入错误"];
        return;
    }
    
    
    [SVProgressHUD showWithStatus:@"加载中" maskType:SVProgressHUDMaskTypeGradient];
    UITextField * recommendIDTF = (UITextField *)[_textFieldArray lastObject];

    //设备号
    NSString *imeiStr = [[UIDevice currentDevice] myGlobalDeviceId];
    
    [self.registService regist_Request_HTTP_PhoneNum:phoneTF.text password:passWord1TF.text recommendID:recommendIDTF.text imei:imeiStr success:^(id responseObject) {
        RegistModel * registModel = (RegistModel *)responseObject;
        if ([RETURN_CODE_SUCCESS isEqualToString:registModel.status]) {
            [self autoLogin];
        }else{
            [SVProgressHUD dismiss];
            [SVProgressHUD showErrorWithStatus:registModel.info];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:OTHER_ERROR_MESSAGE];
    }];
}

/**
 *  注册成功后自动登录
 */
- (void)autoLogin{
    UITextField * phoneTF = (UITextField *)_textFieldArray[0];
    UITextField * passWord1TF = (UITextField *)_textFieldArray[1];
    //版本号
    NSString *curVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    if (!curVersion) {
        curVersion=@"";
    }
    //设备号
    NSString *imeiStr = [[UIDevice currentDevice] myGlobalDeviceId];
    [self.loginService login_Request_HTTP_UserName:phoneTF.text password:passWord1TF.text system:@"ios" version:curVersion imei:imeiStr success:^(id responseObject) {
        [SVProgressHUD dismiss];
        LoginModel * loginModel = (LoginModel *)responseObject;
        [[LoginManager shareInstance] saveUsername:phoneTF.text password:passWord1TF.text];
        if ([RETURN_CODE_SUCCESS isEqualToString:loginModel.status]) {
            [SVProgressHUD showErrorWithStatus:loginModel.info];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:@"注册成功!"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [self.navigationController popViewControllerAnimated:YES];
        [SVProgressHUD showErrorWithStatus:OTHER_ERROR_MESSAGE];
    }];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == _textFieldArray[0]) {
        [_textFieldArray[1] becomeFirstResponder];
    }
    else if (textField == _textFieldArray[1]){
        [_textFieldArray[2] becomeFirstResponder];
    }
    else if (textField == _textFieldArray[2]){
        [_textFieldArray[3] becomeFirstResponder];
    }
    else if (textField == _textFieldArray[3]){
        [_textFieldArray[4] becomeFirstResponder];
    }
    else{
        [_textFieldArray[4] resignFirstResponder];
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
