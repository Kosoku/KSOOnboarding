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

@interface KSOOnboardingTheme : NSObject <NSCopying>

/**
 Set and get the default onboarding theme.
 */
@property (class,strong,nonatomic,null_resettable) KSOOnboardingTheme *defaultTheme;

/**
 The identifier of the theme.
 */
@property (readonly,copy,nonatomic) NSString *identifier;

@property (strong,nonatomic,nullable) UIColor *imageColor;
@property (strong,nonatomic,null_resettable) UIColor *headlineColor;
@property (strong,nonatomic,null_resettable) UIColor *bodyColor;
@property (strong,nonatomic,nullable) UIColor *actionColor;

@property (strong,nonatomic,null_resettable) UIFont *headlineFont;
@property (strong,nonatomic,null_resettable) UIFont *bodyFont;
@property (strong,nonatomic,null_resettable) UIFont *actionFont;

@property (copy,nonatomic,nullable) UIFontTextStyle headlineTextStyle;
@property (copy,nonatomic,nullable) UIFontTextStyle bodyTextStyle;
@property (copy,nonatomic,nullable) UIFontTextStyle actionTextStyle;

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
