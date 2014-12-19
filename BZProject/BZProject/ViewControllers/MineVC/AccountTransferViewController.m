//
//  AccountTransferViewController.m
//  BZProject
//
//  Created by duwen on 14/12/15.
//  Copyright (c) 2014年 peterstudio. All rights reserved.
//

#import "AccountTransferViewController.h"
#import "SVProgressHUD.h"
#import "RegexKitLite.h"
#import "RegistService.h"
#import "RegistModel.h"
#import "AccountTransferService.h"
#import "LoginManager.h"
#import "LoginModel.h"
@interface AccountTransferViewController ()
{
     NSString * verifStr;
}
@property (nonatomic, strong) RegistService * registService;
@property (nonatomic, strong) AccountTransferService * accountTransferService;
@end

@implementation AccountTransferViewController

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.registService = [[RegistService alloc] init];
    self.accountTransferService = [[AccountTransferService alloc] init];
    verifStr = nil;
    
    NSString *conentStr = @"当前可转账阳光宝总数<font color='#FF0000'>0</font>个";
    _infoLabel.text =  conentStr;
    _infoLabel.font = [UIFont systemFontOfSize:13.0f];
}


- (IBAction)confirmationCodeRequest:(id)sender {
    UITextField * phoneTF = (UITextField *)_accountTransTFArray[0];
    if (![phoneTF.text isMatchedByRegex:MOBILE_REGULAR_EXPRESSION]) {
        // 未输入账号
        [SVProgressHUD showErrorWithStatus:@"请输入11位手机号码"];
        return;
    }
    
    [SVProgressHUD showWithStatus:@"加载中" maskType:SVProgressHUDMaskTypeClear];
    [self.registService confirmationCode_Request_HTTP_PhoneNum:phoneTF.text success:^(id responseObject) {
        [SVProgressHUD dismiss];
        ConfirmationCodeModel * confirmationCodeModel = (ConfirmationCodeModel *)responseObject;
        if ([RETURN_CODE_SUCCESS isEqualToString:confirmationCodeModel.status]) {
            verifStr = confirmationCodeModel.data;
            //            [SVProgressHUD showErrorWithStatus:confirmationCodeModel.info];
        }
        //        else{
        [SVProgressHUD showErrorWithStatus:confirmationCodeModel.info];
        //        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showSuccessWithStatus:OTHER_ERROR_MESSAGE];
    }];
}


- (IBAction)transferButtonSelected:(id)sender {
    UITextField * tf1 = (UITextField *)_accountTransTFArray[0];
    NSString * tf1Str = [tf1.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (![tf1Str isMatchedByRegex:MOBILE_REGULAR_EXPRESSION]) {
        // 未输入账号
        [SVProgressHUD showErrorWithStatus:@"请输入11位手机号码"];
        return;
    }
    
    UITextField * tf2 = (UITextField *)_accountTransTFArray[1];
    NSString * tf2Str = [tf2.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([@"" isEqualToString:tf2Str]) {
        // 未输入账号
        [SVProgressHUD showErrorWithStatus:@"请输入对方的阳光宝id"];
        return;
    }
    
    UITextField * tf3 = (UITextField *)_accountTransTFArray[2];
    NSString * tf3Str = [tf3.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([@"" isEqualToString:tf3Str]) {
        // 未输入账号
        [SVProgressHUD showErrorWithStatus:@"请输入要转换的阳光宝数量"];
        return;
    }
    
    UITextField * tf4 = (UITextField *)_accountTransTFArray[3];
    NSString * tf4Str = [tf4.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (!verifStr || ![verifStr isEqualToString:tf4Str]) {
        // 验证码输入错误
        [SVProgressHUD showErrorWithStatus:@"验证码输入错误"];
        return;
    }
    
    LoginDetailModel * loginModel = [[LoginManager shareInstance] loginAccountInfo];
    [self.accountTransferService accountTransfer_Request_HTTP_memberID:loginModel.id address:tf2Str funds:tf3Str types:@"0" success:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == _accountTransTFArray[0]) {
        [_accountTransTFArray[1] becomeFirstResponder];
    }
    else if (textField == _accountTransTFArray[1]){
        [_accountTransTFArray[2] becomeFirstResponder];
    }
    else if (textField == _accountTransTFArray[2]){
        [_accountTransTFArray[3] becomeFirstResponder];
    }
    else{
        [_accountTransTFArray[3] resignFirstResponder];
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
