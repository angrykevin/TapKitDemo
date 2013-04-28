//
//  TKOperation.m
//  TapKitDemo
//
//  Created by Wu Kevin on 4/28/13.
//  Copyright (c) 2013 Telligenty. All rights reserved.
//

#import "TKOperation.h"

@implementation TKOperation



#pragma mark - NSOperation

- (void)cancel
{
  if ( [self isCancelled] ) {
    return;
  }
  
  if ( [self isFinished] ) {
    return;
  }
  
  [self willChangeValueForKey:@"isCancelled"];
  _cancelled = YES;
  [self didChangeValueForKey:@"isCancelled"];
  
  [super cancel];
}

- (BOOL)isReady
{
  return ( (_ready) && [super isReady] );
}

- (BOOL)isExecuting
{
  return ( _executing );
}

- (BOOL)isFinished
{
  return ( _finished );
}

- (BOOL)isCancelled
{
  return _cancelled;
}

- (BOOL)isConcurrent
{
  return YES;
}



#pragma mark - Public

- (void)notifyObserversOperationDidStart
{
  if ( _notifyOnMainThread ) {
    
    dispatch_sync(dispatch_get_main_queue(), ^{
      _didStartBlock(self);
      for ( id object in _observers ) {
        if ( [object respondsToSelector:@selector(operationDidStart:)] ) {
          [object operationDidStart:self];
        }
      }
    });
    
  } else {
    
    _didStartBlock(self);
    for ( id object in _observers ) {
      if ( [object respondsToSelector:@selector(operationDidStart:)] ) {
        [object operationDidStart:self];
      }
    }
    
  }
}

- (void)notifyObserversOperationDidUpdate
{
  if ( _notifyOnMainThread ) {
    
    dispatch_sync(dispatch_get_main_queue(), ^{
      _didUpdateBlock(self);
      for ( id object in _observers ) {
        if ( [object respondsToSelector:@selector(operationDidUpdate:)] ) {
          [object operationDidUpdate:self];
        }
      }
    });
    
  } else {
    
    _didUpdateBlock(self);
    for ( id object in _observers ) {
      if ( [object respondsToSelector:@selector(operationDidUpdate:)] ) {
        [object operationDidUpdate:self];
      }
    }
    
  }
}

- (void)notifyObserversOperationDidFail
{
  if ( _notifyOnMainThread ) {
    
    dispatch_sync(dispatch_get_main_queue(), ^{
      _didFailBlock(self);
      for ( id object in _observers ) {
        if ( [object respondsToSelector:@selector(operationDidFail:)] ) {
          [object operationDidFail:self];
        }
      }
    });
    
  } else {
    
    _didFailBlock(self);
    for ( id object in _observers ) {
      if ( [object respondsToSelector:@selector(operationDidFail:)] ) {
        [object operationDidFail:self];
      }
    }
    
  }
}

- (void)notifyObserversOperationWillFinish
{
  if ( _notifyOnMainThread ) {
    
    dispatch_sync(dispatch_get_main_queue(), ^{
      _willFinishBlock(self);
      for ( id object in _observers ) {
        if ( [object respondsToSelector:@selector(operationWillFinish:)] ) {
          [object operationWillFinish:self];
        }
      }
    });
    
  } else {
    
    _willFinishBlock(self);
    for ( id object in _observers ) {
      if ( [object respondsToSelector:@selector(operationWillFinish:)] ) {
        [object operationWillFinish:self];
      }
    }
    
  }
}

- (void)notifyObserversOperationDidFinish
{
  if ( _notifyOnMainThread ) {
    
    dispatch_sync(dispatch_get_main_queue(), ^{
      _didFinishBlock(self);
      for ( id object in _observers ) {
        if ( [object respondsToSelector:@selector(operationDidFinish:)] ) {
          [object operationDidFinish:self];
        }
      }
    });
    
  } else {
    _didFinishBlock(self);
    for ( id object in _observers ) {
      if ( [object respondsToSelector:@selector(operationDidFinish:)] ) {
        [object operationDidFinish:self];
      }
    }
  }
}



#pragma mark - TKObserverProtocol

- (NSMutableArray *)observerArray
{
  if ( _observers == nil ) {
    _observers = TKCreateWeakMutableArray();
  }
  return _observers;
}

- (id)addObserver:(id)observer
{
  return [[self observerArray] addUnidenticalObjectIfNotNil:observer];
}

- (void)removeObserver:(id)observer
{
  [[self observerArray] removeObjectIdenticalTo:observer];
}

- (void)removeAllObserver
{
  [[self observerArray] removeAllObjects];
}

@end
