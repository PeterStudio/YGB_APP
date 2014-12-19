//
//  LoginViewController.m
//  BZProject
//
//  Created by duwen on 14/12/10.
//  Copyright (c) 2014 peterstudio. All rights reserved.
//

#import "LoginViewController.h"
#import "BZDefine.h"
#import "RegistViewController.h"
#import "SVProgressHUD.h"
#import "RegexKitLite.h"
#import "AFHTTPRequestOperationManager.h"
#import "NSString+MD5Addition.h"
#import "LoginService.h"
#import "LoginModel.h"
#import "UIDevice+IdentifierAddition.h"
#import "LoginModel.h"
#import "LoginManager.h"
@interface LoginViewController ()
@property (strong, nonatomic) LoginService * loginService;
@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    LoginDetailModel * loginModel = [[LoginManager shareInstance] loginAccountInfo];
    if (loginModel.mob&&![@"" isEqualToString:loginModel.mob]) {
        _accountTF.text = loginModel.mob;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view setBackgroundColor:UIColorFromRGB(0xf5f5f5)];
    
    [self setRightBarButtonItem];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    self.loginService = [[LoginService alloc] init];
    
    
}

- (void)hideKeyboard{
    [_accountTF resignFirstResponder];
    [_passwordTF resignFirstResponder];
}

/**
 *  设置导航栏右注册按钮
 */
- (void)setRightBarButtonItem
{
    UIButton *editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    if (CURRENT_VERSION < 7.0) {
        [editButton setFrame:CGRectMake(0, 0, 40 + 22, 20)];
    } else {
        [editButton setFrame:CGRectMake(0, 0, 40, 20)];
    }
    [editButton setTitle:@"注册" forState:UIControlStateNormal];
    [editButton setTitle:@"注册" forState:UIControlStateHighlighted];
    [editButton setTitleColor:UIColorFromRGB(0xe1190b) forState:UIControlStateNormal];
    [editButton setTitleColor:UIColorFromRGB(0xcc170a) forState:UIControlStateHighlighted];
    editButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [editButton addTarget:self action:@selector(registVC) forControlEvents:UIControlEventTouchUpInside];
//    editButton.tag = 1000;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:editButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}

/**
 *  注册跳转
 */
- (void)registVC{
    RegistViewController * vc = [[RegistViewController alloc] init];
    vc.title = @"阳光宝注册";
    vc.hidesBottomBarWhenPushed = YES;
//    vc.registButtonBlock = ^{
//    };
    [self.navigationController pushViewController:vc animated:YES];
}

/**
 *  注册成功
 *
 *  @param ntif
 */
- (void)registSuccess:(NSNotification *)ntif{
    [SVProgressHUD showSuccessWithStatus:ntif.object];
}


- (IBAction)loginButtonSelected:(id)sender {
    [self hideKeyboard];
    
    NSString * accountStr = [_accountTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (![accountStr isMatchedByRegex:MOBILE_REGULAR_EXPRESSION]) {
        // 未输入账号
        [SVProgressHUD showErrorWithStatus:@"请输入11位手机号码"];
        return;
    }
    
    if(![_passwordTF.text isMatchedByRegex:PSW_REGULAR_EXPRESSION])
    {
        // 密码不对
        [SVProgressHUD showErrorWithStatus:@"密码是6-20位数字字母下划线"];
        return;
    }
    
    //版本号
    NSString *curVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    if (!curVersion) {
        curVersion=@"";
    }
    //设备号
    NSString *imeiStr = [[UIDevice currentDevice] myGlobalDeviceId];
    [SVProgressHUD showWithStatus:@"加载中" maskType:SVProgressHUDMaskTypeGradient];
    [self.loginService login_Request_HTTP_UserName:accountStr password:_passwordTF.text system:@"ios" version:curVersion imei:imeiStr success:^(id responseObject) {
        [SVProgressHUD dismiss];
        LoginModel * loginModel = (LoginModel *)responseObject;
        [SVProgressHUD showErrorWithStatus:loginModel.info];
        if ([RETURN_CODE_SUCCESS isEqualToString:loginModel.status]) {
            [[LoginManager shareInstance] saveUsername:accountStr password:_passwordTF.text];
            if (self.loginButtonBlock) {
                self.loginButtonBlock();
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
    if (textField == _accountTF) {
        [_passwordTF becomeFirstResponder];
    }else{
        [self hideKeyboard];
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
