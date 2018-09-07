//
//  KSOOnboardingTheme.m
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

#import "KSOOnboardingTheme.h"

#import <Ditko/Ditko.h>

#import <objc/runtime.h>

@interface KSOOnboardingTheme ()
@property (class,readonly,nonatomic) UIColor *defaultImageColor;
@property (class,readonly,nonatomic) UIColor *defaultHeadlineColor;
@property (class,readonly,nonatomic) UIColor *defaultBodyColor;
@end

@implementation KSOOnboardingTheme

- (NSUInteger)hash {
    return self.identifier.hash;
}
- (BOOL)isEqual:(id)object {
    return (self == object ||
            ([object isKindOfClass:KSOOnboardingTheme.class] && [self.identifier isEqualToString:[object identifier]]));
}

- (id)copyWithZone:(NSZone *)zone {
    KSOOnboardingTheme *retval = [[KSOOnboardingTheme alloc] initWithIdentifier:[NSString stringWithFormat:@"%@.copy",self.identifier]];
    
    retval->_imageColor = _imageColor;
    retval->_headlineColor = _headlineColor;
    retval->_bodyColor = _bodyColor;
    retval->_actionColor = _actionColor;
    
    return retval;
}

- (instancetype)initWithIdentifier:(NSString *)identifier {
    if (!(self = [super init]))
        return nil;
    
    _identifier = [identifier copy];
    
    _imageColor = KSOOnboardingTheme.defaultImageColor;
    _headlineColor = KSOOnboardingTheme.defaultHeadlineColor;
    _bodyColor = KSOOnboardingTheme.defaultBodyColor;
    
    return self;
}

static void const *kDefaultThemeKey = &kDefaultThemeKey;
+ (KSOOnboardingTheme *)defaultTheme {
    return objc_getAssociatedObject(self, kDefaultThemeKey) ?: [[KSOOnboardingTheme alloc] initWithIdentifier:@"com.kosoku.ksoonboarding.theme.default"];
}
+ (void)setDefaultTheme:(KSOOnboardingTheme *)defaultTheme {
    objc_setAssociatedObject(self, kDefaultThemeKey, defaultTheme, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setHeadlineColor:(UIColor *)headlineColor {
    _headlineColor = headlineColor ?: KSOOnboardingTheme.defaultHeadlineColor;
}
- (void)setBodyColor:(UIColor *)bodyColor {
    _bodyColor = bodyColor ?: KSOOnboardingTheme.defaultBodyColor;
}

+ (UIColor *)defaultImageColor {
    return UIColor.blackColor;
}
+ (UIColor *)defaultHeadlineColor {
    return UIColor.blackColor;
}
+ (UIColor *)defaultBodyColor {
    return KDIColorW(0.9);
}

@end
