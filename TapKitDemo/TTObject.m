//
//  TTObject.m
//  TapKitDemo
//
//  Created by Wu Kevin on 7/1/13.
//  Copyright (c) 2013 Telligenty. All rights reserved.
//

#import "TTObject.h"

@implementation TTObject

- (id)init
{
    self = [super init];
    if ( self ) {
        static int count = 0;
        count++;
        TKPRINT(@"%d", count);
    }
    return self;
}

+ (TTObject *)sharedObject
{
    static TTObject *object = nil;
    
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        object = [[self alloc] init];
    });
    
    return object;
}

@end
