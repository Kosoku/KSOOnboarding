//
//  KSOOnboardingMovieBackgroundView.m
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

#import "KSOOnboardingMovieBackgroundView.h"

#import <Stanley/Stanley.h>
#import <Agamotto/Agamotto.h>

#import <AVFoundation/AVFoundation.h>

@interface KSOOnboardingMovieBackgroundContentView : UIView
@property (readonly,nonatomic) AVPlayerLayer *layer;

- (instancetype)initWithPlayer:(AVPlayer *)player;
@end

@implementation KSOOnboardingMovieBackgroundContentView
- (instancetype)initWithPlayer:(AVPlayer *)player {
    if (!(self = [super initWithFrame:CGRectZero]))
        return nil;
    
    kstWeakify(self);
    kstWeakify(player);
    
    self.alpha = 0.0;
    
    self.layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.layer.player = player;
    
    [self.layer KAG_addObserverForKeyPath:@kstKeypath(self.layer,readyForDisplay) options:NSKeyValueObservingOptionInitial block:^(NSString * _Nonnull keyPath, id  _Nullable value, NSDictionary<NSKeyValueChangeKey,id> * _Nonnull change) {
        kstStrongify(self);
        kstStrongify(player);
        
        if (self.layer.isReadyForDisplay &&
            self.alpha == 0.0) {
            
            [player play];
            
            [UIView animateWithDuration:0.33 animations:^{
                kstStrongify(self);
                
                self.alpha = 1.0;
            }];
        }
    }];
    
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

- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

- (void)didAddSubview:(UIView *)subview {
    [super didAddSubview:subview];
    
    if (self.overlayView != nil) {
        [self bringSubviewToFront:self.overlayView];
    }
}

- (instancetype)initWithAsset:(AVAsset *)asset {
    if (!(self = [super initWithFrame:CGRectZero]))
        return nil;
    
    _player = [[AVPlayer alloc] initWithPlayerItem:[AVPlayerItem playerItemWithAsset:asset]];
    _player.actionAtItemEnd = AVPlayerActionAtItemEndPause;
    
    _contentView = [[KSOOnboardingMovieBackgroundContentView alloc] initWithPlayer:_player];
    _contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_contentView];
    
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:@{@"view": _contentView}]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:@{@"view": _contentView}]];
    
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(_didPlayToEndTime:) name:AVPlayerItemDidPlayToEndTimeNotification object:_player.currentItem];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(_didPlayToEndTime:) name:AVPlayerItemFailedToPlayToEndTimeNotification object:_player.currentItem];
    
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

- (void)_didPlayToEndTime:(NSNotification *)note {
    [self.player seekToTime:kCMTimeZero];
    [self.player play];
}

@end
