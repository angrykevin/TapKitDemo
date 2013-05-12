//
//  AppDelegate.m
//  TapKitDemo
//
//  Created by Wu Kevin on 4/11/13.
//  Copyright (c) 2013 Telligenty. All rights reserved.
//

#import "AppDelegate.h"

#import "TSObject.h"
#import "TKNAIManager.h"




@implementation AppDelegate

- (void)print:(NSString *)fmt, ...
{
  NSMutableArray *container = [[NSMutableArray alloc] init];
  
  TKValistToArray(container, fmt, 0);
  
  NSLog(@"%@", container);
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  
  
  NSMutableArray *ary = [NSMutableArray array];
  
//  TSObject *obj1 = [[TSObject alloc] init];
//  obj1.view1 = [[UIView alloc] init];
//  [ary addObject:obj1];
//  
//  TSObject *obj2 = [[TSObject alloc] init];
//  obj2.view1 = [[UIView alloc] init];
//  [ary addObject:obj2];
  
  [ary removeObjectAtIndex:0];
  //[ary insertObject:nil atIndex:0];
  
//  if ( [ary indexOfObjectIdenticalTo:nil] == NSNotFound ) {
//    NSLog(@"NOT");
//  }
//  
//  [ary indexOfObject:nil];
  
  NSArray *tmp = [ary objectsForKeyPath:@"view2" identicalToValue:nil];
  NSLog(@"%@", tmp);
  
//  TSObject *object = [[TSObject alloc] init];
//  
//  UIView *v1 = [[UIView alloc] init];
//  UIView *v2 = [[UIView alloc] init];
//  //object.view1 = v1;
//  object.view2 = v2;
//  
//  if ( [object isValueForKeyPath:@"view1" identicalToValue:nil] ) {
//    NSLog(@"YES");
//  } else {
//    NSLog(@"NO");
//  }
//  
//  if ( [object isValueForKeyPath:@"view2" equalToValue:v2] ) {
//    NSLog(@"YES");
//  } else {
//    NSLog(@"NO");
//  }
//  
//  
//  NSArray *ary = @[ @"aks", @"aksd", @"kasd" ];
//  if ( [ary indexOfObject:nil] == NSNotFound ) {
//    NSLog(@"NOT FOUND");
//  }
  
//  NSString *str = @"lksdf";
//  if ( [str isInCharacterSet:nil] ) {
//    NSLog(@"IN SET");
//  } else {
//    NSLog(@"NOT IN SET");
//  }
  
  
  NSString *str = @"aa";
  [[TKNAIManager sharedObject] addNetworkUser:str];
  NSLog(@"H%@H", [str queryDictionary]);
  
  
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
