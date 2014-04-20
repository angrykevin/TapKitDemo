//
//  TBCommon.h
//  Teemo
//
//  Created by Wu Kevin on 12/19/13.
//  Copyright (c) 2013 xbcx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef void (^TBOperationCompletionHandler)(id result, NSError *error);

typedef void(^TBValueChangedHandler)(id newValue);


#define TBEllipsisMark @"\u2026"


#ifdef __cplusplus
extern "C" {
#endif


UIImage *TBCreateImage(NSString *name);
UIImage *TBCachedImage(NSString *name);

void TBPresentMessage(NSString *message);

NSString *TBFormatDate(NSDate *date);

NSString *TBMergeString(NSString *first, NSString *second);

void TBSaveRefreshDateForKey(NSString *key, NSDate *date);
NSDate *TBRefreshDateForKey(NSString *key);


#ifdef __cplusplus
}
#endif
