//
//  KSOOnboardingViewModel.m
//  KSOOnboarding-iOS
//
//  Created by William Towe on 9/6/18.
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

#import "KSOOnboardingViewModel.h"
#import "KSOOnboardingDefaultItemViewController.h"
#import "KSOOnboardingTheme.h"
#import "NSBundle+KSOOnboardingPrivateExtensions.h"

#import <Stanley/Stanley.h>

@interface KSOOnboardingViewModel ()
@property (class,readonly,nonatomic) NSString *defaultDismissButtonTitle;
@end

@implementation KSOOnboardingViewModel

- (instancetype)init; {
    if (!(self = [super init]))
        return nil;
    
    _theme = KSOOnboardingTheme.defaultTheme;
    _dismissButtonTitle = KSOOnboardingViewModel.defaultDismissButtonTitle;
    
    return self;
}

- (KSOOnboardingItem *)onboardingItemAtIndex:(NSInteger)index {
    return [self.dataSource onboardingViewController:[self.viewModelDelegate onboardingViewControllerForOnboardingViewModel:self] onboardingItemAtIndex:index];
}
- (NSInteger)indexOfOnboardingItem:(KSOOnboardingItem *)onboardingItem {
    NSInteger retval = NSNotFound;
    
    for (NSInteger i=0; i<self.numberOfOnboardingItems; i++) {
        KSOOnboardingItem *item = [self onboardingItemAtIndex:i];
        
        if ([item isEqual:onboardingItem]) {
            retval = i;
            break;
        }
    }
    
    return retval;
}
- (UIViewController<KSOOnboardingItemViewController> *)viewControllerForOnboardingItem:(KSOOnboardingItem *)onboardingItem {
    UIViewController<KSOOnboardingItemViewController> *retval = nil;
    
    if ([self.delegate respondsToSelector:@selector(onboardingViewController:viewControllerForOnboardingItem:)]) {
        retval = [self.delegate onboardingViewController:[self.viewModelDelegate onboardingViewControllerForOnboardingViewModel:self] viewControllerForOnboardingItem:onboardingItem];
    }
    
    if (retval == nil) {
        retval = [[KSOOnboardingDefaultItemViewController alloc] initWithNibName:nil bundle:nil];
    }
    
    retval.onboardingItem = onboardingItem;
    
    if ([retval respondsToSelector:@selector(setOnboardingTheme:)]) {
        retval.onboardingTheme = self.theme;
    }
    
    return retval;
}

- (BOOL)canDismissForOnboardingItem:(KSOOnboardingItem *)onboardingItem; {
    if ([self.delegate respondsToSelector:@selector(onboardingViewController:canDismissForOnboardingItem:)]) {
        return [self.delegate onboardingViewController:[self.viewModelDelegate onboardingViewControllerForOnboardingViewModel:self] canDismissForOnboardingItem:onboardingItem];
    }
    return YES;
}
- (void)dismissAnimated:(BOOL)animated completion:(KSTVoidBlock)completion; {
    if ([self.delegate respondsToSelector:@selector(onboardingViewControllerWillDismiss:)]) {
        [self.delegate onboardingViewControllerWillDismiss:[self.viewModelDelegate onboardingViewControllerForOnboardingViewModel:self]];
    }
    
    [[self.viewModelDelegate onboardingViewControllerForOnboardingViewModel:self].presentingViewController dismissViewControllerAnimated:animated completion:^{
        if ([self.delegate respondsToSelector:@selector(onboardingViewControllerDidDismiss:)]) {
            [self.delegate onboardingViewControllerDidDismiss:[self.viewModelDelegate onboardingViewControllerForOnboardingViewModel:self]];
        }
        
        if (completion != nil) {
            completion();
        }
    }];
}

- (void)setTheme:(KSOOnboardingTheme *)theme {
    _theme = theme ?: KSOOnboardingTheme.defaultTheme;
}

- (void)setDismissButtonTitle:(NSString *)dismissButtonTitle {
    _dismissButtonTitle = dismissButtonTitle ?: KSOOnboardingViewModel.defaultDismissButtonTitle;
}

- (NSInteger)numberOfOnboardingItems {
    return [self.dataSource numberOfOnboardingItemsForOnboardingViewController:[self.viewModelDelegate onboardingViewControllerForOnboardingViewModel:self]];
}

+ (NSString *)defaultDismissButtonTitle {
    return NSLocalizedStringWithDefaultValue(@"dismiss.button.title", nil, NSBundle.KSO_onboardingFrameworkBundle, @"Dismiss", @"dismiss button title");
}

@end
