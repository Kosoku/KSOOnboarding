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

/**
 KSOOnboardingViewController provides a way to onboard new users.
 */
@interface KSOOnboardingViewController : UIViewController

/**
 Set and get the data source.
 
 @see KSOOnboardingViewControllerDataSource
 */
@property (weak,nonatomic,nullable) id<KSOOnboardingViewControllerDataSource> dataSource;
/**
 Set and get the delegate.
 
 @see KSOOnboardingViewControllerDelegate
 */
@property (weak,nonatomic,nullable) id<KSOOnboardingViewControllerDelegate> delegate;

/**
 Set and get the theme, which controls the appearance of the receiver.
 
 The default is KSOOnboardingTheme.defaultTheme.
 
 @see KSOOnboardingTheme
 */
@property (strong,nonatomic,null_resettable) KSOOnboardingTheme *theme;

/**
 Set and get the dismiss button title. This allows the user to dismiss the receiver.
 
 The default is @"Dismiss";
 */
@property (copy,nonatomic,null_resettable) NSString *dismissButtonTitle;

/**
 Dismiss the receiver, optionally *animated* and invoke the *completion* block when the animation completes. You should use this method to dismiss the receiver programatically, to ensure the requisite delegate methods are called.
 
 @param animated Whether to animate the dismissal animation
 @param completion The block to invoke when the dismissal animation completes
 */
- (void)dismissOnboardingViewControllerAnimated:(BOOL)animated completion:(nullable KSTVoidBlock)completion;

/**
 Navigate to the next onboarding item, optionally *animated*.
 
 @param animated Whether to animate the transition
 */
- (void)gotoNextOnboardingItemAnimated:(BOOL)animated;
/**
 Navigate to the previous onboarding item, optionally *animated*.
 
 @param animated Whether to animate the transition
 */
- (void)gotoPreviousOnboardingItemAnimated:(BOOL)animated;
/**
 Navigate to the provided *onboardingItem*, optionally *animated*.
 
 @param onboardingItem The onboarding item to navigate to
 @param animated Whether to animate the transition
 */
- (void)gotoOnboardingItem:(__kindof KSOOnboardingItem *)onboardingItem animated:(BOOL)animated;

@end

@protocol KSOOnboardingViewControllerDataSource <NSObject>
@required
/**
 Return the number of onboarding items for the onboarding view controller.
 
 @param viewController The sender of the message
 @return The number of onboarding items
 */
- (NSInteger)numberOfOnboardingItemsForOnboardingViewController:(__kindof KSOOnboardingViewController *)viewController;
/**
 Return the KSOOnboardingItem for the provided *index*.
 
 @param viewController The sender of the message
 @param index The index for which to return the KSOOnboardingItem
 @return The KSOOnboardingItem instance
 */
- (__kindof KSOOnboardingItem *)onboardingViewController:(__kindof KSOOnboardingViewController *)viewController onboardingItemAtIndex:(NSInteger)index;
@end

@protocol KSOOnboardingViewControllerDelegate <NSObject>
@optional
/**
 Return the background view for the onboarding view controller. The view will remain fixed behind the onboarding item view controller's as the user navigates through them.
 
 @param viewController The sender of the message
 @return The background view or nil
 @see KSOOnboardingImageBackgroundView
 @see KSOOnboardingMovieBackgroundView
 */
- (nullable __kindof UIView *)backgroundViewForOnboardingViewController:(__kindof KSOOnboardingViewController *)viewController;

/**
 Return the view controller for the provided *onboardingItem* or nil to use the default view controller.
 
 @param viewController The sender of the message
 @param onboardingItem The onboarding item for which to return a view controller or nil
 @return The view controller or nil
 */
- (nullable __kindof UIViewController<KSOOnboardingItemViewController> *)onboardingViewController:(__kindof KSOOnboardingViewController *)viewController viewControllerForOnboardingItem:(__kindof KSOOnboardingItem *)onboardingItem;

/**
 Return whether the dismiss button should be enabled for the provided *onboardingItem*.
 
 @param viewController The sender of the message
 @param onboardingItem The onboarding item for which to return the enabledness of the dismiss button
 @return Whether the dismiss button should be enabled
 */
- (BOOL)onboardingViewController:(__kindof KSOOnboardingViewController *)viewController canDismissForOnboardingItem:(__kindof KSOOnboardingItem *)onboardingItem;

/**
 Called when the onboarding view controller is about to be dismissed.
 
 @param viewController The sender of the message
 */
- (void)onboardingViewControllerWillDismiss:(__kindof KSOOnboardingViewController *)viewController;
/**
 Called immediately after the onboarding view controller is about to be dismissed.
 
 @param viewController The sender of the message
 */
- (void)onboardingViewControllerDidDismiss:(__kindof KSOOnboardingViewController *)viewController;
@end

NS_ASSUME_NONNULL_END
