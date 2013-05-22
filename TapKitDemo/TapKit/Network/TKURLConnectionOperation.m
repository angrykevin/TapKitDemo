//
//  TKURLConnectionOperation.m
//  TapKitDemo
//
//  Created by Wu Kevin on 5/21/13.
//  Copyright (c) 2013 Telligenty. All rights reserved.
//

#import "TKURLConnectionOperation.h"

@implementation TKURLConnectionOperation

- (void)setFormFields:(NSDictionary *)fields
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
}

@end
