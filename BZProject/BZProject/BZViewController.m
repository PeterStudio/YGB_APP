//
//  BZViewController.m
//  BZProject
//
//  Created by duwen on 14/12/11.
//  Copyright (c) 2014年 peterstudio. All rights reserved.
//

#import "BZViewController.h"

@interface BZViewController ()

@end

@implementation BZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置导航栏字体颜色
    UILabel * myTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 1, 44)];
    myTitleLabel.textAlignment = NSTextAlignmentCenter;
    [myTitleLabel setBackgroundColor:[UIColor clearColor]];
    myTitleLabel.font = [UIFont systemFontOfSize:20];
    myTitleLabel.textColor = [UIColor blackColor];
    
    myTitleLabel.text = self.title;
    self.navigationItem.titleView = myTitleLabel;
    
    // IOS6将导航栏背景设置成白色
    if (CURRENT_VERSION < 7.0) {
        CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
        CGContextFillRect(context, rect);
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    }
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
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


@implementation BZViewControllerWithBackButton

- (void)click_popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundColor:[UIColor clearColor]];
    if (CURRENT_VERSION >= 7.0) {
        [backBtn setFrame:CGRectMake(0, 0, 20, 20)];
    } else {
        [backBtn setFrame:CGRectMake(0, 0, 20 + 22, 20)];
    }
    [backBtn setImage:[UIImage imageNamed:@"return_40x40"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"return_40x40_press"] forState:UIControlStateHighlighted];
    [backBtn addTarget:self action:@selector(click_popViewController) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
}

@end

@implementation BZUINavigationController

- (void) pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}

@end