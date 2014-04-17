//
//  TBExpandView.m
//  TapKitDemo
//
//  Created by Kevin on 4/16/14.
//  Copyright (c) 2014 Telligenty. All rights reserved.
//

#import "TBExpandView.h"

@implementation TBExpandView

- (instancetype)init
{
  self = [super init];
  if (self) {
    
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor blackColor];
    
    _imageView = [[UIImageView alloc] init];
    _imageView.backgroundColor = [UIColor clearColor];
    _imageView.image = TBCreateImage(@"abc.jpg");
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_imageView];
    
  }
  return self;
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  
  _imageView.frame = self.bounds;
  
}


- (void)present:(UIView *)view
{
  [view addSubview:self];
  
  self.frame = CGRectMake(110.0, 50.0, 100.0, 100.0);
  
//  [UIView animateWithDuration:1.0
//                   animations:^{
//                     self.frame = view.bounds;
//                   }];
  
//  CABasicAnimation *pulseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//  pulseAnimation.duration = 2.0;
//  pulseAnimation.toValue = [NSNumber numberWithFloat:2];
//  pulseAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//  pulseAnimation.autoreverses = NO;
//  pulseAnimation.repeatCount = 1;
//  [self.layer addAnimation:pulseAnimation forKey:nil];
  
  CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
  animation.toValue = [NSValue valueWithCGPoint:CGPointZero];
  animation.autoreverses = NO;
  animation.fillMode = kCAFillModeForwards;
  animation.duration = 5.0;
  animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
  [self.layer addAnimation:animation forKey:nil];
  
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
  [self removeFromSuperview];
}

@end
