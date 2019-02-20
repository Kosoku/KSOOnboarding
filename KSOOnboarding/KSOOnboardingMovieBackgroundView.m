//
//  KSOOnboardingMovieBackgroundView.m
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

#import "KSOOnboardingMovieBackgroundView.h"

#import <Stanley/Stanley.h>
#import <Agamotto/Agamotto.h>

#import <AVFoundation/AVFoundation.h>

@interface KSOOnboardingMovieBackgroundContentView : UIView
@property (readonly,nonatomic) AVPlayerLayer *layer;
@property (strong,nonatomic) UIImageView *imageView;

- (instancetype)initWithPlayer:(AVPlayer *)player;
@end

@implementation KSOOnboardingMovieBackgroundContentView
- (instancetype)initWithPlayer:(AVPlayer *)player {
    if (!(self = [super initWithFrame:CGRectZero]))
        return nil;
    
    kstWeakify(self);
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    [self addSubview:self.imageView];
    
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:@{@"view": self.imageView}]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:@{@"view": self.imageView}]];
    
    self.layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.layer.player = player;
    
    [self.layer KAG_addObserverForKeyPath:@kstKeypath(self.layer,readyForDisplay) options:NSKeyValueObservingOptionInitial block:^(NSString * _Nonnull keyPath, id  _Nullable value, NSDictionary<NSKeyValueChangeKey,id> * _Nonnull change) {
        kstStrongify(self);

        if (self.layer.isReadyForDisplay) {
            self.imageView.image = nil;
        }
    }];
    
    AVAssetImageGenerator *imageGenerator = [AVAssetImageGenerator assetImageGeneratorWithAsset:player.currentItem.asset];
    
    imageGenerator.appliesPreferredTrackTransform = YES;
    
    CGImageRef imageRef = [imageGenerator copyCGImageAtTime:kCMTimeZero actualTime:NULL error:NULL];
    
    self.imageView.image = [[UIImage alloc] initWithCGImage:imageRef];
    
    CGImageRelease(imageRef);
    
    return self;
}

+ (Class)layerClass {
    return AVPlayerLayer.class;
}

@dynamic layer;

@end

@interface KSOOnboardingMovieBackgroundView ()
@property (strong,nonatomic) AVPlayer *player;
@property (strong,nonatomic) KSOOnboardingMovieBackgroundContentView *contentView;
@property (strong,nonatomic) UIVisualEffectView *blurVisualEffectView;
@property (strong,nonatomic) UIView *overlayView;
@end

@implementation KSOOnboardingMovieBackgroundView

- (void)didAddSubview:(UIView *)subview {
    [super didAddSubview:subview];
    
    if (self.overlayView != nil) {
        [self bringSubviewToFront:self.overlayView];
    }
}

- (instancetype)initWithAsset:(AVAsset *)asset {
    if (!(self = [super initWithFrame:CGRectZero]))
        return nil;
    
    kstWeakify(self);
    
    _player = [[AVPlayer alloc] initWithPlayerItem:[[AVPlayerItem alloc] initWithAsset:asset]];
    [_player play];
    
    _contentView = [[KSOOnboardingMovieBackgroundContentView alloc] initWithPlayer:_player];
    _contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_contentView];

    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:@{@"view": _contentView}]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:@{@"view": _contentView}]];
    
    [self KAG_addObserverForNotificationNames:@[AVPlayerItemDidPlayToEndTimeNotification, AVPlayerItemFailedToPlayToEndTimeNotification] object:_player.currentItem block:^(NSNotification * _Nonnull notification) {
        kstStrongify(self)
        [self.player seekToTime:kCMTimeZero];
        [self.player play];;
    }];
    
    [self KAG_addObserverForNotificationNames:@[UIApplicationDidBecomeActiveNotification] object:nil block:^(NSNotification * _Nonnull notification) {
        kstStrongify(self);
        [self.player play];
    }];
    
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
- (BOOL)isMuted {
    return self.player.isMuted;
}
- (void)setMuted:(BOOL)muted {
    self.player.muted = muted;
}

@end
