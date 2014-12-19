//
//  LoginManager.m
//  BZProject
//
//  Created by duwen on 14/12/15.
//  Copyright (c) 2014年 peterstudio. All rights reserved.
//

#import "LoginManager.h"
#import "BZDefine.h"
#import "CHKeychain.h"



@implementation LoginManager
static LoginManager *loginManage = nil;

+ (LoginManager *)shareInstance {
    @synchronized(self){
        if (loginManage == nil) {
            loginManage = [[LoginManager alloc] init];
        }
    }
    return loginManage;
}

-(void)saveAccountInfo:(LoginDetailModel *)accountInfo
{
    NSData *data =[NSKeyedArchiver archivedDataWithRootObject:accountInfo];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:USERINFO];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//- (void)resetAccountInfo
//{
//    NSData *data =[NSKeyedArchiver archivedDataWithRootObject:nil];
//    [[NSUserDefaults standardUserDefaults] setObject:data forKey:USERINFO];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}

- (LoginDetailModel *)loginAccountInfo{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSData *accountData = [defaults objectForKey:USERINFO];
    return [NSKeyedUnarchiver unarchiveObjectWithData:accountData];
}

- (BOOL)isExistCurrentUser{
    NSString * password = [self password];
    if (password) {
        return YES;
    }
    return NO;
}

- (void)saveUsername:(NSString *)_username password:(NSString *)_password{
    NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
    [usernamepasswordKVPairs setObject:_username forKey:USER_NAME_KEY];
    [usernamepasswordKVPairs setObject:_password forKey:USER_PASSWORD_KEY];
    [CHKeychain save:USER_NAME_PASSWORD_KEY data:usernamepasswordKVPairs];
}

- (void)deletePassword{
    [CHKeychain delete:USER_NAME_PASSWORD_KEY];
}

- (NSString *)username{
    NSMutableDictionary *usernamepasswordKVPairs = (NSMutableDictionary *)[CHKeychain load:USER_NAME_PASSWORD_KEY];
    return [usernamepasswordKVPairs objectForKey:USER_NAME_KEY];
}

- (NSString *)password{
    NSMutableDictionary *usernamepasswordKVPairs = (NSMutableDictionary *)[CHKeychain load:USER_NAME_PASSWORD_KEY];
    return [usernamepasswordKVPairs objectForKey:USER_PASSWORD_KEY];
}


@end
