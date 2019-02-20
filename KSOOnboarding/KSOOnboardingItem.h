//
//  KSOOnboardingItemModel.h
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

#import <UIKit/UIKit.h>
#import <Stanley/KSTDefines.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Typedef for onboarding item key.
 */
typedef NSString* KSOOnboardingItemKey NS_STRING_ENUM;

/**
 Key for onboarding item image.
 */
FOUNDATION_EXTERN KSOOnboardingItemKey const KSOOnboardingItemKeyImage;
/**
 Key for onboarding item headline text.
 */
FOUNDATION_EXTERN KSOOnboardingItemKey const KSOOnboardingItemKeyHeadline;
/**
 Key for onboarding item body text.
 */
FOUNDATION_EXTERN KSOOnboardingItemKey const KSOOnboardingItemKeyBody;
/**
 Key for onboarding item action text.
 */
FOUNDATION_EXTERN KSOOnboardingItemKey const KSOOnboardingItemKeyAction;
/**
 Key for onboarding item action block that is invoked when the action button is tapped.
 */
FOUNDATION_EXTERN KSOOnboardingItemKey const KSOOnboardingItemKeyActionBlock;
/**
 Key for onboarding item view did appear block that is invoked within the owning item view controller's viewDidAppear: method.
 */
FOUNDATION_EXTERN KSOOnboardingItemKey const KSOOnboardingItemKeyViewDidAppearBlock;

@class KSOOnboardingItem;

/**
 Typedef for a block that is invoked in a variety of situations. The owning KSOOnboardingItem is passed as the only argument.
 
 @param item The owning KSOOnboardingItem
 */
typedef void(^KSOOnboardingItemBlock)(__kindof KSOOnboardingItem *item);

/**
 KSOOnboardingItem represents one screen within an onboarding view controller.
 */
@interface KSOOnboardingItem : NSObject

/**
 Get the onboarding image.
 */
@property (readonly,strong,nonatomic,nullable) UIImage *image;
/**
 Get the onboarding headline text.
 */
@property (readonly,copy,nonatomic,nullable) NSString *headline;
/**
 Get the onboarding body text.
 */
@property (readonly,copy,nonatomic,nullable) NSString *body;
/**
 Get the onboarding action text.
 */
@property (readonly,copy,nonatomic,nullable) NSString *action;
/**
 Get the onboarding action block.
 */
@property (readonly,copy,nonatomic,nullable) KSOOnboardingItemBlock actionBlock;
/**
 Get the onboarding view did appear block.
 */
@property (readonly,copy,nonatomic,nullable) KSOOnboardingItemBlock viewDidAppearBlock;

/**
 Creates and returns a KSOOnboardingItem with values from the provided *dictionary*.
 
 @param dictionary The dictionary to initialize the instance with
 @return The initialized instance
 */
- (instancetype)initWithDictionary:(NSDictionary<KSOOnboardingItemKey, id> *)dictionary NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

/**
 Calls initWithDictionary:, passing *dictionary* respectively.
 
 @param dictionary The dictionary to pass to initWithDictionary:
 @return The initialized instance
 */
+ (instancetype)onboardingItemWithDictionary:(NSDictionary<KSOOnboardingItemKey, id> *)dictionary;

@end

NS_ASSUME_NONNULL_END
