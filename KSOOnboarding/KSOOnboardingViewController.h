//
//  KSOOnboardingViewController.h
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

#import <UIKit/UIKit.h>
#import <KSOOnboarding/KSOOnboardingItem.h>
#import <KSOOnboarding/KSOOnboardingItemViewController.h>
#import <Stanley/KSTDefines.h>

NS_ASSUME_NONNULL_BEGIN

@class KSOOnboardingTheme;
@protocol KSOOnboardingViewControllerDataSource;
@protocol KSOOnboardingViewControllerDelegate;

@interface KSOOnboardingViewController : UIViewController

@property (weak,nonatomic,nullable) id<KSOOnboardingViewControllerDataSource> dataSource;
@property (weak,nonatomic,nullable) id<KSOOnboardingViewControllerDelegate> delegate;

@property (strong,nonatomic,null_resettable) KSOOnboardingTheme *theme;

@property (copy,nonatomic,null_resettable) NSString *dismissButtonTitle;

- (void)dismissOnboardingViewControllerAnimated:(BOOL)animated completion:(nullable KSTVoidBlock)completion;

- (void)gotoNextOnboardingItemAnimated:(BOOL)animated;
- (void)gotoPreviousOnboardingItemAnimated:(BOOL)animated;
- (void)gotoOnboardingItem:(__kindof KSOOnboardingItem *)onboardingItem animated:(BOOL)animated;

@end

@protocol KSOOnboardingViewControllerDataSource <NSObject>
@required
- (NSInteger)numberOfOnboardingItemsForOnboardingViewController:(__kindof KSOOnboardingViewController *)viewController;
- (__kindof KSOOnboardingItem *)onboardingViewController:(__kindof KSOOnboardingViewController *)viewController onboardingItemAtIndex:(NSInteger)index;
@end

@protocol KSOOnboardingViewControllerDelegate <NSObject>
@optional
- (nullable __kindof UIViewController<KSOOnboardingItemViewController> *)onboardingViewController:(__kindof KSOOnboardingViewController *)viewController viewControllerForOnboardingItem:(__kindof KSOOnboardingItem *)onboardingItem;

- (nullable __kindof UIView *)backgroundViewForOnboardingViewController:(__kindof KSOOnboardingViewController *)viewController;

- (BOOL)onboardingViewController:(__kindof KSOOnboardingViewController *)viewController canDismissForOnboardingItem:(__kindof KSOOnboardingItem *)onboardingItem;

- (void)onboardingViewControllerWillDismiss:(__kindof KSOOnboardingViewController *)viewController;
- (void)onboardingViewControllerDidDismiss:(__kindof KSOOnboardingViewController *)viewController;
@end

NS_ASSUME_NONNULL_END
