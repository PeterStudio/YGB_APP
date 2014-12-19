//
//  CalculatesUnitViewController.m
//  BZProject
//
//  Created by duwen on 14/12/13.
//  Copyright (c) 2014年 peterstudio. All rights reserved.
//

#import "CalculatesUnitViewController.h"

@interface CalculatesUnitViewController ()

@end

@implementation CalculatesUnitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view setBackgroundColor:UIColorFromRGB(0xf5f5f5)];
    
    _buyNumTF.layer.masksToBounds = YES;
    _buyNumTF.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _buyNumTF.layer.borderWidth = 1.0f;
    
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

- (void)hideKeyBoard{
    [_buyNumTF resignFirstResponder];
}

- (IBAction)upButtonSelected:(id)sender {
    int num = [_buyNumTF.text intValue];
    _buyNumTF.text = [NSString stringWithFormat:@"%d",++num];
}

- (IBAction)downButtonSelected:(id)sender {
    int num = [_buyNumTF.text intValue];
    if (num!=0) {
        _buyNumTF.text = [NSString stringWithFormat:@"%d",--num];
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
