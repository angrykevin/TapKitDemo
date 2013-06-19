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
    
    TKURLConnectionOperation *connection = nil;
    
    for ( int i=0; i<[_urls count]; ++i ) {
      
      NSString *url = _urls[ i ];
      connection = [[TKURLConnectionOperation alloc] initWithAddress:url
                                                         cachePolicy:0
                                                     timeoutInterval:0
                                                              method:@"GET"];
      [_connections addObject:connection];
      
      connection.responseFilePath = TKPathForDocumentsResource([url MD5HashString]);
      
      connection.didStartBlock = ^(TKURLConnectionOperation *conn) {
        TKPRINT(@"did start: %@", conn.address);
      };
      
      connection.didFailBlock = ^(TKURLConnectionOperation *conn) {
        TKPRINT(@"did fail: %@", conn.address);
      };
      
      //connection.didUpdateBlock = ^(TKURLConnectionOperation *conn) {
      //  TKPRINT(@"did update: %@", conn.address);
      //};
      
      connection.didFinishBlock = ^(TKURLConnectionOperation *conn) {
        TKPRINT(@"did finish: %@", conn.address);
      };
      
      [connection startAsynchronous];
      
    }
  } else if ( [sender tag] == 2 ) {
//    for ( TKURLConnectionOperation *connection in _connections ) {
//      [connection cancel];
//    }
  } else if ( [sender tag] == 3 ) {
    
    NSString *url = @"http://farm3.staticflickr.com/2877/9055426841_998caf11c5_b.jpg";
    
    TKURLConnectionOperation *connection = [[TKURLConnectionOperation alloc] initWithAddress:url
                                                                                 cachePolicy:0
                                                                             timeoutInterval:0
                                                                                      method:@"GET"];
    
    connection.responseFilePath = TKPathForDocumentsResource([url MD5HashString]);
    
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
            @"http://farm9.staticflickr.com/8548/8960587666_53557066f9_b.jpg",
            
            @"http://www.baidu.com/",
            @"http://www.facebook.com/",
            @"http://www.google.com.hk/",
            @"http://www.twitter.com/",
            @"http://www.yahoo.com/",
            
            @"http://farm9.staticflickr.com/8557/8961935971_3f53b3c5a6_k.jpg",
            @"http://farm3.staticflickr.com/2812/8958944922_bc49237783_o.jpg", 
            
            @"",
            @"http://www.youtube.com/",
            @"http://www.blahblahblahblahblah.com/",
            @"http://www..com/",
            @"http://www.qq.com/"
            
            @"http://farm4.staticflickr.com/3734/8961490761_2f9f0e3330_k.jpg"
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
