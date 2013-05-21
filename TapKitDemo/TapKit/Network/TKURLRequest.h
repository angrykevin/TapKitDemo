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
}

@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *method;

@property (nonatomic, strong) NSMutableDictionary *headers;
@property (nonatomic, strong) NSData *body;


///-------------------------------
/// Creating request
///-------------------------------

- (id)initWithAddress:(NSString *)address;


///-------------------------------
/// Accessing request data
///-------------------------------

- (void)addValue:(NSString *)value forHeader:(NSString *)header;

- (void)addFormFields:(NSDictionary *)fields;

@end
