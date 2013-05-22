//
//  AppDelegate.m
//  TapKitDemo
//
//  Created by Wu Kevin on 4/11/13.
//  Copyright (c) 2013 Telligenty. All rights reserved.
//

#import "AppDelegate.h"
#import "TTMainViewController.h"
#import "TKURLRequest.h"

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  
  TKURLRequest *request = [[TKURLRequest alloc] init];
  
  NSData *dt1 = [[NSData alloc] initWithContentsOfFile:TKPathForBundleResource(nil, @"aaa.jpg")];
  NSData *dt2 = [[NSData alloc] initWithContentsOfFile:TKPathForBundleResource(nil, @"bbb.zip")];
  NSData *dt3 = [[NSData alloc] initWithContentsOfFile:TKPathForBundleResource(nil, @"ccc.mp3")];
  
  NSDictionary *dict1 = @{ @"filename": @"aaa.jpg",
                           @"data": dt1
                           };
  NSDictionary *dict2 = @{ @"filename": @"bbb.zip",
                           @"data": dt2
                           };
  NSDictionary *dict3 = @{ @"filename": @"ccc.mp3",
                           @"data": dt3
                           };
  
  NSDictionary *dict = @{ @"key1": @"value1",
                          @"dt1": dict1,
                          @"dt2": dict2,
                          @"key2": @"value2",
                          @"dt3": dict3
                          };
  
  [request addFormFields:dict];
  
  NSString *path = TKPathForDocumentsResource(@"abc.c");
  [request.body writeToFile:path atomically:YES];
  
  
  
  _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  
  _window.rootViewController = [[TTMainViewController alloc] init];
  
  _window.backgroundColor = [UIColor whiteColor];
  [_window makeKeyAndVisible];
  return YES;
}

@end
