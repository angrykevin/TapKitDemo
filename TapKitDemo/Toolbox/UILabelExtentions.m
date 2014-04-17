//
//  UILabelExtentions.m
//  Teemo
//
//  Created by Wu Kevin on 9/4/13.
//  Copyright (c) 2013 xbcx. All rights reserved.
//

#import "UILabelExtentions.h"

@implementation UILabel (Extentions)

+ (id)labelWithFont:(UIFont *)font
          textColor:(UIColor *)textColor
      textAlignment:(NSTextAlignment)textAlignment
      lineBreakMode:(NSLineBreakMode)lineBreakMode
      numberOfLines:(NSInteger)numberOfLines
    backgroundColor:(UIColor *)backgroundColor
{
  UILabel *label = [[self alloc] init];
  label.font = font;
  label.textColor = ((textColor) ? textColor : [UIColor blackColor]);
  label.textAlignment = ((textAlignment==0) ? NSTextAlignmentLeft : textAlignment);
  label.lineBreakMode = ((lineBreakMode==0) ? NSLineBreakByWordWrapping : lineBreakMode);
  label.numberOfLines = ((numberOfLines>=0) ? numberOfLines : 0);
  label.backgroundColor = ((backgroundColor) ? backgroundColor : [UIColor clearColor]);
  label.adjustsFontSizeToFitWidth = NO;
  return label;
}

@end
