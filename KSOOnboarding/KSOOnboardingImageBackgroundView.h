//
//  KSOOnboardingImageBackgroundView.h
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
