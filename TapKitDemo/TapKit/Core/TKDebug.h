//
//  TKDebug.h
//  TapKit
//
//  Created by Wu Kevin on 4/26/13.
//  Copyright (c) 2013 Telligenty. All rights reserved.
//

#ifdef __cplusplus
extern "C" {
#endif


#ifdef DEBUG
#define TKPRINT(_fmt_, ...) NSLog(@"%s: "_fmt_, __PRETTY_FUNCTION__, ##__VA_ARGS__)
#else
#define TKPRINT(_fmt_, ...) ((void)0)
#endif // #ifdef DEBUG


#ifdef DEBUG
#define TKPRINTMETHOD() NSLog(@"%s", __PRETTY_FUNCTION__)
#else
#define TKPRINTMETHOD() ((void)0)
#endif // #ifdef DEBUG


#ifdef DEBUG
#define TKTESTVALUE(_inf_, _vlu_) NSLog(@"%s: %@ is %@", __PRETTY_FUNCTION__, (_inf_), ((_vlu_) ? @"YES" : @"NO"))
#else
#define TKTESTVALUE(_inf_, _vlu_) ((void)0)
#endif // #ifdef DEBUG


#ifdef __cplusplus
}
#endif
