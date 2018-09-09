//
//  KSOOnboardingImageBackgroundView.h
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

NS_ASSUME_NONNULL_BEGIN

/**
 KSOOnboardingImageBackgroundView manages an image and provides methods to blur and/or overlay a color on top the image. It is intended to be returned from the backgroundViewForOnboardingViewController: delegate method.
 */
@interface KSOOnboardingImageBackgroundView : UIView

/**
 Set and get the blur effect applied to the image.
 
 The default is nil.
 */
@property (strong,nonatomic,nullable) UIBlurEffect *blurEffect;
/**
 Set and get the overlay color layered on top the image and blur, if set.
 
 The default is nil.
 */
@property (strong,nonatomic,nullable) UIColor *overlayColor;

/**
 Create and return an instance with the provided image.
 
 @param image The image to display
 @return The initialized instance
 */
- (instancetype)initWithImage:(UIImage *)image NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
