//
//  TBImageExpandView.m
//  Teemo
//
//  Created by Wu Kevin on 4/2/14.
//  Copyright (c) 2014 Telligenty. All rights reserved.
//

#import "TBImageExpandView.h"
#import "TBActionSheet.h"
#import "MBProgressHUD/MBProgressHUDExtentions.h"
#import "SDWebImage/UIImageView+WebCache.h"


@implementation TBImageExpandView

- (id)initWithItem:(NSDictionary *)item
{
  self = [super init];
  if (self) {
    
    self.backgroundColor = [UIColor blackColor];
    self.clipsToBounds = YES;
    
    
    _item = item;
    
    _startLoadingAfterPresented = YES;
    
    
    _imageView = [[UIImageView alloc] init];
    _imageView.backgroundColor = [UIColor clearColor];
    _imageView.clipsToBounds = YES;
    _imageView.userInteractionEnabled = NO;
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_imageView];
    
    
    _longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    _longPressGestureRecognizer.cancelsTouchesInView = NO;
    [self addGestureRecognizer:_longPressGestureRecognizer];
    
    _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    _tapGestureRecognizer.cancelsTouchesInView = NO;
    [self addGestureRecognizer:_tapGestureRecognizer];
    
    
  }
  return self;
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  TKPRINTMETHOD();
  _imageView.frame = self.bounds;
  
}

- (void)dealloc
{
  if ( [_item objectForKey:@"image"] == nil ) {
    NSString *imageURL = [_item objectForKey:@"imageURL"];
    if ( [imageURL length] > 0 ) {
      SDWebImageManager *manager = [SDWebImageManager sharedManager];
      [manager.imageCache removeImageForKey:imageURL fromDisk:NO];
    }
  }
}


- (void)longPress:(UIGestureRecognizer *)gestureRecognizer
{
  if ( _imageView.image ) {
    if ( _actionSheet == nil ) {
      __weak typeof(self) weakSelf = self;
      _actionSheet = [[TBActionSheet alloc] initWithTitle:@""];
      [_actionSheet addButtonWithTitle:NSLocalizedString(@"保存到相册", @"") block:^{ [weakSelf saveImageToAlbum]; }];
      [_actionSheet addCancelButtonWithTitle:NSLocalizedString(@"取消", @"") block:NULL];
    }
    [_actionSheet showInView:self];
  }
}

- (void)tap:(UIGestureRecognizer *)gestureRecognizer
{
  [UIView animateWithDuration:0.2
                   animations:^{
                     self.alpha = 0.0;
                   }
                   completion:^(BOOL finished) {
                     [self removeFromSuperview];
                   }];
}

- (void)saveImageToAlbum
{
  [MBProgressHUD showHUD:self info:NSLocalizedString(@"保存中\u2026", @"")];
  
  UIImage *image = _imageView.image;
  
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
  });
  
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
  if ( error != nil ) {
    [MBProgressHUD showAndHideHUD:self
                             info:NSLocalizedString(@"保存失败", @"")
                 createIfNonexist:YES
                  completionBlock:NULL];
  } else {
    [MBProgressHUD showAndHideHUD:self
                             info:NSLocalizedString(@"保存成功", @"")
                 createIfNonexist:YES
                  completionBlock:NULL];
  }
}

- (void)showActivityIndicatorView
{
  if ( _activityIndicatorView == nil ) {
    _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _activityIndicatorView.hidesWhenStopped = NO;
    [_activityIndicatorView startAnimating];
  }
  
  if ( _activityIndicatorView.superview != self ) {
    [_activityIndicatorView removeFromSuperview];
    [self addSubview:_activityIndicatorView];
  }
  
  [_activityIndicatorView moveToCenterOfSuperview];
  
}

- (void)hideActivityIndicatorView
{
  [_activityIndicatorView removeFromSuperview];
}



- (void)presentInView:(UIView *)inView fromView:(UIView *)fromView
{
  CGRect from = [inView convertRect:fromView.bounds fromView:fromView];
  [inView addSubview:self];
  self.frame = from;
  
//  [UIView animateWithDuration:5.0
//                   animations:^{
//                     self.frame = inView.bounds;
//                   }];
  
  NSValue *fromValue = [NSValue valueWithCGRect:from];
  NSValue *toValue = [NSValue valueWithCGRect:inView.bounds];
  
  CABasicAnimation *animation = [CABasicAnimation animation];
  animation.fromValue = fromValue;
  animation.toValue = toValue;
//  CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"frame"];
//  animation.calculationMode = kCAAnimationDiscrete;
  animation.autoreverses = NO;
  animation.fillMode = kCAFillModeForwards;
  animation.duration = 5.0;
  [self.layer addAnimation:animation forKey:@"frame"];
  
}

- (void)startLoading
{
  [_imageView cancelCurrentImageLoad];
  _imageView.image = nil;
  
  if ( [_item count] <= 0 ) {
    return;
  }
  
  UIImage *image = [_item objectForKey:@"image"];
  if ( image ) {
    _imageView.image = image;
  } else {
    NSString *imageURL = [_item objectForKey:@"imageURL"];
    UIImage *placeholderImage = [_item objectForKey:@"placeholderImage"];
    UIImage *errorImage = [_item objectForKey:@"errorImage"];
    if ( [imageURL length] > 0 ) {
      [self showActivityIndicatorView];
      __weak typeof(self) weakSelf = self;
      __weak UIImageView *imageView = _imageView;
      [_imageView setImageWithURL:[NSURL URLWithString:imageURL]
                 placeholderImage:placeholderImage
                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                          if ( error ) {
                            if ( errorImage ) {
                              imageView.image = errorImage;
                            } else {
                              imageView.image = placeholderImage;
                            }
                          }
                          [weakSelf hideActivityIndicatorView];
                        }];
    } else {
      if ( errorImage ) {
        _imageView.image = errorImage;
      } else {
        _imageView.image = placeholderImage;
      }
    }
  }
}

@end
