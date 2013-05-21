//
//  TKURLRequest.h
//  TapKitDemo
//
//  Created by Wu Kevin on 5/21/13.
//  Copyright (c) 2013 Telligenty. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TKURLRequest : NSMutableURLRequest {
  NSString *_address;
  NSString *_method;
  
  NSMutableDictionary *_headers;
  NSData *_body;
  NSString *_boundary;
}

- (id)initWithAddress:(NSString *)address;

- (void)addHeader:(NSString *)header value:(NSString *)value;

- (void)addBody:(NSData *)body;

@end
