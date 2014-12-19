//
//  AppDelegate.m
//  BZProject
//
//  Created by duwen on 14/12/9.
//  Copyright (c) 2014年 peterstudio. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "HomeViewController.h"
#import "TicketViewController.h"
#import "OrderViewController.h"
#import "MineViewController.h"
#import "BZDefine.h"
#import "VersionService.h"
#import "VersionModel.h"
#import "VersionUpdateView.h"
#import "UIDevice+IdentifierAddition.h"
#import "LoginService.h"
#import "LoginManager.h"
#import "LoginModel.h"
@interface AppDelegate ()
@property (nonatomic, strong) VersionService * versionService;
@property (nonatomic, strong) LoginService  * loginService;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    LoginViewController * loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
//    [self.window setRootViewController:loginVC];
//    [self.window makeKeyAndVisible];
    [self updateAppVersion];
    [self autoLogin];
    [self reloadRootViewController];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)reloadRootViewController{
    // 首页
    HomeViewController *homeVC = [[HomeViewController alloc]init];
    homeVC.title = @"首页";
    BZUINavigationController *navHome = [[BZUINavigationController alloc]initWithRootViewController:homeVC];
    if (CURRENT_VERSION < 7.0) {
        UITabBarItem * barItem1 = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"nav_icon01"] tag:1];
        [barItem1 setFinishedSelectedImage:[UIImage imageNamed:@"nav_icon01_1"] withFinishedUnselectedImage:[UIImage imageNamed:@"nav_icon01"]];
        barItem1.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
        [navHome setTabBarItem:barItem1];
    } else {
        UITabBarItem * barItem1 = [[UITabBarItem alloc] initWithTitle:@"" image:[[UIImage imageNamed:@"nav_icon01"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"nav_icon01_1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        barItem1.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
        [navHome setTabBarItem:barItem1];
    }
    navHome.navigationBarHidden = YES;
    
    // 有票
    TicketViewController *ticketVC = [[TicketViewController alloc]init];
    ticketVC.title = @"有票";
    BZUINavigationController *navHome2 = [[BZUINavigationController alloc]initWithRootViewController:ticketVC];
    if (CURRENT_VERSION < 7.0) {
        UITabBarItem * barItem2 = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"nav_icon02"] tag:2];
        [barItem2 setFinishedSelectedImage:[UIImage imageNamed:@"nav_icon02_1"] withFinishedUnselectedImage:[UIImage imageNamed:@"nav_icon02"]];
        barItem2.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
        [navHome2 setTabBarItem:barItem2];
    } else {
        UITabBarItem * barItem2 = [[UITabBarItem alloc] initWithTitle:nil image:[[UIImage imageNamed:@"nav_icon02"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"nav_icon02_1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        barItem2.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
        [navHome2 setTabBarItem:barItem2];
    }
    navHome2.tabBarItem.enabled = NO;
    
    // 订单
    OrderViewController *orderVC = [[OrderViewController alloc]init];
    BZUINavigationController *navHome3 = [[BZUINavigationController alloc]initWithRootViewController:orderVC];
    if (CURRENT_VERSION < 7.0) {
        UITabBarItem * barItem3 = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"nav_icon03"] tag:3];
        [barItem3 setFinishedSelectedImage:[UIImage imageNamed:@"nav_icon03_1"] withFinishedUnselectedImage:[UIImage imageNamed:@"nav_icon03"]];
        barItem3.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
        [navHome3 setTabBarItem:barItem3];
    } else {
        UITabBarItem * barItem3 = [[UITabBarItem alloc] initWithTitle:nil image:[[UIImage imageNamed:@"nav_icon03"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"nav_icon03_1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        barItem3.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
        [navHome3 setTabBarItem:barItem3];
    }
    navHome3.tabBarItem.enabled = NO;
    
    // 我的
    MineViewController *mineVC = [[MineViewController alloc]init];
    mineVC.title = @"我的";
    BZUINavigationController *navHome4 = [[BZUINavigationController alloc]initWithRootViewController:mineVC];
    if (CURRENT_VERSION < 7.0) {
        UITabBarItem * barItem4 = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"nav_icon04"] tag:4];
        [barItem4 setFinishedSelectedImage:[UIImage imageNamed:@"nav_icon04_1"] withFinishedUnselectedImage:[UIImage imageNamed:@"nav_icon04"]];
        barItem4.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
        [navHome4 setTabBarItem:barItem4];
    } else {
        UITabBarItem * barItem4 = [[UITabBarItem alloc] initWithTitle:nil image:[[UIImage imageNamed:@"nav_icon04"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"nav_icon04_1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        barItem4.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
        [navHome4 setTabBarItem:barItem4];
    }
    
    NSArray *array = [NSArray arrayWithObjects:navHome, navHome2, navHome3, navHome4, nil];
    UITabBarController * tvc = [[UITabBarController alloc] init];
    [tvc setViewControllers:array];
    
    // IOS6将tabbar背景设置成白色
    if ([[UIDevice currentDevice] systemVersion].floatValue < 7.0) {
        CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
        CGContextFillRect(context, rect);
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        tvc.tabBar.backgroundImage = image;
    }
    
    // IOS6取消tabbar高亮效果
    if ([[UIDevice currentDevice] systemVersion].floatValue < 7.0) {
        CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        CGContextFillRect(context, rect);
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [tvc.tabBar setSelectionIndicatorImage:image];
    }
    
    self.window.rootViewController = tvc;
    [self.window makeKeyAndVisible];
}



- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)autoLogin{
    if ([[LoginManager shareInstance] isExistCurrentUser]) {
        if (!self.loginService) {
            self.loginService = [[LoginService alloc] init];
        }
        //版本号
        NSString *curVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        if (!curVersion) {
            curVersion=@"";
        }
        //设备号
        NSString *imeiStr = [[UIDevice currentDevice] myGlobalDeviceId];
        // 手机型号
        [self.loginService login_Request_HTTP_UserName:[[LoginManager shareInstance] username] password:[[LoginManager shareInstance] password] system:@"ios" version:curVersion imei:imeiStr success:^(id responseObject) {
            LoginModel * loginModel = (LoginModel *)responseObject;
            if (![RETURN_CODE_SUCCESS isEqualToString:loginModel.status]) {
                [[LoginManager shareInstance] deletePassword];
            }
        } failure:^(NSError *error) {
            [[LoginManager shareInstance] deletePassword];
        }];
    }
}

//更新版本
-(void)updateAppVersion{
    self.versionService = [[VersionService alloc] init];
    //版本号
    NSString *curVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    if (!curVersion) {
        curVersion=@"";
    }
    //设备号
    NSString *imeiStr = [[UIDevice currentDevice] myGlobalDeviceId];
    // 手机型号
    
    [self.versionService version_Request_HTTP_Version:curVersion type:@"2" imei:imeiStr success:^(id responseObject) {
        VersionModel * versionModel = (VersionModel *)responseObject;
        if ([RETURN_CODE_SUCCESS isEqualToString:versionModel.status]) {
            NSString *content = versionModel.content;
            NSArray *arr = nil;
            if (![content isEqualToString:@""]&&content!=nil){
                arr = [content componentsSeparatedByString:@";"];
            }
            NSString * url = [versionModel.urlAddress stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            
            VersionUpdateView *versionView = [[VersionUpdateView alloc] initWithDocArray:arr isMust:NO];
            __weak VersionUpdateView *weakVersionView = versionView;
            weakVersionView.leftBlock = ^() {
                if (url&&![url isEqualToString:@""]) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
                }else{
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.sunscoin.org"]];
                }
            };
            weakVersionView.rightBlock = ^() {
                [weakVersionView removeViewFromSelf];
            };
            
            
        }
        
    } failure:^(NSError *error) {
        
    }];
}

@end
