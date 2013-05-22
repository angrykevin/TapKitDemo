//
//  TKURLRequest.m
//  TapKitDemo
//
//  Created by Wu Kevin on 5/21/13.
//  Copyright (c) 2013 Telligenty. All rights reserved.
//

#import "TKURLRequest.h"

@implementation TKURLRequest


#pragma mark - Creating request

- (id)initWithAddress:(NSString *)address
{
  self = [super init];
  if ( self ) {
    _address = address;
    _method = @"GET";
    
    _headers = nil;
    _body = nil;
  }
  return self;
}



#pragma mark - Accessing request data

- (void)addValue:(NSString *)value forHeader:(NSString *)header
{
  if ( [header length] > 0 ) {
    
    if ( _headers == nil ) {
      _headers = [[NSMutableDictionary alloc] init];
    }
    
    if ( value ) {
      [_headers setObject:value forKey:_headers];
    } else {
      [_headers removeObjectForKey:header];
    }
    
  }
}

- (void)addFormFields:(NSDictionary *)fields
{
  if ( [fields count] < 1 ) {
    return;
  }
  
  NSString *boundary = [NSString UUIDString];
  
  
  // Set boundary header
  NSString *header = @"Content-Type";
  NSString *value = [[NSString alloc] initWithFormat:@"multipart/form-data; boundary=%@", boundary];
  [self addValue:value forHeader:header];
  
  
  NSMutableData *body = [[NSMutableData alloc] init];
  
  
  NSString *prefixString = [[NSString alloc] initWithFormat:@"--%@\r\n", boundary];
  NSData *prefixData = [prefixString dataUsingEncoding:NSUTF8StringEncoding];
  
  NSString *suffixString = [[NSString alloc] initWithFormat:@"--%@--\r\n", boundary];
  NSData *suffixData = [suffixString dataUsingEncoding:NSUTF8StringEncoding];
  
  
  for ( NSString *name in fields ) {
    
    [body appendData:prefixData];
    
    id value = [fields objectForKey:name];
    
    if ( [value isKindOfClass:[NSDictionary class]] ) {
      
      NSString *filename = value[ @"filename" ];
      NSData *data = value[ @"data" ];
      
      NSMutableString *disposition = [[NSMutableString alloc] init];
      [disposition appendFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", name, filename];
      [disposition appendFormat:@"Content-Type: %@\r\n\r\n", [filename MIMEType]];
      [body appendData:[disposition dataUsingEncoding:NSUTF8StringEncoding]];
      [body appendData:data];
      [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
      
    } else {
      NSMutableString *disposition = [[NSMutableString alloc] init];
      [disposition appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", name];
      [disposition appendFormat:@"%@\r\n", value];
      [body appendData:[disposition dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
  }
  
  [body appendData:suffixData];
  
  _body = body;
}

@end
