//
//  KSOOnboardingMovieBackgroundView.h
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
