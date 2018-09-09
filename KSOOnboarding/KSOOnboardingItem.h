//
//  KSOOnboardingItemModel.h
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
