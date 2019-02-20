//
//  KSOOnboardingItemDefaultViewController.m
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

#import "KSOOnboardingDefaultItemViewController.h"
#import "KSOOnboardingTheme.h"

#import <Ditko/Ditko.h>
#import <Stanley/Stanley.h>

@interface KSOOnboardingDefaultItemViewController ()
@property (strong,nonatomic) UIStackView *stackView;
@property (strong,nonatomic) UIImageView *imageView;
@property (strong,nonatomic) UILabel *headlineLabel;
@property (strong,nonatomic) UILabel *bodyLabel;
@property (strong,nonatomic) UIButton *actionButton;
@end

@implementation KSOOnboardingDefaultItemViewController

- (void)dealloc {
    KSTLogObject(self.class);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    kstWeakify(self);
    
    self.view.backgroundColor = UIColor.clearColor;
    
    self.stackView = [[UIStackView alloc] initWithFrame:CGRectZero];
    self.stackView.translatesAutoresizingMaskIntoConstraints = NO;
    self.stackView.axis = UILayoutConstraintAxisVertical;
    self.stackView.alignment = UIStackViewAlignmentCenter;
    self.stackView.distribution = UIStackViewDistributionEqualSpacing;
    self.stackView.spacing = self.onboardingTheme.itemSubviewVerticalSpacing;
    [self.view addSubview:self.stackView];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.imageView.tintColor = self.onboardingTheme.imageColor;
    self.imageView.image = self.onboardingItem.image;
    [self.stackView addArrangedSubview:self.imageView];
    
    self.headlineLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.headlineLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.headlineLabel.numberOfLines = 0;
    self.headlineLabel.textAlignment = NSTextAlignmentCenter;
    self.headlineLabel.font = self.onboardingTheme.headlineFont;
    self.headlineLabel.KDI_dynamicTypeTextStyle = self.onboardingTheme.headlineTextStyle;
    self.headlineLabel.textColor = self.onboardingTheme.headlineColor;
    self.headlineLabel.text = self.onboardingItem.headline;
    [self.stackView addArrangedSubview:self.headlineLabel];
    
    self.bodyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.bodyLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.bodyLabel.numberOfLines = 0;
    self.bodyLabel.textAlignment = NSTextAlignmentCenter;
    self.bodyLabel.font = self.onboardingTheme.bodyFont;
    self.bodyLabel.KDI_dynamicTypeTextStyle = self.onboardingTheme.bodyTextStyle;
    self.bodyLabel.textColor = self.onboardingTheme.bodyColor;
    self.bodyLabel.text = self.onboardingItem.body;
    [self.stackView addArrangedSubview:self.bodyLabel];
    
    self.actionButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.actionButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.actionButton.tintColor = self.onboardingTheme.actionColor;
    self.actionButton.titleLabel.font = self.onboardingTheme.actionFont;
    self.actionButton.titleLabel.KDI_dynamicTypeTextStyle = self.onboardingTheme.actionTextStyle;
    [self.actionButton setTitle:self.onboardingItem.action forState:UIControlStateNormal];
    [self.actionButton KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        if (self.onboardingItem.actionBlock != nil) {
            self.onboardingItem.actionBlock(self.onboardingItem);
        }
    } forControlEvents:UIControlEventTouchUpInside];
    [self.stackView addArrangedSubview:self.actionButton];
    
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[view]-|" options:0 metrics:nil views:@{@"view": self.stackView}]];
    [NSLayoutConstraint activateConstraints:@[[self.stackView.topAnchor constraintGreaterThanOrEqualToSystemSpacingBelowAnchor:self.view.safeAreaLayoutGuide.topAnchor multiplier:1.0], [self.view.safeAreaLayoutGuide.bottomAnchor constraintGreaterThanOrEqualToSystemSpacingBelowAnchor:self.stackView.bottomAnchor multiplier:1.0], [self.stackView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor]]];
    
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:@{@"view": self.headlineLabel}]];
    
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:@{@"view": self.bodyLabel}]];
}

@synthesize onboardingItem=_onboardingItem;
@synthesize onboardingTheme=_onboardingTheme;

@end
