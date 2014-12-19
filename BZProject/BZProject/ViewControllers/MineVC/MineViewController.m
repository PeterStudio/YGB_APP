//
//  MineViewController.m
//  BZProject
//
//  Created by duwen on 14/12/11.
//  Copyright (c) 2014 peterstudio. All rights reserved.
//

#import "MineViewController.h"
#import "LoginViewController.h"
#import "CalculatesUnitViewController.h"
#import "MiningViewController.h"
#import "AccountTransferViewController.h"
#import "PersonalInformationViewController.h"
#import "ResetPasswordViewController.h"
#import "SVProgressHUD.h"
#import "LoginManager.h"
#import "LoginModel.h"
#import "SignInService.h"
#import "SignInModel.h"
#import "FundsService.h"
#import "UserFundsModel.h"
#import "MiningService.h"
#import "MiningModel.h"

#define FOURBUTTONSPACE (UIScreenWidth - 48 * 4) / 5
#define FirstLabelHeightConstraint  50.0f
@interface MineViewController ()
{
    NSString * signInStr;
}
@property (nonatomic, strong) LoginDetailModel * loginDetailModel;
@property (nonatomic, strong) UserFundsDetailModel * uFundsDetailModel;
@property (nonatomic, strong) SignInService * signInService;
@property (nonatomic, strong) FundsService  * fundsService;
@property (nonatomic, strong) MiningService * miningService;
@end

@implementation MineViewController

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self config];
}

- (void)config{
    _firstLabel.hidden = NO;
    if ([[LoginManager shareInstance] isExistCurrentUser]) {
        self.loginDetailModel = [[LoginManager shareInstance] loginAccountInfo];
        signInStr = [@"1" isEqualToString:self.loginDetailModel.isSign]?self.loginDetailModel.isSign:@"0";
        _firstLabel.text = [NSString stringWithFormat:@"注册ID:%@",self.loginDetailModel.id];
        _secondLabel.hidden = NO;
        _thirdLabel.hidden = NO;
        _fourLabel.hidden = NO;
        _exitButtonView.hidden = NO;
        _footLineImageView.hidden = YES;
        _loginButtonView.hidden = YES;
        _firstLabelTopConstraint.constant = 30.0f;
        if ([@"1" isEqualToString:signInStr]) {
            _signInLabel.text = @"已签到";
        }else{
            _signInLabel.text = @"签到";
        }
        [self fundsInfo];
        _payMoneyView.hidden = NO;
    }else{
        _firstLabel.text = @"您还没有登录！";
        _secondLabel.text = @"我的阳光宝:";
        _secondLabel.hidden = YES;
        _thirdLabel.text = @"我的签到阳光宝:";
        _thirdLabel.hidden = YES;
        _fourLabel.text = @"我的人名币:";
        _fourLabel.hidden = YES;
        _exitButtonView.hidden  = YES;
        _footLineImageView.hidden = NO;
        _loginButtonView.hidden = NO;
        _firstLabelTopConstraint.constant = FirstLabelHeightConstraint;
        _signInLabel.text = @"签到";
        _payMoneyView.hidden = YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view setBackgroundColor:UIColorFromRGB(0xeeeeee)];
    for (int i = 0; i < 4; i++) {
        NSLayoutConstraint * constraint = (NSLayoutConstraint *)_fourButtonSpaceConstraint[i];
        constraint.constant = FOURBUTTONSPACE;
    }
    self.signInService = [[SignInService alloc] init];
    self.fundsService = [[FundsService alloc] init];

    if (![[LoginManager shareInstance] isExistCurrentUser]) {
        [self showLoginAlertView];
    }
    
    NSTimer *myTimer = [NSTimer timerWithTimeInterval:300.0 target:self selector:@selector(fundsInfo) userInfo:nil repeats:YES];
    [[NSRunLoop  currentRunLoop] addTimer:myTimer forMode:NSDefaultRunLoopMode];
    
}

- (IBAction)buttonSelected:(id)sender {
    UIButton * btn = (UIButton *)sender;
    switch (btn.tag) {
        case 0:
            // 登录
            [self userLogin];
            break;
        case 1:
            // 签到
        {
            if (![[LoginManager shareInstance] isExistCurrentUser]){
                [self showLoginAlertView];
                return;
            }
            
            if ([@"1" isEqualToString:signInStr]) {
                [SVProgressHUD showErrorWithStatus:@"已签到"];
                return;
            }
            
            [self.signInService signIn_Request_HTTP_memberID:self.loginDetailModel.id success:^(id responseObject) {
                SignInModel * signInModel = (SignInModel *)responseObject;
                if ([RETURN_CODE_SUCCESS isEqualToString:signInModel.status]) {
                    signInStr = @"1";
                    _signInLabel.text = @"已签到";
                    [SVProgressHUD showSuccessWithStatus:signInModel.info];
                }else{
                    signInStr = @"0";
                    [SVProgressHUD showErrorWithStatus:signInModel.info];
                }
            } failure:^(NSError *error) {
                signInStr = @"0";
                [SVProgressHUD showErrorWithStatus:OTHER_ERROR_MESSAGE];
            }];
        }
            break;
        case 2:
            // 购买算力
        {
            [SVProgressHUD showErrorWithStatus:@"正在开发中..."];
            
//            if (![[LoginManager shareInstance] isExistCurrentUser]){
//                [self showLoginAlertView];
//                return;
//            }
//            CalculatesUnitViewController * vc = [[CalculatesUnitViewController alloc] init];
//            vc.title = @"购买算力";
//            vc.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
            // 阳光宝转账
        {
            if (![[LoginManager shareInstance] isExistCurrentUser]){
                [self showLoginAlertView];
                return;
            }
            AccountTransferViewController * vc = [[AccountTransferViewController alloc] init];
            vc.title = @"阳光宝转帐";
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:
            // 挖矿
        {
            if (![[LoginManager shareInstance] isExistCurrentUser]){
                [self showLoginAlertView];
                return;
            }
            MiningViewController * vc = [[MiningViewController alloc] init];
            vc.title = @"挖矿";
            vc.hidesBottomBarWhenPushed = YES;
            vc.fundsModel = _uFundsDetailModel;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 5:
            // 个人信息
        {
            if (![[LoginManager shareInstance] isExistCurrentUser]){
                [self showLoginAlertView];
                return;
            }
            PersonalInformationViewController * vc = [[PersonalInformationViewController alloc] init];
            vc.title = @"个人信息";
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 6:
            // 修改密码
        {
            if (![[LoginManager shareInstance] isExistCurrentUser]){
                [self showLoginAlertView];
                return;
            }
            ResetPasswordViewController * vc = [[ResetPasswordViewController alloc] init];
            vc.title = @"修改密码";
            vc.hidesBottomBarWhenPushed = YES;
            vc.resetPasswordButtonBlock = ^{
                [self stopMining];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 7:
            // 退出登录
        {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"注销登录" message:@"确认注销登录吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
            alert.tag = 100;
            [alert show];
        }
            break;
        default:
            break;
    }

}


/**
 *  用户登录
 */
- (void)userLogin{
    LoginViewController * vc = [[LoginViewController alloc] init];
    vc.title = @"登录";
    vc.hidesBottomBarWhenPushed = YES;
    vc.loginButtonBlock = ^{
        _firstLabel.text = [NSString stringWithFormat:@"注册ID:%@",self.loginDetailModel.id];
        _loginButtonView.hidden = YES;
        _exitButtonView.hidden = NO;
        _footLineImageView.hidden = YES;
        _firstLabelTopConstraint.constant = 30.0f;
        [self fundsInfo];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

/**
 *  用户资金
 */
- (void)fundsInfo{
    LoginDetailModel * loginModel = [[LoginManager shareInstance] loginAccountInfo];
    [SVProgressHUD showWithStatus:@"加载中" maskType:SVProgressHUDMaskTypeGradient];
    [self.fundsService funds_Request_HTTP_UserID:loginModel.id success:^(id responseObject) {
        [SVProgressHUD dismiss];
        UserFundsModel * userFundsModel = (UserFundsModel *)responseObject;
        if ([RETURN_CODE_SUCCESS isEqualToString:userFundsModel.status]) {
            _uFundsDetailModel = (UserFundsDetailModel *)userFundsModel.data;
            _secondLabel.text = [NSString stringWithFormat:@"我的阳光宝:%@",_uFundsDetailModel.ygb];
            _thirdLabel.text = [NSString stringWithFormat:@"我的签到阳光宝:%@(总人数%@)",_uFundsDetailModel.mySignYgb,_uFundsDetailModel.signNumber];
            _fourLabel.text = [NSString stringWithFormat:@"我的人名币:%@",_uFundsDetailModel.cny];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"UPDATEUSERFUNDS" object:_uFundsDetailModel];
        }else{
            [SVProgressHUD showErrorWithStatus:userFundsModel.info];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:OTHER_ERROR_MESSAGE];
    }];
}

/**
 *  停止挖矿
 */
- (void)stopMining{
    if (!self.miningService) {
        self.miningService = [[MiningService alloc] init];
    }
    [SVProgressHUD showWithStatus:@"加载中" maskType:SVProgressHUDMaskTypeGradient];
    [self.miningService mining_Request_HTTP_UserID:_loginDetailModel.id type:@"1" success:^(id responseObject) {
        [SVProgressHUD dismiss];
        MiningModel * miningModel = (MiningModel *)responseObject;
        [SVProgressHUD showErrorWithStatus:miningModel.info];
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:OTHER_ERROR_MESSAGE];
    }];
}

/**
 *  充值
 *
 *  @param sender
 */
- (IBAction)addMoneyButtonSelected:(id)sender {
    [SVProgressHUD showErrorWithStatus:@"正在开发中..."];
}

/**
 *  提现
 *
 *  @param sender
 */
- (IBAction)gotMoneyButtonSelected:(id)sender {
    [SVProgressHUD showErrorWithStatus:@"正在开发中..."];
}


- (void)showLoginAlertView{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"尚未登录，是否现在登录？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登录", nil];
    alert.tag = 99;
    [alert show];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 100) {
        // 注销登录
        if (buttonIndex == 1) {
            // 注销
            [self stopMining];
            [[LoginManager shareInstance] deletePassword];
            [self config];
        }
    }else{
        // 未登录弹框
        if (buttonIndex == 1) {
            // 去登录
            [self userLogin];
        }
    }
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
