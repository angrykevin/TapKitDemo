//
//  TKCoreUI.h
//  TapKitDemo
//
//  Created by Wu Kevin on 4/26/13.
//  Copyright (c) 2013 Telligenty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

///-------------------------------
/// Autoresizing mask
///-------------------------------

extern const NSUInteger TKViewAutoresizingKeepSize;
extern const NSUInteger TKViewAutoresizingKeepMargin;


///-------------------------------
/// Image
///-------------------------------

NSString *TKDeviceSpecificImageName(NSString *name);
UIImage *TKLoadImage(id target, SEL selector, NSString *name);


///-------------------------------
/// Keyboard
///-------------------------------

BOOL TKIsKeyboardVisible();

UIView *TKFindFirstResponderInView(UIView *topView);


///-------------------------------
/// Orientation
///-------------------------------

UIDeviceOrientation TKDeviceOrientation();

UIInterfaceOrientation TKInterfaceOrientation();


BOOL TKIsDevicePortrait();

BOOL TKIsDeviceLandscape();

BOOL TKIsInterfacePortrait();

BOOL TKIsInterfaceLandscape();


BOOL TKIsSupportedOrientation(UIInterfaceOrientation orientation);

CGAffineTransform TKRotateTransformForOrientation(UIInterfaceOrientation orientation);

CGAffineTransform TKSupportedRotateTransformForOrientation(UIInterfaceOrientation orientation);
