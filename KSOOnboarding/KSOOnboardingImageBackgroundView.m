//
//  KSOOnboardingImageBackgroundView.m
//  KSOOnboarding-iOS
//
//  Created by William Towe on 9/7/18.
//  Copyright © 2018 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "KSOOnboardingImageBackgroundView.h"

#import <Loki/Loki.h>

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
