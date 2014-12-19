//
//  PersonalInformationViewController.m
//  BZProject
//
//  Created by duwen on 14/12/13.
//  Copyright (c) 2014 peterstudio. All rights reserved.
//

#import "PersonalInformationViewController.h"
#import "LoginManager.h"
@interface PersonalInformationViewController ()
@end

@implementation PersonalInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view setBackgroundColor:UIColorFromRGB(0xf5f5f5)];
    
    
    
//    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showView)];
//    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
//    tapGestureRecognizer.cancelsTouchesInView = NO;
//    //将触摸事件添加到当前view
//    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    LoginDetailModel * loginModel = [[LoginManager shareInstance] loginAccountInfo];
    _nickNameTF.text = loginModel.nick_name;
    _nameTF.text = loginModel.mob;
}

//- (void)showView{
//    [_nickNameTF resignFirstResponder];
//    [_nameTF resignFirstResponder];
//}

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
