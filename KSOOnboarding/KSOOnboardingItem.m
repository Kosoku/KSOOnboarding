//
//  KSOOnboardingItemModel.m
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

#import "KSOOnboardingItem.h"
#import "KSOOnboardingItem+KSOOnboardingPrivateExtensions.h"

KSOOnboardingItemKey const KSOOnboardingItemKeyImage = @"image";
KSOOnboardingItemKey const KSOOnboardingItemKeyHeadline = @"headline";
KSOOnboardingItemKey const KSOOnboardingItemKeyBody = @"body";
KSOOnboardingItemKey const KSOOnboardingItemKeyAction = @"action";
KSOOnboardingItemKey const KSOOnboardingItemKeyActionBlock = @"actionBlock";
KSOOnboardingItemKey const KSOOnboardingItemKeyViewDidAppearBlock = @"viewDidAppearBlock";

@interface KSOOnboardingItem ()
@property (readwrite,strong,nonatomic) UIImage *image;
@property (readwrite,copy,nonatomic) NSString *headline;
@property (readwrite,copy,nonatomic) NSString *body;
@property (readwrite,copy,nonatomic) NSString *action;
@property (readwrite,copy,nonatomic) KSOOnboardingItemBlock actionBlock;
@property (readwrite,copy,nonatomic) KSOOnboardingItemBlock viewDidAppearBlock;

@property (assign,nonatomic) NSInteger onboardingItemIndex;
@end

@implementation KSOOnboardingItem

- (instancetype)initWithDictionary:(NSDictionary<KSOOnboardingItemKey,id> *)dictionary {
    if (!(self = [super init]))
        return nil;
    
    _image = dictionary[KSOOnboardingItemKeyImage];
    _headline = dictionary[KSOOnboardingItemKeyHeadline];
    _body = dictionary[KSOOnboardingItemKeyBody];
    _action = dictionary[KSOOnboardingItemKeyAction];
    _actionBlock = dictionary[KSOOnboardingItemKeyActionBlock];
    _viewDidAppearBlock = dictionary[KSOOnboardingItemKeyViewDidAppearBlock];
    
    return self;
}

+ (instancetype)onboardingItemWithDictionary:(NSDictionary<KSOOnboardingItemKey,id> *)dictionary {
    return [[self alloc] initWithDictionary:dictionary];
}

@end
