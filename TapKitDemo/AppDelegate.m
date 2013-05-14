//
//  AppDelegate.m
//  TapKitDemo
//
//  Created by Wu Kevin on 4/11/13.
//  Copyright (c) 2013 Telligenty. All rights reserved.
//

#import "AppDelegate.h"

#import "TKDatabase.h"
#import "TKDatabaseRow.h"


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  
  
  NSData *data = [NSData dataWithContentsOfFile:TKPathForBundleResource(nil, @"a.png")];
  
  TKDatabase *db = [[TKDatabase alloc] init];
  db.path = TKPathForDocumentsResource(@"asdf.db");
  [db open];
  
  //[db executeUpdate:@"CREATE TABLE user(pk INTEGER PRIMARY KEY, b INTEGER, i INTEGER, l INTEGER, d REAL, dt TEXT, str TEXT, oth BLOB);"];
  
//  [db executeUpdate:@"INSERT INTO user(pk, b, i, l, d, dt, str, oth) VALUES(1, ?, ?, ?, ?, ?, ?, ?);", nil, nil, nil, nil, nil, nil, nil];
//  
//  [db executeUpdate:@"INSERT INTO user(pk, b, i, l, d, dt, str, oth) VALUES(2, ?, ?, ?, ?, ?, ?, ?);",
//   [NSNumber numberWithBool:YES],
//   [NSNumber numberWithInt:11],
//   [NSNumber numberWithLongLong:101],
//   [NSNumber numberWithDouble:1.1],
//   [NSDate date],
//   @"god is a girl",
//   data];
  
//  [db executeUpdate:@"INSERT INTO user(pk, b, i, l, d, dt, str, oth) VALUES(3, ?, ?, ?, ?, ?, ?, ?);",
//   [NSNumber numberWithBool:YES],
//   [NSNumber numberWithInt:11],
//   [NSNumber numberWithLongLong:101],
//   [NSNumber numberWithDouble:1.1],
//   nil,
//   @"god is a girl",
//   data];
  
  
  NSArray *rows = [db executeQuery:@"SELECT * FROM user;"];
  for ( int i=0; i<[rows count]; ++i ) {
    TKDatabaseRow *row = [rows objectAtIndex:i];
    BOOL b = [row boolForName:@"b"];
    int i = [row intForName:@"i"];
    long long l = [row longLongForName:@"l"];
    double d = [row doubleForName:@"d"];
    NSDate *dt = [row dateForName:@"dt"];
    NSString *str = [row stringForName:@"str"];
    NSData *oth = [row dataForName:@"oth"];
  }
  
  
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
