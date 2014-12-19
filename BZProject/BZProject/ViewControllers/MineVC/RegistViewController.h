//
//  RegistViewController.h
//  BZProject
//
//  Created by duwen on 14/12/13.
//  Copyright (c) 2014年 peterstudio. All rights reserved.
//

#import "BZViewController.h"

@interface RegistViewController : BZViewControllerWithBackButton<UITextFieldDelegate>
@property (strong,nonatomic) dispatch_block_t registButtonBlock;  // 注册成功事件

@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *textFieldArray;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewBottomConstraint;


@end
