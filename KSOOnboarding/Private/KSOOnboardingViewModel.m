//
//  KSOOnboardingViewModel.m
//  KSOOnboarding-iOS
//
//  Created by William Towe on 9/6/18.
//  Copyright © 2018 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "KSOOnboardingViewModel.h"
#import "KSOOnboardingDefaultItemViewController.h"
#import "KSOOnboardingTheme.h"

#import <Stanley/Stanley.h>

@interface KSOOnboardingViewModel ()

@end

@implementation KSOOnboardingViewModel

- (instancetype)init; {
    if (!(self = [super init]))
        return nil;
    
    _theme = KSOOnboardingTheme.defaultTheme;
    
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

- (NSInteger)numberOfOnboardingItems {
    return [self.dataSource numberOfOnboardingItemsForOnboardingViewController:[self.viewModelDelegate onboardingViewControllerForOnboardingViewModel:self]];
}

@end
