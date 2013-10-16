//
//  TKURLConnectionOperation.h
//  TapKit
//
//  Created by Wu Kevin on 5/21/13.
//  Copyright (c) 2013 Telligenty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Common/Common.h"

@interface TKURLConnectionOperation : TKOperation<
    NSURLConnectionDelegate,
    NSURLConnectionDataDelegate
> {
  
  NSString *_address;
  NSURLRequestCachePolicy _cachePolicy;
  NSTimeInterval _timeoutInterval;
  NSString *_method;
  NSMutableDictionary *_headers;
  NSData *_body;
  NSMutableDictionary *_multipartForm;
  
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

@property (nonatomic, copy, readonly) NSString *address;
@property (nonatomic, readonly) NSURLRequestCachePolicy cachePolicy;
@property (nonatomic, readonly) NSTimeInterval timeoutInterval;
@property (nonatomic, copy, readonly) NSString *method;
@property (nonatomic, strong, readonly) NSMutableDictionary *headers;
@property (nonatomic, strong, readonly) NSData *body;
@property (nonatomic, strong, readonly) NSMutableDictionary *multipartForm;

@property (nonatomic, strong, readonly) NSURLRequest *request;

@property (nonatomic, strong, readonly) NSURLResponse *response;
@property (nonatomic, strong, readonly) NSData *responseData;
@property (nonatomic, copy) NSString *responseFilePath;
@property (nonatomic, strong, readonly) NSFileHandle *responseFileHandle;

@property (nonatomic, assign) BOOL shouldUpdateNetworkActivityIndicator;

@property (nonatomic, copy) NSString *runLoopMode;

@property (nonatomic, strong, readonly) NSURLConnection *connection;

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
- (void)clearRequestHeaders;
- (void)setRequestHeaders:(NSDictionary *)headers;


///-------------------------------
/// Request body
///-------------------------------

- (void)addValue:(id)value filename:(NSString *)filename forFormField:(NSString *)field;
- (void)clearFormFields;
- (void)setRequestBody:(NSData *)body;

@end
