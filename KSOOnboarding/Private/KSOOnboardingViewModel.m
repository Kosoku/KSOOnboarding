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

#import <Stanley/Stanley.h>

@interface KSOOnboardingViewModel ()
@property (copy,nonatomic) NSArray<id<KSOOnboardingItem>> *onboardingItems;
@property (weak,nonatomic) KSOOnboardingViewController *onboardingViewController;
@end

@implementation KSOOnboardingViewModel

- (instancetype)initWithOnboardingItems:(NSArray<id<KSOOnboardingItem>> *)onboardingItems onboardingViewController:(KSOOnboardingViewController *)onboardingViewController {
    if (!(self = [super init]))
        return nil;
    
    _onboardingItems = [onboardingItems copy];
    _onboardingViewController = onboardingViewController;
    
    return self;
}

- (id<KSOOnboardingItem>)onboardingItemAtIndex:(NSInteger)index {
    if (KSTIsEmptyObject(self.onboardingItems)) {
        return [self.dataSource onboardingViewController:self.onboardingViewController onboardingItemAtIndex:index];
    }
    else {
        return self.onboardingItems[index];
    }
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
