//
//  TKCoreCommon.m
//  TapKitDemo
//
//  Created by Wu Kevin on 4/25/13.
//  Copyright (c) 2013 Telligenty. All rights reserved.
//

#import "TKCoreCommon.h"

#pragma mark - Weak collections

NSMutableArray *TKCreateWeakMutableArray()
{
  return (__bridge_transfer NSMutableArray *)CFArrayCreateMutable(nil, 0, nil);
}

NSMutableDictionary *TKCreateWeakMutableDictionary()
{
  return (__bridge_transfer NSMutableDictionary *)CFDictionaryCreateMutable(nil, 0, nil, nil);
}

NSMutableSet *TKCreateWeakMutableSet()
{
  return (__bridge_transfer NSMutableSet *)CFSetCreateMutable(nil, 0, nil);
}
