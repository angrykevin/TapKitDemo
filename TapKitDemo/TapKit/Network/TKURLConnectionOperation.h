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
  
  NSURLRequest *_request;
  
  NSURLResponse *_response;
  NSData *_responseData;
  NSString *_responseFilePath;
  NSFileHandle *_responseFileHandle;
  
  BOOL _shouldUpdateNetworkActivityIndicator;
  
  NSString *_runLoopMode;
  
  NSURLConnection *_connection;
  
  int _bytesWritten;
  int _totalBytesWritten;
  int _totalBytesExpectedToWrite;
  
  int _bytesRead;
  int _totalBytesRead;
  int _totalBytesExpectedToRead;
}

@property (nonatomic, readonly, copy) NSString *address;
@property (nonatomic, readonly) NSURLRequestCachePolicy cachePolicy;
@property (nonatomic, readonly) NSTimeInterval timeoutInterval;
@property (nonatomic, readonly, copy) NSString *method;
@property (nonatomic, readonly, strong) NSDictionary *headers;
@property (nonatomic, readonly, strong) NSData *body;

@property (nonatomic, readonly, strong) NSURLRequest *request;

@property (nonatomic, readonly, strong) NSURLResponse *response;
@property (nonatomic, readonly, strong) NSData *responseData;
@property (nonatomic, copy) NSString *responseFilePath;
@property (nonatomic, readonly, strong) NSFileHandle *responseFileHandle;

@property (nonatomic, assign) BOOL shouldUpdateNetworkActivityIndicator;

@property (nonatomic, copy) NSString *runLoopMode;

@property (nonatomic, readonly, strong) NSURLConnection *connection;

@property (nonatomic, readonly) int bytesWritten;
@property (nonatomic, readonly) int totalBytesWritten;
@property (nonatomic, readonly) int totalBytesExpectedToWrite;

@property (nonatomic, readonly) int bytesRead;
@property (nonatomic, readonly) int totalBytesRead;
@property (nonatomic, readonly) int totalBytesExpectedToRead;


///-------------------------------
/// Initializing
///-------------------------------

- (id)initWithAddress:(NSString *)address
          cachePolicy:(NSURLRequestCachePolicy)cachePolicy
      timeoutInterval:(NSTimeInterval)timeoutInterval
               method:(NSString *)method;

- (id)initWithRequest:(NSURLRequest *)request;


///-------------------------------
/// Launch request
///-------------------------------

- (void)startAsynchronous;


///-------------------------------
/// Request header
///-------------------------------

- (void)addValue:(NSString *)value forRequestHeader:(NSString *)header;
- (void)setRequestHeaders:(NSDictionary *)headers;


///-------------------------------
/// Request body
///-------------------------------

- (void)setRequestBody:(NSData *)body;
- (void)setFormFields:(NSDictionary *)fields;

@end
