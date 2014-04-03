//
//  TBButton.m
//  Teemo
//
//  Created by Wu Kevin on 11/18/13.
//  Copyright (c) 2013 xbcx. All rights reserved.
//

#import "TBButton.h"

#define IMAGE_FRACTION (10.0)

@implementation TBButton

- (CGSize)sizeThatFits:(CGSize)size
{
  UIImage *image = self.normalBackgroundImage;
  if ( !image ) {
    return [super sizeThatFits:size];
  }
  
  CGSize labelSize = [self.normalTitle sizeWithFont:self.titleLabel.font];
  if ( image.size.width>IMAGE_FRACTION ) {
    return CGSizeMake(image.size.width-IMAGE_FRACTION+labelSize.width, image.size.height);
  }
  
  return CGSizeMake(image.size.width+labelSize.width, image.size.height);
}

@end
