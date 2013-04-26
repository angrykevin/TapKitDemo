//
//  TKCoreCommon.h
//  TapKitDemo
//
//  Created by Wu Kevin on 4/25/13.
//  Copyright (c) 2013 Telligenty. All rights reserved.
//

#import <Foundation/Foundation.h>

///-------------------------------
/// Version
///-------------------------------

NSComparisonResult TKCompareVersion(NSString *ver1, NSString *ver2);

NSInteger TKMajorVersion(NSString *ver);

NSInteger TKMinorVersion(NSString *ver);

NSInteger TKBugfixVersion(NSString *ver);


///-------------------------------
/// System paths
///-------------------------------

NSString *TKPathForBundleResource(NSBundle *bundle, NSString *relativePath);

NSString *TKPathForDocumentsResource(NSString *relativePath);

NSString *TKPathForLibraryResource(NSString *relativePath);

NSString *TKPathForCachesResource(NSString *relativePath);


///-------------------------------
/// Weak collections
///-------------------------------

NSMutableArray *TKCreateWeakMutableArray();

NSMutableDictionary *TKCreateWeakMutableDictionary();

NSMutableSet *TKCreateWeakMutableSet();


///-------------------------------
/// Object validity
///-------------------------------

BOOL TKIsInstance(id object, Class cls);


BOOL TKIsStringWithText(id object);

BOOL TKIsDataWithBytes(id object);

BOOL TKIsArrayWithItems(id object);

BOOL TKIsDictionaryWithItems(id object);

BOOL TKIsSetWithItems(id object);


///-------------------------------
/// Internet date
///-------------------------------

NSDateFormatter *TKInternetDateFormatter();

NSDate *TKDateFromInternetDateString(NSString *string);

NSString *TKInternetDateStringFromDate(NSDate *date);
