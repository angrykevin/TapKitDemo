//
//  TKURLRequest.m
//  TapKitDemo
//
//  Created by Wu Kevin on 5/21/13.
//  Copyright (c) 2013 Telligenty. All rights reserved.
//

#import "TKURLRequest.h"

@implementation TKURLRequest


#pragma mark - NSObject

- (id)initWithAddress:(NSString *)address
{
  self = [super init];
  if ( self ) {
    _address = [address copy];
    _method = [@"GET" copy];
  }
  return self;
}

@end
