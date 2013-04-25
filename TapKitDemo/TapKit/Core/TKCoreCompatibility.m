//
//  TKCoreCompatibility.m
//  TapKitDemo
//
//  Created by Wu Kevin on 4/25/13.
//  Copyright (c) 2013 Telligenty. All rights reserved.
//

#import "TKCoreCompatibility.h"
#include <sys/sysctl.h>

NSString *TKCurrentDevicePlatform()
{
  char buffer[128];
  bzero(buffer, 128);
  
  size_t size = 128;
  
  sysctlbyname("hw.machine", buffer, &size, NULL, 0);
  
  return [NSString stringWithCString:buffer encoding:NSUTF8StringEncoding];
}

TKDeviceModel TKCurrentDeviceModel()
{
  NSString *platform = TKCurrentDevicePlatform();
  
  if ( [platform isEqualToString:@"iPhone1,1"] ) return TKDeviceModelPhone2G;
  if ( [platform isEqualToString:@"iPhone1,2"] ) return TKDeviceModelPhone3G;
  if ( [platform isEqualToString:@"iPhone2,1"] ) return TKDeviceModelPhone3GS;
  if ( [platform isEqualToString:@"iPhone3,1"] ) return TKDeviceModelPhone4;
  if ( [platform isEqualToString:@"iPhone3,2"] ) return TKDeviceModelPhone4;
  if ( [platform isEqualToString:@"iPhone3,3"] ) return TKDeviceModelPhone4;
  if ( [platform isEqualToString:@"iPhone4,1"] ) return TKDeviceModelPhone4S;
  if ( [platform isEqualToString:@"iPhone5,1"] ) return TKDeviceModelPhone5;
  if ( [platform isEqualToString:@"iPhone5,2"] ) return TKDeviceModelPhone5;
  
  if ( [platform isEqualToString:@"iPod1,1"] ) return TKDeviceModelPod1G;
  if ( [platform isEqualToString:@"iPod2,1"] ) return TKDeviceModelPod2G;
  if ( [platform isEqualToString:@"iPod3,1"] ) return TKDeviceModelPod3G;
  if ( [platform isEqualToString:@"iPod4,1"] ) return TKDeviceModelPod4G;
  if ( [platform isEqualToString:@"iPod5,1"] ) return TKDeviceModelPod5G;
  
  if ( [platform isEqualToString:@"iPad1,1"] ) return TKDeviceModelPad1G;
  if ( [platform isEqualToString:@"iPad2,1"] ) return TKDeviceModelPad2;
  if ( [platform isEqualToString:@"iPad2,2"] ) return TKDeviceModelPad2;
  if ( [platform isEqualToString:@"iPad2,3"] ) return TKDeviceModelPad2;
  if ( [platform isEqualToString:@"iPad2,4"] ) return TKDeviceModelPad2;
  if ( [platform isEqualToString:@"iPad2,5"] ) return TKDeviceModelPadMini1G;
  if ( [platform isEqualToString:@"iPad2,6"] ) return TKDeviceModelPadMini1G;
  if ( [platform isEqualToString:@"iPad2,7"] ) return TKDeviceModelPadMini1G;
  if ( [platform isEqualToString:@"iPad3,1"] ) return TKDeviceModelPad3;
  if ( [platform isEqualToString:@"iPad3,2"] ) return TKDeviceModelPad3;
  if ( [platform isEqualToString:@"iPad3,3"] ) return TKDeviceModelPad3;
  if ( [platform isEqualToString:@"iPad3,4"] ) return TKDeviceModelPad4;
  if ( [platform isEqualToString:@"iPad3,5"] ) return TKDeviceModelPad4;
  if ( [platform isEqualToString:@"iPad3,6"] ) return TKDeviceModelPad4;
  
  return TKDeviceModelUnknow;
}

TKDeviceFamily TKCurrentDeviceFamily()
{
  NSString *platform = TKCurrentDevicePlatform();
  
  if ( [platform hasPrefix:@"iPhone"] ) return TKDeviceFamilyPhone;
  if ( [platform hasPrefix:@"iPod"] ) return TKDeviceFamilyPod;
  if ( [platform hasPrefix:@"iPad"] ) return TKDeviceFamilyPad;
  
  return TKDeviceFamilyUnknown;
}


BOOL TKIsRetina()
{
  UIScreen *screen = [UIScreen mainScreen];
  return ( screen.scale == 2.0f );
}

BOOL TKIsPad()
{
  UIDevice *device = [UIDevice currentDevice];
  return ( device.userInterfaceIdiom == UIUserInterfaceIdiomPad );
}

BOOL TKIsPhone()
{
  UIDevice *device = [UIDevice currentDevice];
  return ( device.userInterfaceIdiom == UIUserInterfaceIdiomPhone );
}
