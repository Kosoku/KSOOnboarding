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

NS_ASSUME_NONNULL_BEGIN

typedef NSString* KSOOnboardingItemKey NS_STRING_ENUM;

FOUNDATION_EXTERN KSOOnboardingItemKey const KSOOnboardingItemKeyImage;
FOUNDATION_EXTERN KSOOnboardingItemKey const KSOOnboardingItemKeyHeadline;
FOUNDATION_EXTERN KSOOnboardingItemKey const KSOOnboardingItemKeyBody;
FOUNDATION_EXTERN KSOOnboardingItemKey const KSOOnboardingItemKeyAction;
FOUNDATION_EXTERN KSOOnboardingItemKey const KSOOnboardingItemKeyActionBlock;
FOUNDATION_EXTERN KSOOnboardingItemKey const KSOOnboardingItemKeyViewDidAppearBlock;

@class KSOOnboardingItem;

typedef void(^KSOOnboardingItemBlock)(__kindof KSOOnboardingItem *item);

@interface KSOOnboardingItem : NSObject

@property (readonly,strong,nonatomic,nullable) UIImage *image;
@property (readonly,copy,nonatomic,nullable) NSString *headline;
@property (readonly,copy,nonatomic,nullable) NSString *body;
@property (readonly,copy,nonatomic,nullable) NSString *action;
@property (readonly,copy,nonatomic,nullable) KSOOnboardingItemBlock actionBlock;
@property (readonly,copy,nonatomic,nullable) KSOOnboardingItemBlock viewDidAppearBlock;

- (instancetype)initWithDictionary:(NSDictionary<KSOOnboardingItemKey, id> *)dictionary NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

+ (instancetype)onboardingItemModelWithDictionary:(NSDictionary<KSOOnboardingItemKey, id> *)dictionary;

@end

NS_ASSUME_NONNULL_END
