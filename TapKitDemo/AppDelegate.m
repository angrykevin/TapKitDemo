//
//  AppDelegate.m
//  TapKitDemo
//
//  Created by Wu Kevin on 4/11/13.
//  Copyright (c) 2013 Telligenty. All rights reserved.
//

#import "AppDelegate.h"

#import "TKCache.h"


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  
//  TKCacheItem *item1 = [[TKCacheItem alloc] init];
//  item1.key = @"key1";
//  item1.path = @"path1";
//  item1.size = 101;
//  item1.expiryDate = [NSDate date];
//  
//  TKCacheItem *item2 = [[TKCacheItem alloc] init];
//  item2.key = nil;
//  item2.path = nil;
//  item2.size = 0;
//  item2.expiryDate = nil;
//  
//  NSArray *ary = @[ item1, item2 ];
//  
//  NSData *data = [NSKeyedArchiver archivedDataWithRootObject:ary];
//  [data writeToFile:TKPathForDocumentsResource(@"xxx.dt") atomically:YES];
  
//  NSString *path = TKPathForDocumentsResource(@"xxx.dt");
//  NSData *data = [[NSData alloc] initWithContentsOfFile:path];
//  NSArray *ary = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//  
//  for ( int i=0; i<[ary count]; ++i ) {
//    TKCacheItem *item = [ary objectAtIndex:i];
//    NSLog(@"%@", item);
//  }
  
//  NSString *key = nil;
//  NSString *path = [[NSString alloc] initWithFormat:@"caches/%@", key];
//  NSLog(@"%@", TKPathForDocumentsResource(path));
  
  
  TKCache *cache = [TKCache sharedObject];
  [cache setData:nil forKey:@"img1" withTimeoutInterval:0];
  [cache setData:[NSData data] forKey:@"img2" withTimeoutInterval:1000];
  [cache setData:[@"xxx" dataUsingEncoding:NSUTF8StringEncoding] forKey:@"img3" withTimeoutInterval:1000];
  [cache synchronize];
  
//  if ( [cache hasCacheForKey:@"img1"] ) {
//    NSLog(@"has 1");
//  } else {
//    NSLog(@"has not 1");
//  }
//  
//  if ( [cache hasCacheForKey:@"img2"] ) {
//    NSLog(@"has 2");
//  } else {
//    NSLog(@"has not 2");
//  }
  
  
  
  _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  
  _window.backgroundColor = [UIColor whiteColor];
  [_window makeKeyAndVisible];
  return YES;
}

@end
