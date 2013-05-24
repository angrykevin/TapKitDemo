//
//  AppDelegate.m
//  TapKitDemo
//
//  Created by Wu Kevin on 4/11/13.
//  Copyright (c) 2013 Telligenty. All rights reserved.
//

#import "AppDelegate.h"
#import "TTMainViewController.h"
#import "TKURLConnectionOperation.h"

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  
//  NSData *dt1 = [[NSData alloc] initWithContentsOfFile:TKPathForBundleResource(nil, @"aaa.jpg")];
//  
//  NSDictionary *dict1 = @{ @"filename": @"aaa.jpg",
//                           @"data": dt1
//                           };
//  
//  NSDictionary *dict = @{ @"key1": @"value1",
//                          @"dt1": dict1
//                          };
  
  
//  connection.didStartBlock = ^(TKURLConnectionOperation *conn) {
//    TKPRINT(@"did start");
//  };
//
//  connection.didUpdateBlock = ^(TKURLConnectionOperation *conn) {
//    TKPRINT(@"did update");
//  };
//  
//  connection.didFailBlock = ^(TKURLConnectionOperation *conn) {
//    TKPRINT(@"did fail");
//  };
//  
//  connection.didFinishBlock = ^(TKURLConnectionOperation *conn) {
//    TKPRINT(@"did finish");
//  };
  
  
  
  
  
  _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  
  _window.rootViewController = [[TTMainViewController alloc] init];
  
  _window.backgroundColor = [UIColor whiteColor];
  [_window makeKeyAndVisible];
  return YES;
}

@end
