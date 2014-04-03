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
  UILabel *label = [[UILabel alloc] init];
  label.font = font;
  label.textColor = textColor;
  label.textAlignment = textAlignment;
  label.lineBreakMode = lineBreakMode;
  label.numberOfLines = ((numberOfLines>=0) ? numberOfLines : 0);
  label.backgroundColor = ((backgroundColor) ? backgroundColor : [UIColor clearColor]);
  label.adjustsFontSizeToFitWidth = NO;
  return label;
}

@end
