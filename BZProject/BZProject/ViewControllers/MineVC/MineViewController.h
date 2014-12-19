//
//  MineViewController.h
//  BZProject
//
//  Created by duwen on 14/12/11.
//  Copyright (c) 2014年 peterstudio. All rights reserved.
//

#import "BZViewController.h"

@interface MineViewController : BZViewController<UIAlertViewDelegate>


@property (weak, nonatomic) IBOutlet UILabel *firstLabel;   // 用户名
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstLabelTopConstraint;

@property (weak, nonatomic) IBOutlet UILabel *secondLabel;  // 当前算力：
@property (weak, nonatomic) IBOutlet UILabel *thirdLabel;   // 我的阳光宝：
@property (weak, nonatomic) IBOutlet UILabel *fourLabel;    // 我的人名币

@property (weak, nonatomic) IBOutlet UIView *loginButtonView;
@property (weak, nonatomic) IBOutlet UILabel *signInLabel;


@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *fourButtonSpaceConstraint;

@property (weak, nonatomic) IBOutlet UIView *exitButtonView;
@property (weak, nonatomic) IBOutlet UIImageView *footLineImageView;

@property (weak, nonatomic) IBOutlet UIView *payMoneyView;



@end
