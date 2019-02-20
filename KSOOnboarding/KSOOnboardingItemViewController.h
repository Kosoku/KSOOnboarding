//
//  KSOOnboardingItemViewController.h
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
#import <KSOOnboarding/KSOOnboardingItem.h>

@class KSOOnboardingTheme;

/**
 Protocol for an onboarding item view controller. A conforming instance is responsible for a single screen within a KSOOnboardingViewController.
 */
@protocol KSOOnboardingItemViewController <NSObject>
@required
/**
 Set and get the KSOOnboardingItem that the conforming instance represents.
 
 @see KSOOnboardingItem
 */
@property (strong,nonatomic) __kindof KSOOnboardingItem *onboardingItem;
@optional
/**
 Set and get the KSOOnboardingTheme that the conforming instance can use to control its appearance.
 
 @see KSOOnboardingTheme
 */
@property (strong,nonatomic) KSOOnboardingTheme *onboardingTheme;
@end
