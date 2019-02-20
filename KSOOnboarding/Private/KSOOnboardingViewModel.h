//
//  KSOOnboardingViewModel.h
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

#import <Foundation/Foundation.h>
#import "KSOOnboardingViewController.h"

@class KSOOnboardingTheme;
@protocol KSOOnboardingViewModelDelegate;

@interface KSOOnboardingViewModel : NSObject

@property (weak,nonatomic) id<KSOOnboardingViewControllerDataSource> dataSource;
@property (weak,nonatomic) id<KSOOnboardingViewControllerDelegate> delegate;

@property (weak,nonatomic) id<KSOOnboardingViewModelDelegate> viewModelDelegate;

@property (strong,nonatomic) KSOOnboardingTheme *theme;

@property (copy,nonatomic) NSString *dismissButtonTitle;

@property (readonly,nonatomic) NSInteger numberOfOnboardingItems;

- (KSOOnboardingItem *)onboardingItemAtIndex:(NSInteger)index;
- (NSInteger)indexOfOnboardingItem:(KSOOnboardingItem *)onboardingItem;
- (UIViewController<KSOOnboardingItemViewController> *)viewControllerForOnboardingItem:(KSOOnboardingItem *)onboardingItem;

- (BOOL)canDismissForOnboardingItem:(KSOOnboardingItem *)onboardingItem;
- (void)dismissAnimated:(BOOL)animated completion:(KSTVoidBlock)completion;

@end

@protocol KSOOnboardingViewModelDelegate <NSObject>
@required
- (KSOOnboardingViewController *)onboardingViewControllerForOnboardingViewModel:(KSOOnboardingViewModel *)viewModel;
@end
