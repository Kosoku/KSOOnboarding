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
#import "KSOOnboardingItem+KSOOnboardingPrivateExtensions.h"

#import <Stanley/Stanley.h>

@interface KSOOnboardingViewModel ()
@property (copy,nonatomic) NSArray<KSOOnboardingItem *> *onboardingItems;
@property (weak,nonatomic) KSOOnboardingViewController *onboardingViewController;
@end

@implementation KSOOnboardingViewModel

- (instancetype)initWithOnboardingItems:(NSArray<KSOOnboardingItem *> *)onboardingItems onboardingViewController:(KSOOnboardingViewController *)onboardingViewController {
    if (!(self = [super init]))
        return nil;
    
    _onboardingItems = [onboardingItems copy];
    _onboardingViewController = onboardingViewController;
    
    return self;
}

- (KSOOnboardingItem *)onboardingItemAtIndex:(NSInteger)index {
    KSOOnboardingItem *retval = nil;
    
    if (KSTIsEmptyObject(self.onboardingItems)) {
        retval = [self.dataSource onboardingViewController:self.onboardingViewController onboardingItemAtIndex:index];
    }
    else {
        retval = self.onboardingItems[index];
    }
    
    retval.onboardingItemIndex = index;
    
    return retval;
}
- (UIViewController<KSOOnboardingItemViewController> *)viewControllerForOnboardingItem:(KSOOnboardingItem *)onboardingItem {
    UIViewController<KSOOnboardingItemViewController> *retval = nil;
    
    if ([self.delegate respondsToSelector:@selector(onboardingViewController:viewControllerForOnboardingItem:)]) {
        retval = [self.delegate onboardingViewController:self.onboardingViewController viewControllerForOnboardingItem:onboardingItem];
    }
    
    if (retval == nil) {
        retval = [[KSOOnboardingDefaultItemViewController alloc] initWithNibName:nil bundle:nil];
        
        retval.onboardingItem = onboardingItem;
    }
    
    return retval;
}

- (BOOL)canDismissForOnboardingItem:(KSOOnboardingItem *)onboardingItem; {
    if ([self.delegate respondsToSelector:@selector(onboardingViewController:canDismissForOnboardingItem:)]) {
        return [self.delegate onboardingViewController:self.onboardingViewController canDismissForOnboardingItem:onboardingItem];
    }
    return YES;
}
- (void)dismiss; {
    if ([self.delegate respondsToSelector:@selector(onboardingViewControllerWillDismiss:)]) {
        [self.delegate onboardingViewControllerWillDismiss:self.onboardingViewController];
    }
    
    [self.onboardingViewController.presentingViewController dismissViewControllerAnimated:YES completion:^{
        if ([self.delegate respondsToSelector:@selector(onboardingViewControllerDidDismiss:)]) {
            [self.delegate onboardingViewControllerDidDismiss:self.onboardingViewController];
        }
    }];
}

- (NSInteger)numberOfOnboardingItems {
    if (KSTIsEmptyObject(self.onboardingItems)) {
        return [self.dataSource numberOfOnboardingItemsForOnboardingViewController:self.onboardingViewController];
    }
    else {
        return self.onboardingItems.count;
    }
}

@end
