//
//  TTMainViewController.m
//  TapKitDemo
//
//  Created by Wu Kevin on 5/17/13.
//  Copyright (c) 2013 Telligenty. All rights reserved.
//

#import "TTMainViewController.h"
#import "TKCache.h"

@implementation TTMainViewController

- (void)thread1:(id)object
{
  @autoreleasepool {
    
    TKCache *cache = [TKCache sharedObject];
    
    int count = 10000;
    for ( int i=0; i<count; ++i ) {
      [_lock lock];
      
      NSData *data = [_datas randomObject];
      NSString *key = [[NSString alloc] initWithFormat:@"1-%04d", i];
      [_keys addObject:key];
      [cache setData:data forKey:key withTimeoutInterval:0];
      [cache synchronize];
      NSLog(@"add: %@", key);
      
      [_lock unlock];
      
      //[NSThread sleepForTimeInterval:0.003];
    }
    
  }
}

- (void)thread2:(id)object
{
  @autoreleasepool {
    
    TKCache *cache = [TKCache sharedObject];
    
    int count = 10000;
    for ( int i=0; i<count; ++i ) {
      [_lock lock];
      
      NSData *data = [_datas randomObject];
      NSString *key = [[NSString alloc] initWithFormat:@"2-%04d", i];
      [_keys addObject:key];
      [cache setData:data forKey:key withTimeoutInterval:0];
      [cache synchronize];
      NSLog(@"add: %@", key);
      
      [_lock unlock];
      
      //[NSThread sleepForTimeInterval:0.002];
    }
    
  }
}

- (void)thread3:(id)object
{
  @autoreleasepool {
    
    TKCache *cache = [TKCache sharedObject];
    
    int count = 10000;
    for ( int i=0; i<count; ) {
      [_lock lock];
      
      NSString *key = [_keys randomObject];
      if ( [key length] > 0 ) {
        ++i;
        [_keys removeObject:key];
        [cache removeCacheForKey:key];
        [cache synchronize];
        NSLog(@"remove: %@", key);
      }
      
      [_lock unlock];
      
      //[NSThread sleepForTimeInterval:0.001];
    }
    
  }
}

- (void)thread4:(id)object
{
  @autoreleasepool {
    
    TKCache *cache = [TKCache sharedObject];
    
    int count = 10000;
    for ( int i=0; i<count; ) {
      [_lock lock];
      
      NSString *key = [_keys randomObject];
      if ( [key length] > 0 ) {
        ++i;
        [_keys removeObject:key];
        [cache removeCacheForKey:key];
        [cache synchronize];
        NSLog(@"remove: %@", key);
      }
      
      [_lock unlock];
      
      //[NSThread sleepForTimeInterval:0.004];
    }
    
  }
}

- (void)doit:(id)sender
{
  
  TKURLConnectionOperation *connection = [[TKURLConnectionOperation alloc] initWithAddress:@"http://www.cnblogs.com/"
                                                                               cachePolicy:0
                                                                           timeoutInterval:0
                                                                                    method:@"POST"];
  connection.responseFilePath = TKPathForDocumentsResource(@"aa.html");
  [connection setFormFields: @{ @"key1": @"value1" }];
  
  [connection startAsynchronous];
  connection = nil;
  
  
//  int tag = [sender tag];
//  
//  TKCache *cache = [TKCache sharedObject];
//  
//  if ( tag == 1 ) {
//    
//    [cache setData:[_datas randomObject] forKey:@"1" withTimeoutInterval:5];
//    [cache setData:[_datas randomObject] forKey:@"2" withTimeoutInterval:10];
//    [cache setData:[_datas randomObject] forKey:@"3" withTimeoutInterval:20];
//    [cache synchronize];
//    
//  } else if ( tag == 2 ) {
//    
//    if ( [cache hasCacheForKey:@"1"] ) NSLog(@"has 1");
//    else NSLog(@"has not 1");
//    
//    if ( [cache hasCacheForKey:@"2"] ) NSLog(@"has 2");
//    else NSLog(@"has not 2");
//    
//    if ( [cache hasCacheForKey:@"3"] ) NSLog(@"has 3");
//    else NSLog(@"has not 3");
//    
//  } else if ( tag == 3 ) {
//    
//    NSData *data1 = [cache dataForKey:@"1"];
//    NSData *data2 = [cache dataForKey:@"2"];
//    NSData *data3 = [cache dataForKey:@"3"];
//    
//    NSLog(@"%d %d %d", [data1 length], [data2 length], [data3 length]);
//    
//  } else if ( tag == 4 ) {
//    
//    NSLog(@"%d", [cache cacheSize]);
//    
//    [cache cleanUp];
//    [cache synchronize];
//  }
  
//  int tag = [sender tag];
//  
//  if ( tag == 1 ) {
//    static BOOL b = NO;
//    if ( !b ) {
//      NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(thread1:) object:nil];
//      [thread start];
//    }
//  } else if ( tag == 2 ) {
//    static BOOL b = NO;
//    if ( !b ) {
//      NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(thread2:) object:nil];
//      [thread start];
//    }
//  } else if ( tag == 3 ) {
//    static BOOL b = NO;
//    if ( !b ) {
//      NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(thread3:) object:nil];
//      [thread start];
//    }
//  } else if ( tag == 4 ) {
//    static BOOL b = NO;
//    if ( !b ) {
//      NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(thread4:) object:nil];
//      [thread start];
//    }
//  }
  
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  for ( int i=0; i<4; ++i ) {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.tag = i+1;
    button.frame = CGRectMake(10, 10+i*(40+10), 300, 40);
    [button addTarget:self action:@selector(doit:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
  }
  
  [TKCache sharedObject];
  
  _lock = [[NSLock alloc] init];
  
  _keys = [[NSMutableArray alloc] init];
  
  _datas = [[NSMutableArray alloc] init];
//  for ( int i=0; i<10; ++i ) {
//    NSString *name = [[NSString alloc] initWithFormat:@"test%d.dt", i];
//    NSString *path = TKPathForBundleResource(nil, name);
//    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
//    [_datas addObject:data];
//  }
}

@end
