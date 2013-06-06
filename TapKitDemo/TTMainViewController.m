//
//  TTMainViewController.m
//  TapKitDemo
//
//  Created by Wu Kevin on 5/17/13.
//  Copyright (c) 2013 Telligenty. All rights reserved.
//

#import "TTMainViewController.h"

@implementation TTMainViewController

- (void)doit:(id)sender
{
  if ( [sender tag] == 1 ) {
    
    //TKURLConnectionOperation *connection = nil;
    
//    for ( int i=0; i<[_urls count]; ++i ) {
//      TKURLConnectionOperation *connection = [[TKURLConnectionOperation alloc] initWithAddress:_urls[i]
//                                                         cachePolicy:0
//                                                     timeoutInterval:0
//                                                              method:@"GET"];
//      //[_connections addObject:connection];
//      
//      connection.didStartBlock = ^(TKURLConnectionOperation *conn) {
//        TKPRINT(@"did start: %@", conn.address);
//      };
//      
//      connection.didFailBlock = ^(TKURLConnectionOperation *conn) {
//        TKPRINT(@"did fail: %@", conn.address);
//      };
//      
//      connection.didUpdateBlock = ^(TKURLConnectionOperation *conn) {
//        TKPRINT(@"did update: %@", conn.address);
//      };
//      
//      connection.didFinishBlock = ^(TKURLConnectionOperation *conn) {
//        TKPRINT(@"did finish: %@", conn.address);
//      };
//      
//      [connection startAsynchronous];
//      
//    }
  } else if ( [sender tag] == 2 ) {
//    for ( TKURLConnectionOperation *connection in _connections ) {
//      [connection cancel];
//    }
  } else if ( [sender tag] == 3 ) {
    
    TKURLConnectionOperation *connection = [[TKURLConnectionOperation alloc] initWithAddress:@"http://farm9.staticflickr.com/8394/8956206275_08c3694959_o_d.jpg"
                                                                                 cachePolicy:0
                                                                             timeoutInterval:0
                                                                                      method:@"GET"];
    
    connection.didStartBlock = ^(TKURLConnectionOperation *conn) {
      TKPRINT(@"did start: %@", conn.address);
    };
    
    connection.didFailBlock = ^(TKURLConnectionOperation *conn) {
      TKPRINT(@"did fail: %@", conn.address);
    };
    
    connection.didUpdateBlock = ^(TKURLConnectionOperation *conn) {
      //TKPRINT(@"did update: %@", conn.address);
    };
    
    connection.didFinishBlock = ^(TKURLConnectionOperation *conn) {
      TKPRINT(@"did finish: %@", conn.address);
    };
    
    [connection startAsynchronous];
    
  }
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  _urls = @[
//            @"http://www.baidu.com/",
//            @"http://www.facebook.com/",
            @"http://www.google.com.hk/",
//            @"http://www.twitter.com/",
//            @"http://www.yahoo.com/",
//            
//            @"",
//            @"http://www.youtube.com/",
//            @"http://www.blahblahblahblahblah.com/",
//            @"http://www..com/",
            @"http://www.qq.com/"
            ];
  
  _connections = [[NSMutableArray alloc] init];
  
  for ( int i=0; i<4; ++i ) {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.tag = i+1;
    button.frame = CGRectMake(10, 10+i*(40+10), 300, 40);
    [button addTarget:self action:@selector(doit:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
  }
}

@end
