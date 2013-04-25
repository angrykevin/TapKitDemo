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

//- (void)addNetworkUser:(id)user
//{
//  [_lock lock];
//  
//  if ( [_networkUsers indexOfObjectIdenticalTo:user] == NSNotFound ) {
//    [_networkUsers addObject:user];
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
//  }
//  
//  [_lock unlock];
//}
//
//- (void)removeNetworkUser:(id)user
//{
//  @synchronized (self) {
//    [_networkUsers removeObjectIdenticalTo:user];
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = TTIsArrayWithItems(_networkUsers);
//  }
//}
//
//- (void)removeAllNetworkUsers
//{
//  @synchronized (self) {
//    [_networkUsers removeAllObjects];
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//  }
//}
//
//- (BOOL)isNetworkUser:(id)user
//{
//  return ( [_networkUsers indexOfObjectIdenticalTo:user] != NSNotFound );
//}

@end
