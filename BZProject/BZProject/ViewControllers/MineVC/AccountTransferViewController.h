//
//  AccountTransferViewController.h
//  BZProject
//
//  Created by duwen on 14/12/15.
//  Copyright (c) 2014年 peterstudio. All rights reserved.
//

#import "BZViewController.h"
#import "RTLabel.h"
@interface AccountTransferViewController : BZViewControllerWithBackButton<UITextFieldDelegate>


@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *accountTransTFArray;

@property (weak, nonatomic) IBOutlet RTLabel *infoLabel;


@end
