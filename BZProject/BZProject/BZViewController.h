//
//  BZViewController.h
//  BZProject
//
//  Created by duwen on 14/12/11.
//  Copyright (c) 2014年 peterstudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BZDefine.h"
@interface BZViewController : UIViewController

@end

/**
 * UIViewController基类,带导航栏返回按钮
 */
@interface BZViewControllerWithBackButton :BZViewController
- (void)click_popViewController;
@end

/**
 * UINavigationController基类,暂时继承此类，目前未实现任何代码
 */
@interface BZUINavigationController : UINavigationController
@end
