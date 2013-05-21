//
//  TKURLConnectionOperation.h
//  TapKitDemo
//
//  Created by Wu Kevin on 5/21/13.
//  Copyright (c) 2013 Telligenty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKURLRequest.h"

@interface TKURLConnectionOperation : TKOperation<
    NSURLConnectionDelegate,
    NSURLConnectionDataDelegate
> {
  
  TKURLRequest *_request;
  
  NSURLResponse *_response;
  NSData *_responseData;
  NSString *_responseFilePath;
  NSFileHandle *_responseFileHandle;
  
  NSURLConnection *_connection;
  NSURLRequestCachePolicy _cachePolicy;
  NSTimeInterval _timeoutInterval;
  
  NSString *_runLoopMode;
  
  BOOL _shouldUpdateNetworkActivityIndicator;
}

- (id)initWithRequest:(TKURLRequest *)request;

- (void)startAsynchronous;
- (NSData *)startSynchronous;

@end
