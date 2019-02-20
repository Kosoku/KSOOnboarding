//
//  KSOOnboardingImageBackgroundView.m
//  KSOOnboarding-iOS
//
//  Created by William Towe on 9/7/18.
//  Copyright © 2018 Kosoku Interactive, LLC. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

#import "KSOOnboardingImageBackgroundView.h"

@interface KSOOnboardingImageBackgroundView ()
@property (strong,nonatomic) UIImageView *imageView;
@property (strong,nonatomic) UIVisualEffectView *blurVisualEffectView;
@property (strong,nonatomic) UIView *overlayView;
@end

@implementation KSOOnboardingImageBackgroundView

- (void)didAddSubview:(UIView *)subview {
    [super didAddSubview:subview];
    
    if (self.overlayView != nil) {
        [self bringSubviewToFront:self.overlayView];
    }
}

- (instancetype)initWithImage:(UIImage *)image {
    if (!(self = [super initWithFrame:CGRectZero]))
        return nil;
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _imageView.translatesAutoresizingMaskIntoConstraints = NO;
    _imageView.image = image;
    [self addSubview:_imageView];
    
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:@{@"view": _imageView}]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:@{@"view": _imageView}]];
    
    return self;
}

- (void)setBlurEffect:(UIBlurEffect *)blurEffect {
    _blurEffect = blurEffect;
    
    [self.blurVisualEffectView removeFromSuperview];
    
    if (_blurEffect != nil) {
        self.blurVisualEffectView = [[UIVisualEffectView alloc] initWithEffect:_blurEffect];
        self.blurVisualEffectView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.blurVisualEffectView];
        
        [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:@{@"view": self.blurVisualEffectView}]];
        [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:@{@"view": self.blurVisualEffectView}]];
    }
}
- (void)setOverlayColor:(UIColor *)overlayColor {
    _overlayColor = overlayColor;
    
    if (_overlayColor == nil) {
        [self.overlayView removeFromSuperview];
    }
    else {
        if (self.overlayView == nil) {
            self.overlayView = [[UIView alloc] initWithFrame:CGRectZero];
            self.overlayView.translatesAutoresizingMaskIntoConstraints = NO;
            [self addSubview:self.overlayView];
            
            [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:@{@"view": self.overlayView}]];
            [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:@{@"view": self.overlayView}]];
        }
        
        self.overlayView.backgroundColor = _overlayColor;
    }
}

@end
