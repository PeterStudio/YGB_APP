//
//  PersonalInformationViewController.h
//  BZProject
//
//  Created by duwen on 14/12/13.
//  Copyright (c) 2014年 peterstudio. All rights reserved.
//

#import "BZViewController.h"
#import "LoginModel.h"
@interface PersonalInformationViewController : BZViewControllerWithBackButton<UIActionSheetDelegate>


@property (weak, nonatomic) IBOutlet UITextField *nickNameTF;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;


@end
