//
//  KSOOnboardingTheme.h
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
 KSOOnboardingTheme controls the appearance of the default onboarding views and can be referenced by custom views and view controllers provided by the client.
 */
@interface KSOOnboardingTheme : NSObject <NSCopying>

/**
 Set and get the default onboarding theme.
 */
@property (class,strong,nonatomic,null_resettable) KSOOnboardingTheme *defaultTheme;

/**
 The identifier of the theme.
 */
@property (readonly,copy,nonatomic) NSString *identifier;

/**
 Set and get the image color used to tint the image of a KSOOnboardingItem.
 
 The default is UIColor.blackColor. Set to nil to use the default tint color.
 */
@property (strong,nonatomic,nullable) UIColor *imageColor;
/**
 Set and get the headline color for the headline text of a KSOOnboardingItem.
 
 The default is UIColor.blackColor.
 */
@property (strong,nonatomic,null_resettable) UIColor *headlineColor;
/**
 Set and get the body color for the body text of a KSOOnboardingItem.
 
 The default is KDIColorW(0.1).
 */
@property (strong,nonatomic,null_resettable) UIColor *bodyColor;
/**
 Set and get the action color for the action text of a KSOOnboardingItem.
 
 The default is nil, which means use the default tint color.
 */
@property (strong,nonatomic,nullable) UIColor *actionColor;

/**
 Set and get the headline font for headline text of a KSOOnboardingItem.
 
 The default is [UIFont boldSystemFontOfSize:17.0].
 */
@property (strong,nonatomic,null_resettable) UIFont *headlineFont;
/**
 Set and get the body font for body text of a KSOOnboardingItem.
 
 The default is [UIFont systemFontOfSize:17.0].
 */
@property (strong,nonatomic,null_resettable) UIFont *bodyFont;
/**
 Set and get the action font for the action text of a KSOOnboardingItem.
 
 The default is [UIFont systemFontOfSize:15.0].
 */
@property (strong,nonatomic,null_resettable) UIFont *actionFont;

/**
 Set and get the headline text style for the headline text of a KSOOnboardingItem. Setting this to non-nil is required to take advantage of dynamic type support.
 
 The default is UIFontTextStyleHeadline.
 */
@property (copy,nonatomic,nullable) UIFontTextStyle headlineTextStyle;
/**
 Set and get the body text style for the body text of a KSOOnboardingItem. Setting this to non-nil is required to take advantage of dynamic type support.
 
 The default is UIFontTextStyleBody.
 */
@property (copy,nonatomic,nullable) UIFontTextStyle bodyTextStyle;
/**
 Set and get the action text style for the action text of a KSOOnboardingItem. Setting this to non-nil is required to take advantage of dynamic type support.
 
 The default is UIFontTextStyleCallout.
 */
@property (copy,nonatomic,nullable) UIFontTextStyle actionTextStyle;

/**
 Set and get the vertical spacing between item subviews (e.g. image, headline, body).
 
 The default is 8.0.
 */
@property (assign,nonatomic) CGFloat itemSubviewVerticalSpacing;

/**
 The designated initializer.
 
 @param identifier The identifier of the receiver
 @return The initialized instance
 */
- (instancetype)initWithIdentifier:(NSString *)identifier NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
