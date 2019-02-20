//
//  KSOOnboardingItemModel.m
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

#import "KSOOnboardingItem.h"

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
