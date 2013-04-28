//
//  TKObserverProtocol.h
//  TapKitDemo
//
//  Created by Wu Kevin on 4/28/13.
//  Copyright (c) 2013 Telligenty. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol TKObserverProtocol <NSObject>

- (NSMutableArray *)observerArray;
- (id)addObserver:(id)observer;
- (void)removeObserver:(id)observer;
- (void)removeAllObserver;

@end
