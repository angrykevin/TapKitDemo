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
  
  
  NSMutableData *data = [[NSMutableData alloc] init];
  
  
  NSString *prefixString = [[NSString alloc] initWithFormat:@"--%@\r\n", boundary];
  NSData *prefixData = [prefixString dataUsingEncoding:NSUTF8StringEncoding];
  
  NSString *suffixString = [[NSString alloc] initWithFormat:@"\r\n--%@--\r\n", boundary];
  NSData *suffixData = [suffixString dataUsingEncoding:NSUTF8StringEncoding];
  
  
  // Begin
  [data appendData:prefixData];
  
  int index = 1;
  
  for ( NSString *key in fields ) {
    
    id value = [fields objectForKey:key];
    
    if ( [value isKindOfClass:[UIImage class]] ) {
      NSString *name = [[NSString alloc] initWithFormat:@"image%d.png", index];
      index++;
      
      NSString *fmt = @"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n";
      NSString *disposition = [[NSString alloc] initWithFormat:fmt, key, name];
      NSData *dispositionData = [disposition dataUsingEncoding:NSUTF8StringEncoding];
      [data appendData:dispositionData];
      
      NSString *type = @"Content-Type: image/png\r\nContent-Transfer-Encoding: binary\r\n\r\n";
      NSData *typeData = [type dataUsingEncoding:NSUTF8StringEncoding];
      [data appendData:typeData];
      
      NSData *imageData = UIImagePNGRepresentation((UIImage *)value);
      [data appendData:imageData];
      
    } else if ( [value isKindOfClass:[NSData class]] ) {
      NSString *fmt = @"Content-Disposition: form-data; name=\"%@\"\r\n";
      NSString *disposition = [[NSString alloc] initWithFormat:fmt, key];
      NSData *dispositionData = [disposition dataUsingEncoding:NSUTF8StringEncoding];
      [data appendData:dispositionData];
      
      NSString *type = @"Content-Type: content/unknown\r\nContent-Transfer-Encoding: binary\r\n\r\n";
      NSData *typeData = [type dataUsingEncoding:NSUTF8StringEncoding];
      [data appendData:typeData];
      
      [data appendData:(NSData *)value];
      
    } else {
      NSString *fmt = @"Content-Disposition: form-data; name=\"%@\"\r\n\r\n%@\r\n";
      NSString *disposition = [[NSString alloc] initWithFormat:fmt, key, value];
      NSData *dispositionData = [disposition dataUsingEncoding:NSUTF8StringEncoding];
      [data appendData:dispositionData];
    }
    
    [data appendData:suffixData];
    
  }
  
  _body = data;
}

@end
