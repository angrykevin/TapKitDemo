//
//  AppDelegate.m
//  TapKitDemo
//
//  Created by Wu Kevin on 4/11/13.
//  Copyright (c) 2013 Telligenty. All rights reserved.
//

#import "AppDelegate.h"




@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  
  
  UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 30, 300, 440)];
  [_window addSubview:view];
  
  
  UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 280, 20)];
  [view addSubview:view1];
  
  UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(10, 40, 280, 390)];
  [view addSubview:view2];
  
  
  UIView *view21 = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 260, 20)];
  [view2 addSubview:view21];
  
  UIView *view22 = [[UIView alloc] initWithFrame:CGRectMake(10, 40, 260, 340)];
  [view2 addSubview:view22];
  
  [UIView showBorder:_window level:0];
  [UIView dumpView:_window level:0];
  
  
  _window.backgroundColor = [UIColor whiteColor];
  [_window makeKeyAndVisible];
  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
