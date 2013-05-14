//
//  TKOperation.h
//  TapKitDemo
//
//  Created by Wu Kevin on 4/28/13.
//  Copyright (c) 2013 Telligenty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Core/Core.h"
#import "Additions/Additions.h"
#import "TKObserverProtocol.h"

typedef enum {
  TKOperationStepReady = 1,
  TKOperationStepExecuting,
  TKOperationStepFinished
} TKOperationStep;


typedef void(^TKOperationBlock)(id operation);


@interface TKOperation : NSOperation<TKObserverProtocol> {
  NSError *_error;
  TKOperationStep _step;
  
  BOOL _notifyOnMainThread;
  
  TKOperationBlock _didStartBlock;
  TKOperationBlock _didUpdateBlock;
  TKOperationBlock _didFailBlock;
  TKOperationBlock _didFinishBlock;
  
  BOOL _ready;
  BOOL _executing;
  BOOL _finished;
  BOOL _cancelled;
  
  NSMutableArray *_observers;
}

@property (nonatomic, strong) NSError *error;
@property (nonatomic, assign) TKOperationStep step;

@property (nonatomic, assign) BOOL notifyOnMainThread;

@property (nonatomic, copy) TKOperationBlock didStartBlock;
@property (nonatomic, copy) TKOperationBlock didUpdateBlock;
@property (nonatomic, copy) TKOperationBlock didFailBlock;
@property (nonatomic, copy) TKOperationBlock didFinishBlock;


///-------------------------------
/// Notify routines
///-------------------------------

- (void)notifyObserversOperationDidStart;
- (void)notifyObserversOperationDidUpdate;
- (void)notifyObserversOperationDidFail;
- (void)notifyObserversOperationDidFinish;

@end


@protocol TKOperationDelegate <NSObject>
@optional
- (void)operationDidStart:(TKOperation *)operation;
- (void)operationDidUpdate:(TKOperation *)operation;
- (void)operationDidFail:(TKOperation *)operation;
- (void)operationDidFinish:(TKOperation *)operation;
@end
