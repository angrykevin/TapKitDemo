//
//  TKURLConnectionOperation.m
//  TapKitDemo
//
//  Created by Wu Kevin on 5/21/13.
//  Copyright (c) 2013 Telligenty. All rights reserved.
//

#import "TKURLConnectionOperation.h"
#import "TKNAIManager.h"

@interface TKURLConnectionOperation (Private)

- (void)startUsingNetwork;
- (void)stopUsingNetwork;

- (NSURLRequest *)buildRequest;

+ (NSOperationQueue *)operationQueue;
+ (NSThread *)operationThread;
+ (void)threadBody:(id)object;

@end

@implementation TKURLConnectionOperation (Private)

- (void)startUsingNetwork
{
  if ( _shouldUpdateNetworkActivityIndicator ) {
    [[TKNAIManager sharedObject] addNetworkUser:self];
  }
}

- (void)stopUsingNetwork
{
  if ( _shouldUpdateNetworkActivityIndicator ) {
    [[TKNAIManager sharedObject] removeNetworkUser:self];
  }
}


- (NSURLRequest *)buildRequest
{
  NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:_address]
                                                              cachePolicy:_cachePolicy
                                                          timeoutInterval:_timeoutInterval];
  
  
  if ( [_body length] > 0 ) {
    [request setHTTPBody:_body];
    [(NSMutableDictionary *)_headers setObject:[NSString stringWithFormat:@"%u", [_body length]]
                                        forKey:@"Content-Length"];
  }
  
  if ( ![_headers hasKeyEqualTo:@"Accept-Encoding"] ) {
    [(NSMutableDictionary *)_headers setObject:@"gzip" forKey:@"Accept-Encoding"];
  }
  if ( ![_headers hasKeyEqualTo:@"User-Agent"] ) {
    [(NSMutableDictionary *)_headers setObject:@"tapkit/0.1" forKey:@"User-Agent"];
  }
  for ( NSString *header in _headers ) {
    NSString *value = [_headers objectForKey:header];
    [request addValue:value forHTTPHeaderField:header];
  }
  
  
  [request setHTTPMethod:_method];
  
  return request;
}


+ (NSOperationQueue *)operationQueue
{
  static NSOperationQueue *queue = nil;
  if ( queue == nil ) {
    queue = [[NSOperationQueue alloc] init];
    [queue setMaxConcurrentOperationCount:4];
  }
  return queue;
}

+ (NSThread *)operationThread
{
  static NSThread *thread = nil;
  if ( thread == nil ) {
    thread = [[NSThread alloc] initWithTarget:self
                                     selector:@selector(threadBody:)
                                       object:nil];
    [thread start];
  }
  return thread;
}

+ (void)threadBody:(id)object
{
  while ( YES ) {
    @autoreleasepool {
      [[NSRunLoop currentRunLoop] run];
    }
  }
}

@end


@implementation TKURLConnectionOperation


#pragma mark - Initializing

- (id)initWithAddress:(NSString *)address
          cachePolicy:(NSURLRequestCachePolicy)cachePolicy
      timeoutInterval:(NSTimeInterval)timeoutInterval
               method:(NSString *)method
{
  self = [super init];
  if ( self ) {
    _address = address;
    _cachePolicy = (cachePolicy == 0) ? NSURLRequestUseProtocolCachePolicy : cachePolicy;
    _timeoutInterval = (timeoutInterval > 0) ? timeoutInterval : 10.0;
    _method = ([method length] > 0) ? method : @"GET";
    _headers = [[NSMutableDictionary alloc] init];
    //_body = nil;
    
    //_response = nil;
    //_responseData = nil;
    //_responseFilePath = nil;
    //_responseFileHandle = nil;
    
    _shouldUpdateNetworkActivityIndicator = YES;
    
    _runLoopMode = NSRunLoopCommonModes;
    
    //_connection = nil;
    
    //_bytesWritten = 0;
    //_totalBytesWritten = 0;
    //_totalBytesExpectedToWrite = 0;
    
    //_bytesRead = 0;
    //_totalBytesRead = 0;
    //_totalBytesExpectedToRead = 0;
    
    
    _step = TKOperationStepReady;
    [self willChangeValueForKey:@"isReady"];
    _ready = YES;
    [self didChangeValueForKey:@"isReady"];
  }
  return self;
}



#pragma mark - Launch request

- (void)startAsynchronous
{
  [[[self class] operationQueue] addOperation:self];
}



#pragma mark - Request header

- (void)addValue:(NSString *)value forRequestHeader:(NSString *)header
{
  if ( [header length] > 0 ) {
    
    if ( value ) {
      [(NSMutableDictionary *)_headers setObject:value forKey:header];
    } else {
      [(NSMutableDictionary *)_headers removeObjectForKey:header];
    }
    
  }
}

- (void)setRequestHeaders:(NSDictionary *)headers
{
  [(NSMutableDictionary *)_headers removeAllObjects];
  
  for ( NSString *header in [headers keyEnumerator] ) {
    NSString *value = [headers objectForKey:header];
    [(NSMutableDictionary *)_headers setObject:value forKey:header];
  }
}


#pragma mark - Request body

- (void)setRequestBody:(NSData *)body
{
  _body = body;
}

- (void)setFormFields:(NSDictionary *)fields
{
  if ( [fields count] < 1 ) {
    return;
  }
  
  NSString *boundary = [NSString UUIDString];
  
  [self addValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary]
forRequestHeader:@"Content-Type"];
  
  
  NSMutableData *body = [[NSMutableData alloc] init];
  
  NSData *prefixData = [[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding];
  NSData *suffixData = [[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding];
  
  
  for ( NSString *name in fields ) {
    
    [body appendData:prefixData];
    
    id value = [fields objectForKey:name];
    
    if ( [value isKindOfClass:[NSDictionary class]] ) {
      
      NSString *filename = value[ @"filename" ];
      NSData *data = value[ @"data" ];
      
      NSMutableString *field = [[NSMutableString alloc] init];
      [field appendFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", name, filename];
      [field appendFormat:@"Content-Type: %@\r\n\r\n", [filename MIMEType]];
      
      [body appendData:[field dataUsingEncoding:NSUTF8StringEncoding]];
      [body appendData:data];
      [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
      
    } else {
      NSMutableString *field = [[NSMutableString alloc] init];
      [field appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", name];
      [field appendFormat:@"%@\r\n", value];
      
      [body appendData:[field dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
  }
  
  [body appendData:suffixData];
  
  _body = body;
  TKPRINT(@"body length: %d", [_body length]);
}



#pragma mark - NSOperation

- (void)start
{
  if ( [self isCancelled] ) {
    [self willChangeValueForKey:@"isFinished"];
    _finished = YES;
    [self didChangeValueForKey:@"isFinished"];
    return;
  }
  
  if ( [self isExecuting] ) {
    return;
  }
  
  if ( [self isFinished] ) {
    return;
  }
  
  if ( [self isReady] ) {
    [self performSelector:@selector(main)
                 onThread:[[self class] operationThread]
               withObject:nil
            waitUntilDone:YES
                    modes:@[ _runLoopMode ]];
  }
}

- (void)cancel
{
  if ( [self isCancelled] ) {
    return;
  }
  
  if ( [self isFinished] ) {
    return;
  }
  
  if ( [self isReady] ) {
  }
  
  if ( [self isExecuting] ) {
    
    [_connection cancel];
    _connection = nil;
    
    _response = nil;
    _responseData = nil;
    //_responseFilePath = nil;
    [_responseFileHandle closeFile];
    _responseFileHandle = nil;
    [[NSFileManager defaultManager] removeItemAtPath:_responseFilePath error:NULL];
    
    [self notifyObserversOperationDidFail];
    
    
    [self willChangeValueForKey:@"isFinished"];
    [self willChangeValueForKey:@"isExecuting"];
    _executing = NO;
    _finished = YES;
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
    
    [self stopUsingNetwork];
  }
  
  [super cancel];
}


- (void)main
{
  @autoreleasepool {
    
    if ( ![self isCancelled] ) {
      
      [self startUsingNetwork];
      
      [self notifyObserversOperationDidStart];
      
      
      _step = TKOperationStepExecuting;
      [self willChangeValueForKey:@"isExecuting"];
      [self willChangeValueForKey:@"isReady"];
      _ready = NO;
      _executing = YES;
      [self didChangeValueForKey:@"isReady"];
      [self didChangeValueForKey:@"isExecuting"];
      
      
      NSURLRequest *request = [self buildRequest];
      
      _connection = [[NSURLConnection alloc] initWithRequest:request
                                                    delegate:self
                                            startImmediately:NO];
      [_connection scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:_runLoopMode];
      [_connection start];
    }
    
  }
}



#pragma mark - NSURLConnectionDataDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
  _response = response;
  
  if ( _responseFilePath ) {
    [[NSFileManager defaultManager] createFileAtPath:_responseFilePath contents:[NSData data] attributes:nil];
    _responseFileHandle = [NSFileHandle fileHandleForUpdatingAtPath:_responseFilePath];
  } else {
    _responseData = [[NSMutableData alloc] init];
  }
  
  NSDictionary *headers = [(NSHTTPURLResponse *)_response allHeaderFields];
  _bytesRead = 0;
  _totalBytesRead = 0;
  _totalBytesExpectedToRead = [headers[ @"Content-Length" ] intValue];
  TKPRINT(@"%d %d/%d", _bytesRead, _totalBytesRead, _totalBytesExpectedToRead);
  [self notifyObserversOperationDidUpdate];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
  if ( _responseFileHandle ) {
    [_responseFileHandle seekToEndOfFile];
    [_responseFileHandle writeData:data];
    [_responseFileHandle synchronizeFile];
  } else {
    [(NSMutableData *)_responseData appendData:data];
  }
  
  _bytesRead = [data length];
  _totalBytesRead += _bytesRead;
  //_totalBytesExpectedToRead = 0;
  TKPRINT(@"READ: %d %d/%d", _bytesRead, _totalBytesRead, _totalBytesExpectedToRead);
  [self notifyObserversOperationDidUpdate];
}

- (void)connection:(NSURLConnection *)connection
   didSendBodyData:(NSInteger)bytesWritten
 totalBytesWritten:(NSInteger)totalBytesWritten
totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
{
  _bytesWritten = bytesWritten;
  _totalBytesWritten = totalBytesWritten;
  _totalBytesExpectedToWrite = totalBytesExpectedToWrite;
  TKPRINT(@"WRITE: %d %d/%d", _bytesWritten, _totalBytesWritten, _totalBytesExpectedToWrite);
  [self notifyObserversOperationDidUpdate];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
  TKPRINTMETHOD();
  
  [_responseFileHandle closeFile];
  _responseFileHandle = nil;
  
  _connection = nil;
  
  [self notifyObserversOperationDidFinish];
  
  
  _step = TKOperationStepFinished;
  [self willChangeValueForKey:@"isFinished"];
  [self willChangeValueForKey:@"isExecuting"];
  _executing = NO;
  _finished = YES;
  [self didChangeValueForKey:@"isExecuting"];
  [self didChangeValueForKey:@"isFinished"];
  
  [self stopUsingNetwork];
}

//- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response { return nil; }
//- (NSInputStream *)connection:(NSURLConnection *)connection needNewBodyStream:(NSURLRequest *)request { return nil; }
//
//- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse { return nil; }



#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
  TKPRINTMETHOD();
  
  _response = nil;
  _responseData = nil;
  //_responseFilePath = nil;
  [_responseFileHandle closeFile];
  _responseFileHandle = nil;
  [[NSFileManager defaultManager] removeItemAtPath:_responseFilePath error:NULL];
  
  _connection = nil;
  
  [self notifyObserversOperationDidFail];
  
  
  _step = TKOperationStepFinished;
  [self willChangeValueForKey:@"isFinished"];
  [self willChangeValueForKey:@"isExecuting"];
  _executing = NO;
  _finished = YES;
  [self didChangeValueForKey:@"isExecuting"];
  [self didChangeValueForKey:@"isFinished"];
  
  [self stopUsingNetwork];
}

//- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {}
//- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace { return NO; }
//- (void)connection:(NSURLConnection *)connection didCancelAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {}
//- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {}
//- (BOOL)connectionShouldUseCredentialStorage:(NSURLConnection *)connection { return NO; }

@end
