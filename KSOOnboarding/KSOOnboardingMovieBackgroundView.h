//
//  KSOOnboardingMovieBackgroundView.h
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

#import <UIKit/UIKit.h>
#import <AVFoundation/AVAsset.h>

NS_ASSUME_NONNULL_BEGIN

/**
 KSOOnboardingMovieBackgroundView manages an AVAsset and plays its video on a continuous loop. It can apply a blur and/or a overlay color on top the video content.
 */
@interface KSOOnboardingMovieBackgroundView : UIView

/**
 Set and get the blur effect applied to the video.
 
 The default is nil.
 */
@property (strong,nonatomic,nullable) UIBlurEffect *blurEffect;
/**
 Set and get the overlay color layered on top the video and blur, if set.
 
 The default is nil.
 */
@property (strong,nonatomic,nullable) UIColor *overlayColor;
/**
 Set and get whether the video content is muted.
 
 The default is NO.
 */
@property (assign,nonatomic,getter=isMuted) BOOL muted;

/**
 Create and return an instance with the provided video asset.
 
 @param asset The video asset to display
 @return The initialized instance
 */
- (instancetype)initWithAsset:(AVAsset *)asset NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
