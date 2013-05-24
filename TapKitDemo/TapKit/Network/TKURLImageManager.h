//
//  TKURLImageManager.h
//  TapKitDemo
//
//  Created by Wu Kevin on 5/24/13.
//  Copyright (c) 2013 Telligenty. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TKURLImageManager : NSObject {
  NSMutableDictionary *_items;
}

+ (TKURLImageManager *)sharedObject;

- (void)loadImageWithAddress:(NSString *)address
        cacheTimeoutInterval:(NSTimeInterval)cacheTimeoutInterval
                      target:(id)target
                     success:(SEL)success
                     failure:(SEL)failure
                failureImage:(UIImage *)failureImage;

@end

