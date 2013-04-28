//
//  TKNAIManager.m
//  TapKitDemo
//
//  Created by Wu Kevin on 4/25/13.
//  Copyright (c) 2013 Telligenty. All rights reserved.
//

#import "TKNAIManager.h"


@implementation TKNAIManager



#pragma mark - Memory

- (id)init
{
  self = [super init];
  if ( self ) {
    
    _networkUsers = TKCreateWeakMutableArray();
    
    _lock = [[NSLock alloc] init];
    
  }
  return self;
}



#pragma mark - Public

+ (TKNAIManager *)sharedObject
{
  static TKNAIManager *NAIManager = nil;
  if ( NAIManager == nil ) {
    NAIManager = [[TKNAIManager alloc] init];
  }
  return NAIManager;
}


- (BOOL)isNetworkUser:(id)user
{
  [_lock lock];
  
  BOOL result = [_networkUsers hasObjectIdenticalTo:user];
  
  [_lock unlock];
  
  return result;
}


- (void)addNetworkUser:(id)user
{
  [_lock lock];
  
  [_networkUsers addUnidenticalObjectIfNotNil:user];
  [UIApplication sharedApplication].networkActivityIndicatorVisible = TKIsArrayWithItems(_networkUsers);
  
  [_lock unlock];
}

- (void)removeNetworkUser:(id)user
{
  [_lock lock];
  
  [_networkUsers removeObjectIdenticalTo:user];
  [UIApplication sharedApplication].networkActivityIndicatorVisible = TKIsArrayWithItems(_networkUsers);
  
  [_lock unlock];
}

- (void)removeAllNetworkUsers
{
  [_lock lock];
  
  [_networkUsers removeAllObjects];
  [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
  
  [_lock unlock];
}

@end
