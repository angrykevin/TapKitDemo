//
//  TTMainViewController.m
//  TapKitDemo
//
//  Created by Wu Kevin on 5/17/13.
//  Copyright (c) 2013 Telligenty. All rights reserved.
//

#import "TTMainViewController.h"
#import "Toolbox/TBImageExpandView.h"
#import "UIButton+WebCache.h"


@implementation TTMainViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  button.frame = CGRectMake(10, 10, 300, 40);
  [button addTarget:self action:@selector(doit1:) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:button];
  
  button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  button.frame = CGRectMake(10, 60, 300, 40);
  [button addTarget:self action:@selector(doit2:) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:button];
  
  button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  button.frame = CGRectMake(10, 110, 300, 40);
  [button addTarget:self action:@selector(doit3:) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:button];
  
  
//  _boxView = [[UIView alloc] init];
//  _boxView.backgroundColor = [UIColor lightGrayColor];
//  [self.view addSubview:_boxView];
//  _boxView.frame = CGRectMake(10.0, 160.0, 300.0, 300.0);
  
  _fromView = [[UIView alloc] init];
  _fromView.backgroundColor = [UIColor darkGrayColor];
  [self.view addSubview:_fromView];
  _fromView.frame = CGRectMake(10.0, 160.0, 50.0, 50.0);
  
  _button = [[UIButton alloc] init];
  _button.frame = CGRectMake(10.0, 160.0, 300.0, 300.0);
  [self.view addSubview:_button];
  
}

- (void)doit1:(id)sender
{
  UIImage *image = TBCreateImage(@"abc.jpg");
  NSString *imageURL = @"https://farm4.staticflickr.com/3763/13563838384_76866c48a6_k.jpg";
  UIImage *placeholderImage = TBCreateImage(@"placeholder.png");
  UIImage *errorImage = TBCreateImage(@"error.png");
  
  NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
  //[item setObject:image forKey:@"image"];
  [item setObject:imageURL forKey:@"imageURL"];
  [item setObject:placeholderImage forKey:@"placeholderImage"];
  //[item setObject:errorImage forKey:@"errorImage"];
  
  TBImageExpandView *expandView = [[TBImageExpandView alloc] initWithItem:item];
  [expandView presentInView:self.view fromView:_fromView];
  [expandView startLoading];
  
//  _time++;
//  
//  if ( (_time%2) == 1 ) {
//    NSLog(@"加载");
//    [_button setImageWithURL:[NSURL URLWithString:@"https://farm4.staticflickr.com/3763/13563838384_76866c48a6_k.jpg"]
//                    forState:UIControlStateNormal
//            placeholderImage:[UIImage imageNamed:@"btn.png"]
//                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
//                     NSLog(@"%@", image);
//                     NSLog(@"%@", error);
//                     if ( cacheType == SDImageCacheTypeDisk ) {
//                       NSLog(@"disk");
//                     } else if ( cacheType == SDImageCacheTypeMemory ) {
//                       NSLog(@"memory");
//                     } else if ( cacheType == SDImageCacheTypeNone ) {
//                       NSLog(@"none");
//                     }
//                   }];
//  } else {
//    NSLog(@"取消");
//    [_button cancelCurrentImageLoad];
//  }
}

- (void)doit2:(id)sender
{
  NSString *key = @"https://farm4.staticflickr.com/3763/13563838384_76866c48a6_k.jpg";
  [[SDWebImageManager sharedManager].imageCache removeImageForKey:key fromDisk:NO];
}

- (void)doit3:(id)sender
{
}

@end
