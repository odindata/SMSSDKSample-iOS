//
//  AppDelegate.m
//  SMSSDKSample
//
//  Created by nathan on 2020/5/22.
//  Copyright © 2020 odin. All rights reserved.
//

#import "AppDelegate.h"
#import "ODSHomeViewController.h"
#import "ODNavigationViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    ODNavigationViewController *navVc = [[ODNavigationViewController alloc]initWithRootViewController:[ODSHomeViewController new]];
    self.window.rootViewController = navVc;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
