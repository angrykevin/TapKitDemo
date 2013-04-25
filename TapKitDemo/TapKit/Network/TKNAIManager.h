//
//  TKNAIManager.h
//  TapKitDemo
//
//  Created by Wu Kevin on 4/25/13.
//  Copyright (c) 2013 Telligenty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Core/Core.h"
#import "Additions/Additions.h"


@interface TKNAIManager : NSObject {
  
  NSMutableArray *_networkUsers;
  
  NSLock *_lock;
  
}

+ (TKNAIManager *)sharedObject;

- (void)addNetworkUser:(id)user;
- (void)removeNetworkUser:(id)user;
- (void)removeAllNetworkUsers;

- (BOOL)isNetworkUser:(id)user;

@end
