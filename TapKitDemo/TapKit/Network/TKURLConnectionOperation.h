//
//  TKURLConnectionOperation.h
//  TapKitDemo
//
//  Created by Wu Kevin on 5/21/13.
//  Copyright (c) 2013 Telligenty. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TKURLConnectionOperation : TKOperation<
    NSURLConnectionDelegate,
    NSURLConnectionDataDelegate
> {
  
  NSString *_address;
  NSURLRequestCachePolicy _cachePolicy;
  NSTimeInterval _timeoutInterval;
  NSString *_method;
  NSDictionary *_headers;
  NSData *_body;
  
  NSURLResponse *_response;
  NSData *_responseData;
  NSString *_responseFilePath;
  NSFileHandle *_responseFileHandle;
  
  NSURLConnection *_connection;
  
  NSString *_runLoopMode;
  
  BOOL _shouldUpdateNetworkActivityIndicator;
  
  int _bytesHandled;
  int _totalBytesHandled;
  int _totalBytesExpectedToHandle;
}

@property (nonatomic, strong, readonly) NSString *address;
@property (nonatomic, readonly) NSURLRequestCachePolicy cachePolicy;
@property (nonatomic, readonly) NSTimeInterval timeoutInterval;
@property (nonatomic, copy, readonly) NSString *method;
@property (nonatomic, strong, readonly) NSDictionary *headers;
@property (nonatomic, strong, readonly) NSData *body;

@property (nonatomic, strong, readonly) NSURLResponse *response;
@property (nonatomic, strong, readonly) NSData *responseData;
@property (nonatomic, copy) NSString *responseFilePath;
@property (nonatomic, strong, readonly) NSFileHandle *responseFileHandle;

@property (nonatomic, strong, readonly) NSURLConnection *connection;

@property (nonatomic, copy) NSString *runLoopMode;

@property (nonatomic, assign) BOOL shouldUpdateNetworkActivityIndicator;

@property (nonatomic, readonly) int bytesHandled;
@property (nonatomic, readonly) int totalBytesHandled;
@property (nonatomic, readonly) int totalBytesExpectedToHandle;


- (id)initWithAddress:(NSString *)address
          cachePolicy:(NSURLRequestCachePolicy)cachePolicy
      timeoutInterval:(NSTimeInterval)timeoutInterval
               method:(NSString *)method;

- (void)startAsynchronous;
- (NSData *)startSynchronous;

- (void)addValue:(NSString *)value forRequestHeader:(NSString *)header;
- (void)setRequestHeaders:(NSDictionary *)headers;

- (void)setRequestBody:(NSData *)body;
- (void)setFormFields:(NSDictionary *)fields;

@end
