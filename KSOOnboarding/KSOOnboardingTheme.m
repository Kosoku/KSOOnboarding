//
//  KSOOnboardingTheme.m
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

#import "KSOOnboardingTheme.h"

#import <Ditko/Ditko.h>

#import <objc/runtime.h>

@interface KSOOnboardingTheme ()
@property (class,readonly,nonatomic) UIColor *defaultImageColor;
@property (class,readonly,nonatomic) UIColor *defaultHeadlineColor;
@property (class,readonly,nonatomic) UIColor *defaultBodyColor;

@property (class,readonly,nonatomic) UIFont *defaultHeadlineFont;
@property (class,readonly,nonatomic) UIFont *defaultBodyFont;
@property (class,readonly,nonatomic) UIFont *defaultActionFont;

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
    
    retval->_headlineFont = _headlineFont;
    retval->_bodyFont = _bodyFont;
    retval->_actionFont = _actionFont;
    
    retval->_headlineTextStyle = _headlineTextStyle;
    retval->_bodyTextStyle = _bodyTextStyle;
    retval->_actionTextStyle = _actionTextStyle;
    
    retval->_itemSubviewVerticalSpacing = _itemSubviewVerticalSpacing;
    
    return retval;
}

- (instancetype)initWithIdentifier:(NSString *)identifier {
    if (!(self = [super init]))
        return nil;
    
    _identifier = [identifier copy];
    
    _imageColor = KSOOnboardingTheme.defaultImageColor;
    _headlineColor = KSOOnboardingTheme.defaultHeadlineColor;
    _bodyColor = KSOOnboardingTheme.defaultBodyColor;
    
    _headlineFont = KSOOnboardingTheme.defaultHeadlineFont;
    _bodyFont = KSOOnboardingTheme.defaultBodyFont;
    _actionFont = KSOOnboardingTheme.defaultActionFont;
    
    _headlineTextStyle = UIFontTextStyleHeadline;
    _bodyTextStyle = UIFontTextStyleBody;
    _actionTextStyle = UIFontTextStyleCallout;
    
    _itemSubviewVerticalSpacing = 8.0;
    
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

- (void)setHeadlineFont:(UIFont *)headlineFont {
    _headlineFont = headlineFont ?: KSOOnboardingTheme.defaultHeadlineFont;
}
- (void)setBodyFont:(UIFont *)bodyFont {
    _bodyFont = bodyFont ?: KSOOnboardingTheme.defaultBodyFont;
}
- (void)setActionFont:(UIFont *)actionFont {
    _actionFont = actionFont ?: KSOOnboardingTheme.defaultActionFont;
}

+ (UIColor *)defaultImageColor {
    return UIColor.blackColor;
}
+ (UIColor *)defaultHeadlineColor {
    return UIColor.blackColor;
}
+ (UIColor *)defaultBodyColor {
    return KDIColorW(0.1);
}

+ (UIFont *)defaultHeadlineFont {
    return [UIFont boldSystemFontOfSize:17.0];
}
+ (UIFont *)defaultBodyFont {
    return [UIFont systemFontOfSize:17.0];
}
+ (UIFont *)defaultActionFont {
    return [UIFont systemFontOfSize:15.0];
}

@end
